import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/weight_entry.dart';

class WeightProvider extends ChangeNotifier {
  late Box<WeightEntry> _entryBox;
  late Box<WeightGoal> _goalBox;

  List<WeightEntry> _entries = [];
  WeightGoal? _goal;

  WeightProvider() {
    _entryBox = Hive.box<WeightEntry>('weight_entries');
    _goalBox = Hive.box<WeightGoal>('weight_goal');
    _load();
  }

  List<WeightEntry> get entries => _entries;
  WeightGoal? get goal => _goal;

  WeightEntry? get todayEntry {
    final today = DateTime.now();
    try {
      return _entries.firstWhere((e) =>
          e.date.year == today.year &&
          e.date.month == today.month &&
          e.date.day == today.day);
    } catch (_) {
      return null;
    }
  }

  WeightEntry? get latestEntry {
    if (_entries.isEmpty) return null;
    final sorted = List<WeightEntry>.from(_entries)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.first;
  }

  double get currentWeight {
    return latestEntry?.weight ?? _goal?.startWeight ?? 0;
  }

  /// Persentase vs target hari ini
  /// >100% = buruk (berat lebih dari target), <100% = bagus
  double? getTodayPercentage() {
    if (_goal == null) return null;
    final today = DateTime.now();
    final target = _goal!.targetWeightForDate(today);
    if (target == 0) return null;
    final current = currentWeight;
    if (current == 0) return null;
    // Untuk weight loss: current/target * 100
    // Jika current > target = persentase > 100 (buruk)
    return (current / target) * 100;
  }

  double? getTodayTargetWeight() {
    if (_goal == null) return null;
    return _goal!.targetWeightForDate(DateTime.now());
  }

  void _load() {
    _entries = _entryBox.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    _goal = _goalBox.isEmpty ? null : _goalBox.values.first;
    notifyListeners();
  }

  Future<void> setGoal({
    required double startWeight,
    required double targetWeight,
    required DateTime startDate,
    required int targetDays,
  }) async {
    await _goalBox.clear();
    final goal = WeightGoal(
      startWeight: startWeight,
      targetWeight: targetWeight,
      startDate: startDate,
      targetDays: targetDays,
    );
    await _goalBox.add(goal);
    _load();
  }

  Future<void> setTodayWeight(double weight) async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Hapus entry hari ini kalau sudah ada
    final existing = _entries.where((e) =>
        e.date.year == todayDate.year &&
        e.date.month == todayDate.month &&
        e.date.day == todayDate.day);
    for (var e in existing) {
      await e.delete();
    }

    final entry = WeightEntry(date: todayDate, weight: weight);
    await _entryBox.add(entry);
    _load();
  }

  Future<void> adjustWeight(double delta) async {
    final current = currentWeight;
    if (current == 0) return;
    await setTodayWeight(double.parse((current + delta).toStringAsFixed(1)));
  }

  List<WeightEntry> getEntriesForMonth(int year, int month) {
    return _entries
        .where((e) => e.date.year == year && e.date.month == month)
        .toList();
  }
}
