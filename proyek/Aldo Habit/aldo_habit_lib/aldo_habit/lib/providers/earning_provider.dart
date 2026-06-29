import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/earning_entry.dart';

class EarningProvider extends ChangeNotifier {
  late Box<EarningEntry> _entryBox;
  late Box<EarningGoal> _goalBox;

  List<EarningEntry> _entries = [];
  EarningGoal? _goal;

  EarningProvider() {
    _entryBox = Hive.box<EarningEntry>('earning_entries');
    _goalBox = Hive.box<EarningGoal>('earning_goal');
    _load();
  }

  List<EarningEntry> get entries => _entries;
  EarningGoal? get goal => _goal;
  double get monthlyTarget => _goal?.monthlyTarget ?? 0;

  void _load() {
    _entries = _entryBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    _goal = _goalBox.isEmpty ? null : _goalBox.values.first;
    notifyListeners();
  }

  Future<void> setMonthlyTarget(double target) async {
    await _goalBox.clear();
    final goal = EarningGoal(monthlyTarget: target);
    await _goalBox.add(goal);
    _load();
  }

  Future<void> addEarning(double amount, {String? note}) async {
    final entry = EarningEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      amount: amount,
      note: note,
    );
    await _entryBox.put(entry.id, entry);
    _load();
  }

  Future<void> deleteEarning(String id) async {
    await _entryBox.delete(id);
    _load();
  }

  /// Total earning bulan ini
  double getMonthlyTotal(int year, int month) {
    return _entries
        .where((e) => e.date.year == year && e.date.month == month)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Total hari ini
  double getTodayTotal() {
    final today = DateTime.now();
    return _entries
        .where((e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Target harian = monthlyTarget / daysInMonth
  double getDailyTarget(int year, int month) {
    if (monthlyTarget == 0) return 0;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    return monthlyTarget / daysInMonth;
  }

  /// Target kumulatif sampai hari ini dalam bulan
  double getCumulativeTargetToday() {
    if (monthlyTarget == 0) return 0;
    final today = DateTime.now();
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
    final dailyTarget = monthlyTarget / daysInMonth;
    return dailyTarget * today.day;
  }

  /// Persentase pencapaian kumulatif sampai hari ini
  double getTodayCumulativePercentage() {
    final cumTarget = getCumulativeTargetToday();
    if (cumTarget == 0) return 0;
    final now = DateTime.now();
    final monthTotal = getMonthlyTotal(now.year, now.month);
    return (monthTotal / cumTarget) * 100;
  }

  /// Total keseluruhan
  double get totalAllTime =>
      _entries.fold(0.0, (sum, e) => sum + e.amount);

  /// Entries bulan ini
  List<EarningEntry> getEntriesForMonth(int year, int month) {
    return _entries
        .where((e) => e.date.year == year && e.date.month == month)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Entries hari ini
  List<EarningEntry> getTodayEntries() {
    final today = DateTime.now();
    return _entries
        .where((e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Summary per bulan (untuk statistik)
  Map<String, double> getMonthlyTotals() {
    final Map<String, double> result = {};
    for (var entry in _entries) {
      final key =
          '${entry.date.year}-${entry.date.month.toString().padLeft(2, '0')}';
      result[key] = (result[key] ?? 0) + entry.amount;
    }
    return result;
  }
}
