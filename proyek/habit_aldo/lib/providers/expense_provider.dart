import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_entry.dart';

class ExpenseProvider extends ChangeNotifier {
  static const String _entriesBoxName = 'expense_entries';
  static const String _customItemsBoxName = 'custom_expense_items';

  late Box<ExpenseEntry> _box;
  late Box<CustomExpenseItem> _customItemsBox;

  List<ExpenseEntry> _entries = [];
  List<CustomExpenseItem> _customItems = [];
  bool _isLoaded = false;

  static const _uuid = Uuid();

  List<ExpenseEntry> get entries => List.unmodifiable(_entries);
  List<CustomExpenseItem> get customItems => List.unmodifiable(_customItems);
  bool get isLoaded => _isLoaded;

  // ── Init ─────────────────────────────────────────────────
  Future<void> init() async {
    _box = await Hive.openBox<ExpenseEntry>(_entriesBoxName);
    _customItemsBox =
        await Hive.openBox<CustomExpenseItem>(_customItemsBoxName);
    _loadData();
    _isLoaded = true;
    notifyListeners();
  }

  void _loadData() {
    _entries = _box.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    _customItems = _customItemsBox.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  // ── Search: gabungan preset + custom ─────────────────────
  List<SearchableExpenseItem> searchItems(String query) {
    final q = query.toLowerCase().trim();

    final presets = kExpensePresets
        .where((f) => q.isEmpty || f.name.toLowerCase().contains(q))
        .map((f) => SearchableExpenseItem(
              name: f.name,
              category: f.category,
              isCustom: false,
            ))
        .toList();

    final customs = _customItems
        .where((f) => q.isEmpty || f.name.toLowerCase().contains(q))
        .map((f) => SearchableExpenseItem(
              name: f.name,
              category: f.category,
              isCustom: true,
              customId: f.id,
            ))
        .toList();

    return [...presets, ...customs];
  }

  // ── Custom items CRUD ─────────────────────────────────────
  Future<CustomExpenseItem> addCustomItem(String name, String category) async {
    final item = CustomExpenseItem(
      id: _uuid.v4(),
      name: name,
      category: category,
      createdAt: DateTime.now(),
    );
    await _customItemsBox.put(item.id, item);
    _loadData();
    notifyListeners();
    return item;
  }

  Future<void> deleteCustomItem(String id) async {
    await _customItemsBox.delete(id);
    _loadData();
    notifyListeners();
  }

  Future<void> updateCustomItem(String id, String name, String category) async {
    final item = _customItemsBox.get(id);
    if (item == null) return;
    item.name = name;
    item.category = category;
    await item.save();
    _loadData();
    notifyListeners();
  }

  // ── Helpers ──────────────────────────────────────────────
  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<ExpenseEntry> entriesForDate(DateTime date) =>
      _entries.where((e) => _sameDay(e.date, date)).toList();

  int totalForDate(DateTime date) =>
      entriesForDate(date).fold(0, (s, e) => s + e.amount);

  // ── Today ────────────────────────────────────────────────
  List<ExpenseEntry> get todayEntries => entriesForDate(DateTime.now());
  int get todayTotal => totalForDate(DateTime.now());

  // ── Daily totals for chart ────────────────────────────────
  List<DayExpenseTotal> dailyTotals(DateTime from, DateTime to) {
    final result = <DayExpenseTotal>[];
    DateTime cursor = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    while (!cursor.isAfter(end)) {
      result.add(DayExpenseTotal(date: cursor, total: totalForDate(cursor)));
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

  /// Total pengeluaran per kategori pada rentang tanggal [from]..[to] (inklusif)
  Map<String, int> totalsByCategory(DateTime from, DateTime to) {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59);
    final result = <String, int>{for (final c in kExpenseCategories) c: 0};
    for (final e in _entries) {
      if (!e.date.isBefore(start) && !e.date.isAfter(end)) {
        result[e.category] = (result[e.category] ?? 0) + e.amount;
      }
    }
    return result;
  }

  // ── Log entry CRUD ────────────────────────────────────────
  Future<void> addEntry(String name, String category, int amount,
      {DateTime? date}) async {
    final entry = ExpenseEntry(
      id: _uuid.v4(),
      name: name,
      amount: amount,
      category: category,
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

  // ── Export / Import ──────────────────────────────────────
  Map<String, dynamic> exportData() {
    return {
      'entries': _entries
          .map((e) => {
                'id': e.id,
                'name': e.name,
                'amount': e.amount,
                'category': e.category,
                'date': e.date.toIso8601String(),
              })
          .toList(),
      'customItems': _customItems
          .map((f) => {
                'id': f.id,
                'name': f.name,
                'category': f.category,
                'createdAt': f.createdAt.toIso8601String(),
              })
          .toList(),
    };
  }

  Future<void> importData(Map<String, dynamic> data) async {
    await _box.clear();
    await _customItemsBox.clear();

    final entries = data['entries'] as List<dynamic>? ?? [];
    for (final raw in entries) {
      final map = raw as Map<String, dynamic>;
      final entry = ExpenseEntry(
        id: map['id'] as String,
        name: map['name'] as String,
        amount: map['amount'] as int,
        category: map['category'] as String? ?? 'Lain-lain',
        date: DateTime.parse(map['date'] as String),
      );
      await _box.put(entry.id, entry);
    }

    final customItems = data['customItems'] as List<dynamic>? ?? [];
    for (final raw in customItems) {
      final map = raw as Map<String, dynamic>;
      final item = CustomExpenseItem(
        id: map['id'] as String,
        name: map['name'] as String,
        category: map['category'] as String? ?? 'Lain-lain',
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
      await _customItemsBox.put(item.id, item);
    }

    _loadData();
    notifyListeners();
  }

  String exportToJsonString() => jsonEncode(exportData());
}

// ── Helper classes ────────────────────────────────────────────
class SearchableExpenseItem {
  final String name;
  final String category;
  final bool isCustom;
  final String? customId;

  const SearchableExpenseItem({
    required this.name,
    required this.category,
    required this.isCustom,
    this.customId,
  });
}

class DayExpenseTotal {
  final DateTime date;
  final int total;
  const DayExpenseTotal({required this.date, required this.total});
}