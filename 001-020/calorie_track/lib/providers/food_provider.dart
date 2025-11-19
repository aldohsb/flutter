import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/food_item.dart';
import '../models/daily_log.dart';
import '../data/food_database.dart';

class FoodProvider with ChangeNotifier {
  Map<String, DailyLog> _logs = {}; // Key: date string
  List<FoodItem> _availableFoods = [];
  bool _isLoading = false;

  FoodProvider() {
    _loadData();
  }

  // Getters
  bool get isLoading => _isLoading;
  List<FoodItem> get availableFoods => _availableFoods;

  // Get today's log
  DailyLog get todayLog {
    final today = _getTodayString();
    return _logs[today] ?? DailyLog(date: today, entries: []);
  }

  // Get log by date
  DailyLog getLogByDate(DateTime date) {
    final dateString = DateFormat('yyyy-MM-dd').format(date);
    return _logs[dateString] ?? DailyLog(date: dateString, entries: []);
  }

  // Helper untuk mendapatkan string tanggal hari ini
  String _getTodayString() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // Load data dari SharedPreferences
  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load available foods
      _availableFoods = FoodDatabase.getAllFoods();

      // Load logs from storage
      final prefs = await SharedPreferences.getInstance();
      final logsJson = prefs.getString('daily_logs');
      
      if (logsJson != null) {
        final logsMap = json.decode(logsJson) as Map<String, dynamic>;
        _logs = logsMap.map(
          (key, value) => MapEntry(
            key,
            DailyLog.fromMap(value as Map<String, dynamic>),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save data ke SharedPreferences
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final logsMap = _logs.map((key, value) => MapEntry(key, value.toMap()));
      await prefs.setString('daily_logs', json.encode(logsMap));
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  // Add food entry to today
  Future<void> addFoodEntry(FoodItem food, double servings) async {
    final today = _getTodayString();
    final currentLog = _logs[today] ?? DailyLog(date: today, entries: []);
    
    final newEntry = FoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      food: food,
      servings: servings,
      timestamp: DateTime.now(),
    );

    final updatedEntries = List<FoodEntry>.from(currentLog.entries)..add(newEntry);
    _logs[today] = DailyLog(date: today, entries: updatedEntries);
    
    await _saveData();
    notifyListeners();
  }

  // Remove food entry
  Future<void> removeFoodEntry(String entryId) async {
    final today = _getTodayString();
    final currentLog = _logs[today];
    
    if (currentLog != null) {
      final updatedEntries = currentLog.entries
          .where((entry) => entry.id != entryId)
          .toList();
      
      _logs[today] = DailyLog(date: today, entries: updatedEntries);
      await _saveData();
      notifyListeners();
    }
  }

  // Search foods
  List<FoodItem> searchFoods(String query) {
    return FoodDatabase.searchFoods(query);
  }

  // Get foods by category
  List<FoodItem> getFoodsByCategory(String category) {
    return FoodDatabase.getFoodsByCategory(category);
  }

  // Get all categories
  List<String> getCategories() {
    return FoodDatabase.getCategories();
  }

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    _logs.clear();
    await _saveData();
    notifyListeners();
  }
}