import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/weight_entry.dart';

class WeightProvider extends ChangeNotifier {
  static const String _entriesBoxName = 'weight_entries';
  static const String _goalBoxName = 'weight_goal';

  late Box<WeightEntry> _box;
  late Box<WeightGoal> _goalBox;

  List<WeightEntry> _entries = [];
  WeightGoal? _goal;
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<WeightEntry> get entries => List.unmodifiable(_entries);
  WeightGoal? get goal => _goal;
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<WeightEntry>(_entriesBoxName);
    _goalBox = await Hive.openBox<WeightGoal>(_goalBoxName);
    _loadData();
    _isLoaded = true;
    notifyListeners();
  }

  void _loadData() {
    _entries = _box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    _goal = _goalBox.get('goal');
  }

  // ── Latest entry ─────────────────────────────────────────
  WeightEntry? get latestEntry =>
      _entries.isEmpty ? null : _entries.last;

  double get currentWeight => latestEntry?.weightKg ?? (_goal?.startWeightKg ?? 0);

  // ── Goal ─────────────────────────────────────────────────
  Future<void> setGoal({
    required double startWeight,
    required double targetWeight,
    required DateTime startDate,
    required int durationDays,
  }) async {
    final g = WeightGoal(
      startWeightKg: startWeight,
      targetWeightKg: targetWeight,
      startDate: startDate,
      durationDays: durationDays,
    );
    await _goalBox.put('goal', g);
    _goal = g;
    notifyListeners();
  }

  // ── Entries ──────────────────────────────────────────────
  Future<void> addEntry(double weightKg) async {
    final entry = WeightEntry(
      id: _uuid.v4(),
      weightKg: weightKg,
      date: DateTime.now(),
    );
    await _box.put(entry.id, entry);
    _loadData();
    notifyListeners();
  }

  /// Adjust today's latest entry by delta
  Future<void> adjustWeight(double delta) async {
    final today = DateTime.now();
    // Find today's entry (if any)
    final todayEntries = _entries.where((e) {
      return e.date.year == today.year &&
          e.date.month == today.month &&
          e.date.day == today.day;
    }).toList();

    if (todayEntries.isNotEmpty) {
      final entry = todayEntries.last;
      entry.weightKg = double.parse(
          (entry.weightKg + delta).toStringAsFixed(1));
      await entry.save();
    } else {
      // Start from latest known weight
      final base = latestEntry?.weightKg ?? (_goal?.startWeightKg ?? 70.0);
      final newWeight = double.parse((base + delta).toStringAsFixed(1));
      await addEntry(newWeight);
      return;
    }
    _loadData();
    notifyListeners();
  }

  // ── Progress ─────────────────────────────────────────────

  /// deviation% = (actual - target) / target * 100
  /// negative = below target (good for weight loss)
  double? deviationPercent(DateTime date) {
    if (_goal == null) return null;
    final target = _goal!.targetForDate(date);
    if (target == 0) return null;
    final actual = currentWeight;
    return ((actual - target) / target) * 100;
  }

  double? targetForToday() => _goal?.targetForDate(DateTime.now());

  // ── Export / Import ──────────────────────────────────────
  Map<String, dynamic> exportData() {
    return {
      'entries': _entries
          .map((e) => {
                'id': e.id,
                'weightKg': e.weightKg,
                'date': e.date.toIso8601String(),
              })
          .toList(),
      'goal': _goal == null
          ? null
          : {
              'startWeightKg': _goal!.startWeightKg,
              'targetWeightKg': _goal!.targetWeightKg,
              'startDate': _goal!.startDate.toIso8601String(),
              'durationDays': _goal!.durationDays,
            },
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    final entries = data['entries'] as List<dynamic>? ?? [];
    for (final raw in entries) {
      final map = raw as Map<String, dynamic>;
      final entry = WeightEntry(
        id: map['id'] as String,
        weightKg: (map['weightKg'] as num).toDouble(),
        date: DateTime.parse(map['date'] as String),
      );
      await _box.put(entry.id, entry);
    }
    final goalData = data['goal'] as Map<String, dynamic>?;
    if (goalData != null) {
      await setGoal(
        startWeight: (goalData['startWeightKg'] as num).toDouble(),
        targetWeight: (goalData['targetWeightKg'] as num).toDouble(),
        startDate: DateTime.parse(goalData['startDate'] as String),
        durationDays: goalData['durationDays'] as int,
      );
    }
    _loadData();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}
