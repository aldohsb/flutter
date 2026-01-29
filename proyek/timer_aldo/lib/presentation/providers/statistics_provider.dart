import 'package:flutter/material.dart';
import '../../data/models/statistics.dart';
import '../../data/services/storage_service.dart';

class StatisticsProvider extends ChangeNotifier {
  final StorageService _storageService;
  
  List<Statistics> _statistics = [];
  DateTime _selectedStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now();
  
  StatisticsProvider(this._storageService) {
    _loadStatistics();
  }
  
  // Getters
  List<Statistics> get statistics => List.unmodifiable(_statistics);
  DateTime get selectedStartDate => _selectedStartDate;
  DateTime get selectedEndDate => _selectedEndDate;
  
  // Load statistics
  Future<void> _loadStatistics() async {
    _statistics = _storageService.getStatisticsByDateRange(
      _selectedStartDate,
      _selectedEndDate,
    );
    notifyListeners();
  }
  
  // Get statistics for specific category and date range
  List<Statistics> getStatisticsForCategory(String categoryId) {
    return _statistics
        .where((stat) => stat.categoryId == categoryId)
        .toList();
  }
  
  // Get statistics for specific date
  Statistics? getStatisticsForDate(String categoryId, DateTime date) {
    try {
      return _statistics.firstWhere(
        (stat) =>
            stat.categoryId == categoryId &&
            stat.dateOnly == DateTime(date.year, date.month, date.day),
      );
    } catch (e) {
      return null;
    }
  }
  
  // Get aggregate statistics
  AggregateStatistics getAggregateStatistics() {
    return AggregateStatistics.fromStatisticsList(
      _statistics,
      _selectedStartDate,
      _selectedEndDate,
    );
  }
  
  // Update date range
  Future<void> setDateRange(DateTime start, DateTime end) async {
    _selectedStartDate = start;
    _selectedEndDate = end;
    await _loadStatistics();
  }
  
  // Set predefined ranges
  Future<void> setToday() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    await setDateRange(today, now);
  }
  
  Future<void> setThisWeek() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
    await setDateRange(weekStartDate, now);
  }
  
  Future<void> setThisMonth() async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    await setDateRange(monthStart, now);
  }
  
  Future<void> setLast7Days() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 7));
    await setDateRange(start, now);
  }
  
  Future<void> setLast30Days() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 30));
    await setDateRange(start, now);
  }
  
  // Update statistics manually (for editing)
  Future<void> updateStatistics(Statistics stats) async {
    await _storageService.saveStatistics(stats);
    
    final index = _statistics.indexWhere(
      (s) => s.categoryId == stats.categoryId && s.dateOnly == stats.dateOnly,
    );
    
    if (index != -1) {
      _statistics[index] = stats;
    } else {
      _statistics.add(stats);
    }
    
    notifyListeners();
  }
  
  // Delete statistics
  Future<void> deleteStatistics(String categoryId, DateTime date) async {
    await _storageService.deleteStatistics(categoryId, date);
    _statistics.removeWhere(
      (s) => s.categoryId == categoryId && s.dateOnly == date,
    );
    notifyListeners();
  }
  
  // Get total time for all categories
  int getTotalTimeSeconds() {
    return _statistics.fold(0, (sum, stat) => sum + stat.activeSeconds);
  }
  
  // Get total time for specific category
  int getTotalTimeForCategory(String categoryId) {
    return _statistics
        .where((stat) => stat.categoryId == categoryId)
        .fold(0, (sum, stat) => sum + stat.activeSeconds);
  }
  
  // Get average daily time
  double getAverageDailyTime() {
    if (_statistics.isEmpty) return 0.0;
    
    final days = _selectedEndDate.difference(_selectedStartDate).inDays + 1;
    final totalSeconds = getTotalTimeSeconds();
    
    return totalSeconds / days;
  }
  
  // Refresh statistics
  Future<void> refresh() async {
    await _loadStatistics();
  }
}
