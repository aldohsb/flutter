import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/earning_entry.dart';

class EarningProvider extends ChangeNotifier {
  static const String _entriesBoxName = 'earning_entries';
  static const String _goalBoxName = 'earning_goals';

  late Box<EarningEntry> _box;
  late Box<MonthlyEarningGoal> _goalBox;

  List<EarningEntry> _entries = [];
  MonthlyEarningGoal? _goals;
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<EarningEntry> get entries => List.unmodifiable(_entries);
  MonthlyEarningGoal? get goals => _goals;
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<EarningEntry>(_entriesBoxName);
    _goalBox = await Hive.openBox<MonthlyEarningGoal>(_goalBoxName);
    _loadData();
    _isLoaded = true;
    notifyListeners();
  }

  void _loadData() {
    _entries = _box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    _goals = _goalBox.get('goals') ?? MonthlyEarningGoal();
    if (_goalBox.get('goals') == null) {
      _goalBox.put('goals', _goals!);
    }
  }

  // ── Today stats ──────────────────────────────────────────
  List<EarningEntry> get todayEntries {
    final today = DateTime.now();
    return _entries.where((e) {
      return e.date.year == today.year &&
          e.date.month == today.month &&
          e.date.day == today.day;
    }).toList();
  }

  double get todayTotal =>
      todayEntries.fold(0, (sum, e) => sum + e.amount);

  // ── Month stats ──────────────────────────────────────────
  List<EarningEntry> entriesForMonth(int year, int month) {
    return _entries.where((e) {
      return e.date.year == year && e.date.month == month;
    }).toList();
  }

  double totalForMonth(int year, int month) {
    return entriesForMonth(year, month)
        .fold(0, (sum, e) => sum + e.amount);
  }

  // ── All time ─────────────────────────────────────────────
  double get allTimeTotal => _entries.fold(0, (sum, e) => sum + e.amount);

  // ── Monthly summary list ─────────────────────────────────
  /// Returns list of unique year-month combos with totals
  List<Map<String, dynamic>> get monthlySummary {
    final Map<String, double> map = {};
    for (final e in _entries) {
      final key =
          '${e.date.year}-${e.date.month.toString().padLeft(2, '0')}';
      map[key] = (map[key] ?? 0) + e.amount;
    }
    final keys = map.keys.toList()..sort();
    return keys
        .map((k) => {
              'key': k,
              'year': int.parse(k.split('-')[0]),
              'month': int.parse(k.split('-')[1]),
              'total': map[k]!,
            })
        .toList();
  }

  // ── Progress ─────────────────────────────────────────────

  /// Percent of cumulative target reached today
  double? todayProgressPercent() {
    if (_goals == null) return null;
    final today = DateTime.now();
    final cumulativeTarget = _goals!.cumulativeTargetUpTo(today);
    if (cumulativeTarget == 0) return null;

    // Total earned this month up to today
    final monthTotal = totalForMonth(today.year, today.month);
    return (monthTotal / cumulativeTarget) * 100;
  }

  double? monthlyTarget(int year, int month) =>
      _goals?.targetFor(year, month);

  // ── CRUD ─────────────────────────────────────────────────
  Future<void> addEntry(double amount, {String note = ''}) async {
    final entry = EarningEntry(
      id: _uuid.v4(),
      amount: amount,
      note: note,
      date: DateTime.now(),
    );
    await _box.put(entry.id, entry);
    _loadData();
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
    _loadData();
    notifyListeners();
  }

  Future<void> setMonthlyTarget(int year, int month, double target) async {
    _goals ??= MonthlyEarningGoal();
    _goals!.setTarget(year, month, target);
    await _goalBox.put('goals', _goals!);
    notifyListeners();
  }

  // ── Export / Import ──────────────────────────────────────
  Map<String, dynamic> exportData() {
    return {
      'entries': _entries
          .map((e) => {
                'id': e.id,
                'amount': e.amount,
                'note': e.note,
                'date': e.date.toIso8601String(),
              })
          .toList(),
      'goals': _goals?.monthlyTargets ?? {},
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    final entries = data['entries'] as List<dynamic>? ?? [];
    for (final raw in entries) {
      final map = raw as Map<String, dynamic>;
      final entry = EarningEntry(
        id: map['id'] as String,
        amount: (map['amount'] as num).toDouble(),
        note: map['note'] as String? ?? '',
        date: DateTime.parse(map['date'] as String),
      );
      await _box.put(entry.id, entry);
    }
    final goalsData =
        (data['goals'] as Map<String, dynamic>?)?.map(
                (k, v) => MapEntry(k, (v as num).toDouble())) ??
            {};
    _goals = MonthlyEarningGoal(monthlyTargets: goalsData);
    await _goalBox.put('goals', _goals!);
    _loadData();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}
