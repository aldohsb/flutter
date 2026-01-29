import 'package:hive_flutter/hive_flutter.dart';
import '../models/category.dart';
import '../models/timer_session.dart';
import '../models/statistics.dart';

class StorageService {
  static const String _categoriesBox = 'categories';
  static const String _sessionsBox = 'sessions';
  static const String _statisticsBox = 'statistics';
  static const String _settingsBox = 'settings';
  
  Future<void> init() async {
    await Hive.initFlutter();
    
    await Hive.openBox<Map>(_categoriesBox);
    await Hive.openBox<Map>(_sessionsBox);
    await Hive.openBox<Map>(_statisticsBox);
    await Hive.openBox(_settingsBox);
  }
  
  // Categories
  Future<void> saveCategory(Category category) async {
    final box = Hive.box<Map>(_categoriesBox);
    await box.put(category.id, category.toMap());
  }
  
  Future<void> deleteCategory(String categoryId) async {
    final box = Hive.box<Map>(_categoriesBox);
    await box.delete(categoryId);
  }
  
  List<Category> getCategories() {
    final box = Hive.box<Map>(_categoriesBox);
    return box.values
        .map((map) => Category.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }
  
  Category? getCategory(String categoryId) {
    final box = Hive.box<Map>(_categoriesBox);
    final map = box.get(categoryId);
    if (map == null) return null;
    return Category.fromMap(Map<String, dynamic>.from(map));
  }
  
  // Sessions
  Future<void> saveSession(TimerSession session) async {
    final box = Hive.box<Map>(_sessionsBox);
    await box.put(session.id, session.toMap());
  }
  
  Future<void> deleteSession(String sessionId) async {
    final box = Hive.box<Map>(_sessionsBox);
    await box.delete(sessionId);
  }
  
  List<TimerSession> getSessions() {
    final box = Hive.box<Map>(_sessionsBox);
    return box.values
        .map((map) => TimerSession.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }
  
  List<TimerSession> getSessionsByCategory(String categoryId) {
    final box = Hive.box<Map>(_sessionsBox);
    return box.values
        .map((map) => TimerSession.fromMap(Map<String, dynamic>.from(map)))
        .where((session) => session.categoryId == categoryId)
        .toList();
  }
  
  List<TimerSession> getSessionsByDateRange(DateTime start, DateTime end) {
    final box = Hive.box<Map>(_sessionsBox);
    return box.values
        .map((map) => TimerSession.fromMap(Map<String, dynamic>.from(map)))
        .where((session) =>
            session.startTime.isAfter(start) &&
            session.startTime.isBefore(end))
        .toList();
  }
  
  // Statistics
  Future<void> saveStatistics(Statistics stats) async {
    final box = Hive.box<Map>(_statisticsBox);
    final key = '${stats.categoryId}_${stats.dateOnly.toIso8601String()}';
    await box.put(key, stats.toMap());
  }
  
  Future<void> deleteStatistics(String categoryId, DateTime date) async {
    final box = Hive.box<Map>(_statisticsBox);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final key = '${categoryId}_${dateOnly.toIso8601String()}';
    await box.delete(key);
  }
  
  Statistics? getStatistics(String categoryId, DateTime date) {
    final box = Hive.box<Map>(_statisticsBox);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final key = '${categoryId}_${dateOnly.toIso8601String()}';
    final map = box.get(key);
    if (map == null) return null;
    return Statistics.fromMap(Map<String, dynamic>.from(map));
  }
  
  List<Statistics> getAllStatistics() {
    final box = Hive.box<Map>(_statisticsBox);
    return box.values
        .map((map) => Statistics.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }
  
  List<Statistics> getStatisticsByDateRange(DateTime start, DateTime end) {
    final box = Hive.box<Map>(_statisticsBox);
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    
    return box.values
        .map((map) => Statistics.fromMap(Map<String, dynamic>.from(map)))
        .where((stats) =>
            !stats.dateOnly.isBefore(startDate) &&
            !stats.dateOnly.isAfter(endDate))
        .toList();
  }
  
  List<Statistics> getStatisticsByCategory(String categoryId) {
    final box = Hive.box<Map>(_statisticsBox);
    return box.values
        .map((map) => Statistics.fromMap(Map<String, dynamic>.from(map)))
        .where((stats) => stats.categoryId == categoryId)
        .toList();
  }
  
  // Settings
  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(_settingsBox);
    await box.put(key, value);
  }
  
  dynamic getSetting(String key, {dynamic defaultValue}) {
    final box = Hive.box(_settingsBox);
    return box.get(key, defaultValue: defaultValue);
  }
  
  Future<void> deleteSetting(String key) async {
    final box = Hive.box(_settingsBox);
    await box.delete(key);
  }
  
  // Clear all data
  Future<void> clearAll() async {
    await Hive.box<Map>(_categoriesBox).clear();
    await Hive.box<Map>(_sessionsBox).clear();
    await Hive.box<Map>(_statisticsBox).clear();
    await Hive.box(_settingsBox).clear();
  }
}
