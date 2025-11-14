import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'tag_model.g.dart';

@HiveType(typeId: 2)
class TagModel extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  int colorValue;
  
  @HiveField(3)
  DateTime createdAt;
  
  @HiveField(4)
  int usageCount;

  TagModel({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.createdAt,
    this.usageCount = 0,
  });

  // Factory untuk create tag baru
  factory TagModel.create({
    required String id,
    required String name,
    Color? color,
  }) {
    return TagModel(
      id: id,
      name: name,
      colorValue: color?.value ?? Colors.blue.value,
      createdAt: DateTime.now(),
      usageCount: 0,
    );
  }

  // Getter untuk color
  Color get color => Color(colorValue);
  
  // Setter untuk color
  set color(Color newColor) {
    colorValue = newColor.value;
  }

  // Copy with
  TagModel copyWith({
    String? name,
    Color? color,
    int? usageCount,
  }) {
    return TagModel(
      id: id,
      name: name ?? this.name,
      colorValue: color?.value ?? colorValue,
      createdAt: createdAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  // Increment usage
  void incrementUsage() {
    usageCount++;
    save();
  }
  
  // Decrement usage
  void decrementUsage() {
    if (usageCount > 0) {
      usageCount--;
      save();
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colorValue': colorValue,
      'createdAt': createdAt.toIso8601String(),
      'usageCount': usageCount,
    };
  }

  // Create from JSON
  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] as String,
      name: json['name'] as String,
      colorValue: json['colorValue'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      usageCount: json['usageCount'] as int? ?? 0,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TagModel && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}