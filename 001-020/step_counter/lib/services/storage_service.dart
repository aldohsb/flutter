import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_goal.dart';
import '../utils/constants.dart';

class StorageService {
  static SharedPreferences? _prefs;
  
  // Initialize storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Get SharedPreferences instance
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }
  
  // Save today's steps
  static Future<bool> saveTodaySteps(int steps) async {
    return await prefs.setInt(AppConstants.keyTotalSteps, steps);
  }
  
  // Get today's steps
  static int getTodaySteps() {
    return prefs.getInt(AppConstants.keyTotalSteps) ?? 0;
  }
  
  // Save daily goal
  static Future<bool> saveDailyGoal(DailyGoal goal) async {
    final json = jsonEncode(goal.toJson());
    return await prefs.setString(AppConstants.keyDailyGoal, json);
  }
  
  // Get daily goal
  static DailyGoal getDailyGoal() {
    final jsonString = prefs.getString(AppConstants.keyDailyGoal);
    if (jsonString == null) {
      return DailyGoal(
        targetSteps: AppConstants.defaultDailyStepGoal,
        lastModified: DateTime.now(),
      );
    }
    return DailyGoal.fromJson(jsonDecode(jsonString));
  }
  
  // Save last reset date
  static Future<bool> saveLastResetDate(DateTime date) async {
    return await prefs.setString(
      AppConstants.keyLastResetDate,
      date.toIso8601String(),
    );
  }
  
  // Get last reset date
  static DateTime? getLastResetDate() {
    final dateString = prefs.getString(AppConstants.keyLastResetDate);
    if (dateString == null) return null;
    return DateTime.parse(dateString);
  }
  
  // Check if need to reset (new day)
  static bool needsReset() {
    final lastReset = getLastResetDate();
    if (lastReset == null) return true;
    
    final now = DateTime.now();
    return lastReset.year != now.year ||
        lastReset.month != now.month ||
        lastReset.day != now.day;
  }
  
  // Reset daily steps
  static Future<void> resetDailySteps() async {
    await saveTodaySteps(0);
    await saveLastResetDate(DateTime.now());
  }
  
  // Clear all data
  static Future<bool> clearAll() async {
    return await prefs.clear();
  }
}