import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  late Box<Habit> _habitBox;
  List<Habit> _habits = [];

  HabitProvider() {
    _habitBox = Hive.box<Habit>('habits');
    _loadHabits();
    _checkAndResetAllHabits();
  }

  List<Habit> get habits => _habits;

  void _loadHabits() {
    _habits = _habitBox.values.toList();
    notifyListeners();
  }

  void _checkAndResetAllHabits() {
    for (var habit in _habits) {
      habit.checkAndResetDaily();
      habit.save();
    }
    notifyListeners();
  }

  Future<void> addHabit(String name) async {
    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    await _habitBox.put(habit.id, habit);
    _loadHabits();
  }

  Future<void> updateHabit(String id, String newName) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.name = newName;
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
      await habit.save();
      _loadHabits();
    }
  }

  Future<void> updateHabitStreak(String id, int newStreak) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.streak = newStreak;
      await habit.save();
      _loadHabits();
    }
  }

  Future<void> updateHabitHistory(String id, List<DateTime> newHistory) async {
    final habit = _habitBox.get(id);
    if (habit != null) {
      habit.completionHistory = newHistory;
      // Don't auto-update streak here, let manual edit control it
      await habit.save();
      _loadHabits();
    }
  }

  Habit? getHabitById(String id) {
    return _habitBox.get(id);
  }
}