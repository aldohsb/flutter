import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  static const String _boxName = 'habits';
  static const String _metaBoxName = 'habit_meta';

  late Box<Habit> _box;
  late Box _metaBox;
  List<Habit> _habits = [];
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<Habit> get habits => List.unmodifiable(_habits);
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<Habit>(_boxName);
    _metaBox = await Hive.openBox(_metaBoxName);
    _loadHabits();
    _isLoaded = true;
    notifyListeners();
  }

  void _loadHabits() {
    _habits = _box.values.toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  // ── Last seen date (for day-change detection) ─────────────
  String? get lastSeenDate => _metaBox.get('lastSeenDate') as String?;

  Future<void> updateLastSeenDate(String dateKey) async {
    await _metaBox.put('lastSeenDate', dateKey);
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// Returns habits that were NOT completed on [date]
  List<Habit> missedHabitsOn(DateTime date) {
    return _habits
        .where((h) => h.completionLog[_dateKey(date)] != true)
        .toList();
  }

  // ── CRUD ─────────────────────────────────────────────────
  Future<void> addHabit(String name, DateTime startDate) async {
    final habit = Habit(
      id: _uuid.v4(),
      name: name,
      sortOrder: _habits.length,
      startDate: startDate,
    );
    await _box.put(habit.id, habit);
    _loadHabits();
    notifyListeners();
  }

  Future<void> updateHabit(
      String id, String name, DateTime startDate) async {
    final habit = _box.get(id);
    if (habit == null) return;
    habit.name = name;
    habit.startDate = startDate;
    await habit.save();
    _loadHabits();
    notifyListeners();
  }

  Future<void> deleteHabit(String id) async {
    await _box.delete(id);
    _loadHabits();
    // Re-sort orders
    for (int i = 0; i < _habits.length; i++) {
      _habits[i].sortOrder = i;
      await _habits[i].save();
    }
    notifyListeners();
  }

  Future<void> reorderHabits(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;
    final habit = _habits.removeAt(oldIndex);
    _habits.insert(newIndex, habit);
    for (int i = 0; i < _habits.length; i++) {
      _habits[i].sortOrder = i;
      await _habits[i].save();
    }
    notifyListeners();
  }

  // ── Completion ───────────────────────────────────────────
  Future<void> toggleCompletion(String id, DateTime date) async {
    final habit = _box.get(id);
    if (habit == null) return;
    final key = _dateKey(date);
    final current = habit.completionLog[key] == true;
    habit.completionLog[key] = !current;
    await habit.save();
    notifyListeners();
  }

  Future<void> setCompletion(
      String id, DateTime date, bool value) async {
    final habit = _box.get(id);
    if (habit == null) return;
    final key = _dateKey(date);
    habit.completionLog[key] = value;
    await habit.save();
    _loadHabits();
    notifyListeners();
  }

  // ── Export / Import ──────────────────────────────────────
  Map<String, dynamic> exportData() {
    return {
      'habits': _habits.map((h) => _habitToJson(h)).toList(),
    };
  }

  Map<String, dynamic> _habitToJson(Habit h) => {
        'id': h.id,
        'name': h.name,
        'sortOrder': h.sortOrder,
        'completionLog': h.completionLog,
        'startDate': h.startDate.toIso8601String(),
        'createdAt': h.createdAt.toIso8601String(),
      };

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    final habits = data['habits'] as List<dynamic>? ?? [];
    for (final raw in habits) {
      final map = raw as Map<String, dynamic>;
      final log = (map['completionLog'] as Map<String, dynamic>?) ?? {};
      final habit = Habit(
        id: map['id'] as String,
        name: map['name'] as String,
        sortOrder: map['sortOrder'] as int,
        completionLog:
            log.map((k, v) => MapEntry(k, v as bool)),
        startDate: DateTime.parse(map['startDate'] as String),
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
      await _box.put(habit.id, habit);
    }
    _loadHabits();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}
