class Statistics {
  final String categoryId;
  final DateTime date;
  final int totalSeconds;
  final int activeSeconds;
  final int pausedSeconds;
  final int sessionCount;
  
  Statistics({
    required this.categoryId,
    required this.date,
    this.totalSeconds = 0,
    this.activeSeconds = 0,
    this.pausedSeconds = 0,
    this.sessionCount = 0,
  });
  
  // Get date without time
  DateTime get dateOnly {
    return DateTime(date.year, date.month, date.day);
  }
  
  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'date': dateOnly.toIso8601String(),
      'totalSeconds': totalSeconds,
      'activeSeconds': activeSeconds,
      'pausedSeconds': pausedSeconds,
      'sessionCount': sessionCount,
    };
  }
  
  // Create from Map
  factory Statistics.fromMap(Map<String, dynamic> map) {
    return Statistics(
      categoryId: map['categoryId'] as String,
      date: DateTime.parse(map['date'] as String),
      totalSeconds: map['totalSeconds'] as int,
      activeSeconds: map['activeSeconds'] as int,
      pausedSeconds: map['pausedSeconds'] as int,
      sessionCount: map['sessionCount'] as int,
    );
  }
  
  // Copy with
  Statistics copyWith({
    int? totalSeconds,
    int? activeSeconds,
    int? pausedSeconds,
    int? sessionCount,
  }) {
    return Statistics(
      categoryId: categoryId,
      date: date,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      activeSeconds: activeSeconds ?? this.activeSeconds,
      pausedSeconds: pausedSeconds ?? this.pausedSeconds,
      sessionCount: sessionCount ?? this.sessionCount,
    );
  }
  
  // Add session data
  Statistics addSession({
    required int duration,
    required int activeDuration,
    required int pausedDuration,
  }) {
    return copyWith(
      totalSeconds: totalSeconds + duration,
      activeSeconds: activeSeconds + activeDuration,
      pausedSeconds: pausedSeconds + pausedDuration,
      sessionCount: sessionCount + 1,
    );
  }
  
  // Format duration as string
  String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }
  
  String get formattedTotal => formatDuration(totalSeconds);
  String get formattedActive => formatDuration(activeSeconds);
  String get formattedPaused => formatDuration(pausedSeconds);
  
  @override
  String toString() {
    return 'Statistics(category: $categoryId, date: $dateOnly, total: $formattedTotal)';
  }
}

// Aggregate statistics for a period
class AggregateStatistics {
  final Map<String, int> categoryTotals;
  final int totalSeconds;
  final int totalSessions;
  final DateTime startDate;
  final DateTime endDate;
  
  AggregateStatistics({
    required this.categoryTotals,
    required this.totalSeconds,
    required this.totalSessions,
    required this.startDate,
    required this.endDate,
  });
  
  factory AggregateStatistics.fromStatisticsList(
    List<Statistics> statsList,
    DateTime startDate,
    DateTime endDate,
  ) {
    final Map<String, int> categoryTotals = {};
    int totalSeconds = 0;
    int totalSessions = 0;
    
    for (final stat in statsList) {
      categoryTotals[stat.categoryId] =
          (categoryTotals[stat.categoryId] ?? 0) + stat.activeSeconds;
      totalSeconds += stat.activeSeconds;
      totalSessions += stat.sessionCount;
    }
    
    return AggregateStatistics(
      categoryTotals: categoryTotals,
      totalSeconds: totalSeconds,
      totalSessions: totalSessions,
      startDate: startDate,
      endDate: endDate,
    );
  }
  
  double getCategoryPercentage(String categoryId) {
    if (totalSeconds == 0) return 0.0;
    final categoryTotal = categoryTotals[categoryId] ?? 0;
    return (categoryTotal / totalSeconds) * 100;
  }
}
