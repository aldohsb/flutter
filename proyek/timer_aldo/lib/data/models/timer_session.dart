import 'package:uuid/uuid.dart';

class TimerSession {
  final String id;
  final String categoryId;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationSeconds;
  final int pausedSeconds;
  final bool isCompleted;
  final List<PauseRecord> pauseRecords;
  
  TimerSession({
    String? id,
    required this.categoryId,
    DateTime? startTime,
    this.endTime,
    this.durationSeconds = 0,
    this.pausedSeconds = 0,
    this.isCompleted = false,
    List<PauseRecord>? pauseRecords,
  })  : id = id ?? const Uuid().v4(),
        startTime = startTime ?? DateTime.now(),
        pauseRecords = pauseRecords ?? [];
  
  // Get active duration (excluding pauses)
  int get activeDuration => durationSeconds - pausedSeconds;
  
  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'durationSeconds': durationSeconds,
      'pausedSeconds': pausedSeconds,
      'isCompleted': isCompleted,
      'pauseRecords': pauseRecords.map((e) => e.toMap()).toList(),
    };
  }
  
  // Create from Map
  factory TimerSession.fromMap(Map<String, dynamic> map) {
    return TimerSession(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: map['endTime'] != null
          ? DateTime.parse(map['endTime'] as String)
          : null,
      durationSeconds: map['durationSeconds'] as int,
      pausedSeconds: map['pausedSeconds'] as int,
      isCompleted: map['isCompleted'] as bool,
      pauseRecords: (map['pauseRecords'] as List<dynamic>)
          .map((e) => PauseRecord.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
  
  // Copy with
  TimerSession copyWith({
    String? categoryId,
    DateTime? endTime,
    int? durationSeconds,
    int? pausedSeconds,
    bool? isCompleted,
    List<PauseRecord>? pauseRecords,
  }) {
    return TimerSession(
      id: id,
      categoryId: categoryId ?? this.categoryId,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pausedSeconds: pausedSeconds ?? this.pausedSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
      pauseRecords: pauseRecords ?? this.pauseRecords,
    );
  }
  
  @override
  String toString() => 'TimerSession(id: $id, duration: ${activeDuration}s)';
}

class PauseRecord {
  final DateTime startTime;
  final DateTime? endTime;
  final String reason; // 'manual' or 'idle'
  
  PauseRecord({
    required this.startTime,
    this.endTime,
    this.reason = 'manual',
  });
  
  int get duration {
    if (endTime == null) return 0;
    return endTime!.difference(startTime).inSeconds;
  }
  
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'reason': reason,
    };
  }
  
  factory PauseRecord.fromMap(Map<String, dynamic> map) {
    return PauseRecord(
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: map['endTime'] != null
          ? DateTime.parse(map['endTime'] as String)
          : null,
      reason: map['reason'] as String,
    );
  }
}