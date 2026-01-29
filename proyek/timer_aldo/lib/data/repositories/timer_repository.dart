import '../models/timer_session.dart';
import '../models/statistics.dart';
import '../services/storage_service.dart';

class TimerRepository {
  final StorageService _storageService;
  
  TimerRepository(this._storageService);
  
  // Save current session
  Future<void> saveSession(TimerSession session) async {
    await _storageService.saveSession(session);
  }
  
  // Get all sessions
  List<TimerSession> getAllSessions() {
    return _storageService.getSessions();
  }
  
  // Get sessions by category
  List<TimerSession> getSessionsByCategory(String categoryId) {
    return _storageService.getSessionsByCategory(categoryId);
  }
  
  // Get sessions by date range
  List<TimerSession> getSessionsByDateRange(DateTime start, DateTime end) {
    return _storageService.getSessionsByDateRange(start, end);
  }
  
  // Delete session
  Future<void> deleteSession(String sessionId) async {
    await _storageService.deleteSession(sessionId);
  }
  
  // Update statistics after session completion
  Future<void> updateStatisticsFromSession(TimerSession session) async {
    final date = DateTime(
      session.startTime.year,
      session.startTime.month,
      session.startTime.day,
    );
    
    // Get existing statistics for this category and date
    Statistics? existingStats = _storageService.getStatistics(
      session.categoryId,
      date,
    );
    
    // Create new or update existing statistics
    final updatedStats = existingStats == null
        ? Statistics(
            categoryId: session.categoryId,
            date: date,
            totalSeconds: session.durationSeconds,
            activeSeconds: session.activeDuration,
            pausedSeconds: session.pausedSeconds,
            sessionCount: 1,
          )
        : existingStats.addSession(
            duration: session.durationSeconds,
            activeDuration: session.activeDuration,
            pausedDuration: session.pausedSeconds,
          );
    
    await _storageService.saveStatistics(updatedStats);
  }
  
  // Get statistics for a specific date
  Statistics? getStatistics(String categoryId, DateTime date) {
    return _storageService.getStatistics(categoryId, date);
  }
  
  // Get all statistics
  List<Statistics> getAllStatistics() {
    return _storageService.getAllStatistics();
  }
  
  // Get statistics by date range
  List<Statistics> getStatisticsByDateRange(DateTime start, DateTime end) {
    return _storageService.getStatisticsByDateRange(start, end);
  }
  
  // Get statistics by category
  List<Statistics> getStatisticsByCategory(String categoryId) {
    return _storageService.getStatisticsByCategory(categoryId);
  }
  
  // Update statistics manually
  Future<void> updateStatistics(Statistics stats) async {
    await _storageService.saveStatistics(stats);
  }
  
  // Delete statistics
  Future<void> deleteStatistics(String categoryId, DateTime date) async {
    await _storageService.deleteStatistics(categoryId, date);
  }
  
  // Get aggregate statistics for a period
  AggregateStatistics getAggregateStatistics(DateTime start, DateTime end) {
    final statsList = getStatisticsByDateRange(start, end);
    return AggregateStatistics.fromStatisticsList(statsList, start, end);
  }
  
  // Clean up old sessions and statistics
  Future<void> cleanupOldData({int daysToKeep = 90}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
    
    // Delete old sessions
    final oldSessions = getSessionsByDateRange(
      DateTime(2000, 1, 1),
      cutoffDate,
    );
    
    for (final session in oldSessions) {
      await deleteSession(session.id);
    }
    
    // Delete old statistics
    final oldStats = getStatisticsByDateRange(
      DateTime(2000, 1, 1),
      cutoffDate,
    );
    
    for (final stat in oldStats) {
      await deleteStatistics(stat.categoryId, stat.date);
    }
  }
}
