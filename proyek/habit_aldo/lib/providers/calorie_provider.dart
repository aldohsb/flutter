import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/calorie_entry.dart';

class CalorieProvider extends ChangeNotifier {
  static const String _entriesBoxName = 'calorie_entries';
  static const String _goalBoxName = 'calorie_goal';
  static const String _customFoodsBoxName = 'custom_foods';

  late Box<CalorieEntry> _box;
  late Box<CalorieGoal> _goalBox;
  late Box<CustomFood> _customFoodsBox;

  List<CalorieEntry> _entries = [];
  CalorieGoal _goal = CalorieGoal(dailyTargetKcal: 1500);
  List<CustomFood> _customFoods = [];
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<CalorieEntry> get entries => List.unmodifiable(_entries);
  CalorieGoal get goal => _goal;
  List<CustomFood> get customFoods => List.unmodifiable(_customFoods);
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<CalorieEntry>(_entriesBoxName);
    _goalBox = await Hive.openBox<CalorieGoal>(_goalBoxName);
    _customFoodsBox = await Hive.openBox<CustomFood>(_customFoodsBoxName);
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
    _customFoods = _customFoodsBox.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  // ── Search: gabungan preset + custom ─────────────────────
  /// Semua item yang bisa dicari (preset + custom).
  /// Custom ditandai dengan [isCustom] flag di wrapper.
  List<SearchableFoodItem> searchFoods(String query) {
    final q = query.toLowerCase().trim();

    // Semua item yang bisa dicari (preset + custom).
    final presets = kFoodPresets
        .where((f) => q.isEmpty || f.name.toLowerCase().contains(q))
        .map((f) => SearchableFoodItem(
              name: f.name,
              caloriesPerServing: f.calories,
              isCustom: false,
            ))
        .toList();

    final customs = _customFoods
        .where((f) => q.isEmpty || f.name.toLowerCase().contains(q))
        .map((f) => SearchableFoodItem(
              name: f.name,
              caloriesPerServing: f.caloriesPerServing,
              isCustom: true,
              customId: f.id,
            ))
        .toList();

    // Preset dulu, custom di bawah
    return [...presets, ...customs];
  }

  // ── Custom foods CRUD ─────────────────────────────────────
  Future<CustomFood> addCustomFood(String name, int caloriesPerServing) async {
    final food = CustomFood(
      id: _uuid.v4(),
      name: name,
      caloriesPerServing: caloriesPerServing,
      createdAt: DateTime.now(),
    );
    await _customFoodsBox.put(food.id, food);
    _loadData();
    notifyListeners();
    return food;
  }

  Future<void> deleteCustomFood(String id) async {
    await _customFoodsBox.delete(id);
    _loadData();
    notifyListeners();
  }

  Future<void> updateCustomFood(
      String id, String name, int caloriesPerServing) async {
    final food = _customFoodsBox.get(id);
    if (food == null) return;
    food.name = name;
    food.caloriesPerServing = caloriesPerServing;
    await food.save();
    _loadData();
    notifyListeners();
  }

  // ── Helpers ──────────────────────────────────────────────
  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<CalorieEntry> entriesForDate(DateTime date) =>
      _entries.where((e) => _sameDay(e.date, date)).toList();

  int totalForDate(DateTime date) =>
      entriesForDate(date).fold(0, (s, e) => s + e.calories);

  // ── Today ────────────────────────────────────────────────
  List<CalorieEntry> get todayEntries => entriesForDate(DateTime.now());
  int get todayTotal => totalForDate(DateTime.now());
  int get dailyTarget => _goal.dailyTargetKcal;
  double get todayPercent =>
      dailyTarget > 0 ? todayTotal / dailyTarget * 100 : 0;

  // ── Daily totals for chart ────────────────────────────────
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

  List<DateTime> get datesWithEntries {
    final seen = <String>{};
    final dates = <DateTime>[];
    for (final e in _entries) {
      final key = '${e.date.year}-${e.date.month}-${e.date.day}';
      if (seen.add(key)) {
        dates.add(DateTime(e.date.year, e.date.month, e.date.day));
      }
    }
    return dates;
  }

  // ── Log entry CRUD ────────────────────────────────────────
  Future<void> addEntry(String foodName, int calories,
      {DateTime? date, int quantity = 1}) async {
    final entry = CalorieEntry(
      id: _uuid.v4(),
      foodName: foodName,
      calories: calories,
      date: date ?? DateTime.now(),
      quantity: quantity,
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
                'quantity': e.quantity,
                'date': e.date.toIso8601String(),
              })
          .toList(),
      'dailyTargetKcal': _goal.dailyTargetKcal,
      'customFoods': _customFoods
          .map((f) => {
                'id': f.id,
                'name': f.name,
                'caloriesPerServing': f.caloriesPerServing,
                'createdAt': f.createdAt.toIso8601String(),
              })
          .toList(),
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    await _customFoodsBox.clear();

    final entries = data['entries'] as List<dynamic>? ?? [];
    for (final raw in entries) {
      final map = raw as Map<String, dynamic>;
      final entry = CalorieEntry(
        id: map['id'] as String,
        foodName: map['foodName'] as String,
        calories: map['calories'] as int,
        date: DateTime.parse(map['date'] as String),
        quantity: map['quantity'] as int? ?? 1,
      );
      await _box.put(entry.id, entry);
    }

    final customFoods = data['customFoods'] as List<dynamic>? ?? [];
    for (final raw in customFoods) {
      final map = raw as Map<String, dynamic>;
      final food = CustomFood(
        id: map['id'] as String,
        name: map['name'] as String,
        caloriesPerServing: map['caloriesPerServing'] as int,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
      await _customFoodsBox.put(food.id, food);
    }

    final target = data['dailyTargetKcal'] as int? ?? 1500;
    await setDailyTarget(target);
    _loadData();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}

// ── Helper classes ────────────────────────────────────────────
class SearchableFoodItem {
  final String name;
  final int caloriesPerServing;
  final bool isCustom;
  final String? customId;

  const SearchableFoodItem({
    required this.name,
    required this.caloriesPerServing,
    required this.isCustom,
    this.customId,
  });
}

class DayCalTotal {
  final DateTime date;
  final int total;
  const DayCalTotal({required this.date, required this.total});
}