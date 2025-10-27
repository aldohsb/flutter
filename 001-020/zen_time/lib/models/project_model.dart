import 'package:hive/hive.dart';

part 'project_model.g.dart';

@HiveType(typeId: 0)
class ProjectModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String? description;
  
  @HiveField(3)
  int colorValue;
  
  @HiveField(4)
  double dailyTargetHours;
  
  @HiveField(5)
  double weeklyTargetHours;
  
  @HiveField(6)
  DateTime createdAt;
  
  @HiveField(7)
  DateTime updatedAt;
  
  ProjectModel({
    required this.id,
    required this.name,
    this.description,
    required this.colorValue,
    required this.dailyTargetHours,
    required this.weeklyTargetHours,
    required this.createdAt,
    required this.updatedAt,
  });
  
  ProjectModel copyWith({
    String? name,
    String? description,
    int? colorValue,
    double? dailyTargetHours,
    double? weeklyTargetHours,
    DateTime? updatedAt,
  }) {
    return ProjectModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      dailyTargetHours: dailyTargetHours ?? this.dailyTargetHours,
      weeklyTargetHours: weeklyTargetHours ?? this.weeklyTargetHours,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}