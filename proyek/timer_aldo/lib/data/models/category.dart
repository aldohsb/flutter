import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Category {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final DateTime createdAt;
  
  Category({
    String? id,
    required this.name,
    required this.color,
    required this.icon,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();
  
  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.toARGB32(),
      'icon': icon.codePoint,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  // Create from Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      color: Color(map['color'] as int),
      icon: IconData(
        map['icon'] as int,
        fontFamily: 'MaterialIcons',
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
  
  // Copy with
  Category copyWith({
    String? name,
    Color? color,
    IconData? icon,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt,
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() => 'Category(id: $id, name: $name)';
}