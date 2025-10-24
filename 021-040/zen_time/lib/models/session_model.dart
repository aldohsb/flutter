import 'package:hive/hive.dart';

part 'session_model.g.dart';

@HiveType(typeId: 1)
class SessionModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String projectId;
  
  @HiveField(2)
  DateTime startTime;
  
  @HiveField(3)
  DateTime? endTime;
  
  @HiveField(4)
  int durationSeconds;
  
  @HiveField(5)
  bool isRunning;
  
  @HiveField(6)
  String? notes;
  
  @HiveField(7)
  DateTime createdAt;
  
  @HiveField(8)
  DateTime updatedAt;
  
  SessionModel({
    required this.id,
    required this.projectId,
    required this.startTime,
    this.endTime,
    required this.durationSeconds,
    required this.isRunning,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  
  SessionModel copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
    bool? isRunning,
    String? notes,
    DateTime? updatedAt,
  }) {
    return SessionModel(
      id: id,
      projectId: projectId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      isRunning: isRunning ?? this.isRunning,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}