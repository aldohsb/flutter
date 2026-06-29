import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  late Box<Habit> _habitBox;
  List<Habit> _habits = [];

  // Untuk konfirmasi ganti hari
  List<Habit> _habitsNeedingConfirmation = [];
  bool _confirmationPending = false;
  String _lastCheckedDate = '';

  HabitProvider() {
    _habitBox = Hive.box<Habit>('habits');
    _loadHabits();
    _checkDayChange();
  }

  List<Habit> get habits => _habits;
  List<Habit> get habitsNeedingConfirmation => _habitsNeedingConfirmation;
  bool get confirmationPending => _confirmationPending;

  void _loadHabits() {
    _habits = _habitBox.values.toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    notifyListeners();
  }

  void _checkDayChange() {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    // Cek apakah sudah pernah check hari ini (pakai simple key di Hive settings)
    final settingsBox = Hive.box('settings');
    _lastCheckedDate = settingsBox.get('lastCheckedDate', defaultValue: '');

    if (_lastCheckedDate != todayStr) {
      // Hari baru: cari habit yang kemarin TIDAK dicentang
      final yesterday = today.subtract(const Duration(days: 1));
      final yesterdayDate =
          DateTime(yesterday.year, yesterday.month, yesterday.day);

      _habitsNeedingConfirmation = _habits.where((habit) {
        return !habit.isCompletedOnDate(yesterdayDate);
      }).toList();

      // Reset semua habit untuk hari baru
      for (var habit in _habits) {
        habit.checkAndResetDaily();
        habit.save();
      }

      if (_habitsNeedingConfirmation.isNotEmpty && _lastCheckedDate.isNotEmpty) {
        // Ada habit yang perlu konfirmasi (hanya kalau bukan hari pertama pakai app)
        _confirmationPending = true;
      }

      // Update last checked date
      settingsBox.put('lastCheckedDate', todayStr);
      _lastCheckedDate = todayStr;
      notifyListeners();
    }
  }

  /// Dipanggil saat user konfirmasi habit kemarin selesai
  Future<void> confirmYesterdayCompletion(String habitId) async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final habit = _habitBox.get(habitId);
    if (habit != null) {
      habit.addCompletionForDate(yesterday);
      await habit.save();
      _loadHabits();
    }
  }

  void dismissConfirmation() {
    _confirmationPending = false;
    _habitsNeedingConfirmation = [];
    notifyListeners();
  }

  Future<void> addHabit(String name, {DateTime? startDate}) async {
    final maxOrder =
        _habits.isEmpty ? 0 : _habits.map((h) => h.sortOrder).reduce((a, b) => a > b ? a : b);
    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      startDate: startDate ?? DateTime.now(),
      sortOrder: maxOrder + 1,
    );
    await _habitBox.put(habit.id, habit);
    _loadHabits();
  }

  Future<void> updateHabit(String id, String newName, {DateTime? startDate}) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.name = newName;
      if (startDate != null) habit.startDate = startDate;
      await habit.save();
      _loadHabits();
    }
  }

  Future<void> deleteHabit(String id) async {
    await _habitBox.delete(id);
    _loadHabits();
  }

  Future<void> toggleHabitCompletion(String id) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.toggleCompletion();
      if (habit.isCompletedToday) {
        habit.lastCompletedDate = DateTime.now();
      }
      await habit.save();
      _loadHabits();
    }
  }

  Future<void> reorderHabits(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) newIndex -= 1;
    final item = _habits.removeAt(oldIndex);
    _habits.insert(newIndex, item);
    // Update sortOrder
    for (int i = 0; i < _habits.length; i++) {
      _habits[i].sortOrder = i;
      await _habits[i].save();
    }
    notifyListeners();
  }

  Future<void> updateHabitHistory(String id, List<DateTime> newHistory) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.completionHistory = newHistory;
      // Update isCompletedToday berdasarkan history baru
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      habit.isCompletedToday = newHistory.any((d) =>
          d.year == todayDate.year &&
          d.month == todayDate.month &&
          d.day == todayDate.day);
      habit.updateStreak();
      await habit.save();
      _loadHabits();
    }
  }

  Future<void> updateStartDate(String id, DateTime newStartDate) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.startDate = newStartDate;
      await habit.save();
      _loadHabits();
    }
  }

  Habit? getHabitById(String id) => _habitBox.get(id);
}
