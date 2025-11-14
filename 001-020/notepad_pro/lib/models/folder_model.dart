import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'folder_model.g.dart';

@HiveType(typeId: 1)
class FolderModel extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String? icon;
  
  @HiveField(3)
  int colorValue;
  
  @HiveField(4)
  DateTime createdAt;
  
  @HiveField(5)
  int noteCount;

  FolderModel({
    required this.id,
    required this.name,
    this.icon,
    required this.colorValue,
    required this.createdAt,
    this.noteCount = 0,
  });

  // Factory untuk create folder baru
  factory FolderModel.create({
    required String id,
    required String name,
    String? icon,
    Color? color,
  }) {
    return FolderModel(
      id: id,
      name: name,
      icon: icon ?? 'folder',
      colorValue: color?.value ?? Colors.blue.value,
      createdAt: DateTime.now(),
      noteCount: 0,
    );
  }

  // Getter untuk color
  Color get color => Color(colorValue);
  
  // Setter untuk color
  set color(Color newColor) {
    colorValue = newColor.value;
  }

  // Copy with
  FolderModel copyWith({
    String? name,
    String? icon,
    Color? color,
    int? noteCount,
  }) {
    return FolderModel(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      colorValue: color?.value ?? colorValue,
      createdAt: createdAt,
      noteCount: noteCount ?? this.noteCount,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'colorValue': colorValue,
      'createdAt': createdAt.toIso8601String(),
      'noteCount': noteCount,
    };
  }

  // Create from JSON
  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      colorValue: json['colorValue'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      noteCount: json['noteCount'] as int? ?? 0,
    );
  }
  
  // Get icon data
  IconData getIconData() {
    switch (icon) {
      case 'work':
        return Icons.work_outline;
      case 'home':
        return Icons.home_outlined;
      case 'school':
        return Icons.school_outlined;
      case 'favorite':
        return Icons.favorite_outline;
      case 'star':
        return Icons.star_outline;
      default:
        return Icons.folder_outlined;
    }
  }
}