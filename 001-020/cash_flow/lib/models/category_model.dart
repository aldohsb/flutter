import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String icon;
  final Color color;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] as String,
      icon: json['icon'] as String,
      color: Color(json['color'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'color': color.value,
    };
  }
}