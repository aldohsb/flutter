import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/calorie_entry.dart';

class CalorieProvider extends ChangeNotifier {
  static const String _entriesBoxName = 'calorie_entries';
  static const String _goalBoxName = 'calorie_goal';

  late Box<CalorieEntry> _box;
  late Box<CalorieGoal> _goalBox;

  List<CalorieEntry> _entries = [];
  CalorieGoal _goal = CalorieGoal(dailyTargetKcal: 1500);
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<CalorieEntry> get entries => List.unmodifiable(_entries);
  CalorieGoal get goal => _goal;
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<CalorieEntry>(_entriesBoxName);
    _goalBox = await Hive.openBox<CalorieGoal>(_goalBoxName);
    _loadData();
    _isLoaded = true;
    notifyListeners();
  }

  void _loadData() {
    _entries = _box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    _goal = _goalBox.get('goal') ?? CalorieGoal(dailyTargetKcal: 1500);
    if (_goalBox.get('goal') == null) {
      _goalBox.put('goal', _goal);
    }
  }

  // ── Helpers ──────────────────────────────────────────────
  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<CalorieEntry> entriesForDate(DateTime date) =>
      _entries.where((e) => _sameDay(e.date, date)).toList();

  int totalForDate(DateTime date) =>
      entriesForDate(date).fold(0, (s, e) => s + e.calories);

  // ── Today shortcuts ───────────────────────────────────────
  List<CalorieEntry> get todayEntries => entriesForDate(DateTime.now());
  int get todayTotal => totalForDate(DateTime.now());
  int get dailyTarget => _goal.dailyTargetKcal;
  double get todayPercent =>
      dailyTarget > 0 ? todayTotal / dailyTarget * 100 : 0;

  // ── Monthly / daily summary for stats ────────────────────
  /// Returns list of unique dates that have entries, sorted ascending
  List<DateTime> get datesWithEntries {
    final seen = <String>{};
    final dates = <DateTime>[];
    for (final e in _entries) {
      final key =
          '${e.date.year}-${e.date.month}-${e.date.day}';
      if (seen.add(key)) {
        dates.add(DateTime(e.date.year, e.date.month, e.date.day));
      }
    }
    return dates;
  }

  /// Per-day totals for a date range (inclusive)
  List<DayCalTotal> dailyTotals(DateTime from, DateTime to) {
    final result = <DayCalTotal>[];
    DateTime cursor = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    while (!cursor.isAfter(end)) {
      result.add(DayCalTotal(date: cursor, total: totalForDate(cursor)));
      cursor = cursor.add(const Duration(days: 1));
    }
    return result;
  }

  // ── CRUD ─────────────────────────────────────────────────
  Future<void> addEntry(String foodName, int calories,
      {DateTime? date}) async {
    final entry = CalorieEntry(
      id: _uuid.v4(),
      foodName: foodName,
      calories: calories,
      date: date ?? DateTime.now(),
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

  Future<void> setDailyTarget(int kcal) async {
    _goal.dailyTargetKcal = kcal;
    await _goalBox.put('goal', _goal);
    notifyListeners();
  }

  // ── Export / Import ──────────────────────────────────────
  Map<String, dynamic> exportData() {
    return {
      'entries': _entries
          .map((e) => {
                'id': e.id,
                'foodName': e.foodName,
                'calories': e.calories,
                'date': e.date.toIso8601String(),
              })
          .toList(),
      'dailyTargetKcal': _goal.dailyTargetKcal,
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    final entries = data['entries'] as List<dynamic>? ?? [];
    for (final raw in entries) {
      final map = raw as Map<String, dynamic>;
      final entry = CalorieEntry(
        id: map['id'] as String,
        foodName: map['foodName'] as String,
        calories: map['calories'] as int,
        date: DateTime.parse(map['date'] as String),
      );
      await _box.put(entry.id, entry);
    }
    final target = data['dailyTargetKcal'] as int? ?? 1500;
    await setDailyTarget(target);
    _loadData();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}

class DayCalTotal {
  final DateTime date;
  final int total;
  const DayCalTotal({required this.date, required this.total});
}