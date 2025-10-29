import 'package:flutter/material.dart';
import '../utils/constants.dart';

class FoodModel {
  final int? id;
  final String name;
  final FoodCategory category;
  final double carbs; // per 100g
  final double protein; // per 100g
  final double fat; // per 100g
  final double calories; // per 100g
  final int rating; // 1-4 (Avoid to Excellent)
  final String? description;
  final String? tips;
  
  FoodModel({
    this.id,
    required this.name,
    required this.category,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.rating,
    this.description,
    this.tips,
  });

  // Get rating label
  String get ratingLabel {
    switch (rating) {
      case AppConstants.ratingExcellentValue:
        return 'Sangat Dianjurkan';
      case AppConstants.ratingModerateValue:
        return 'Moderat';
      case AppConstants.ratingCarefulValue:
        return 'Hati-hati';
      case AppConstants.ratingAvoidValue:
        return 'Hindari';
      default:
        return 'Unknown';
    }
  }

  // Get rating color
  Color get ratingColor {
    switch (rating) {
      case AppConstants.ratingExcellentValue:
        return AppConstants.ratingExcellent;
      case AppConstants.ratingModerateValue:
        return AppConstants.ratingModerate;
      case AppConstants.ratingCarefulValue:
        return AppConstants.ratingCareful;
      case AppConstants.ratingAvoidValue:
        return AppConstants.ratingAvoid;
      default:
        return Colors.grey;
    }
  }

  // Get rating icon
  IconData get ratingIcon {
    switch (rating) {
      case AppConstants.ratingExcellentValue:
        return Icons.check_circle;
      case AppConstants.ratingModerateValue:
        return Icons.info;
      case AppConstants.ratingCarefulValue:
        return Icons.warning;
      case AppConstants.ratingAvoidValue:
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  // Calculate net carbs (for keto, usually carbs - fiber, but we'll use carbs directly)
  double get netCarbs => carbs;

  // Is keto friendly
  bool get isKetoFriendly => rating >= AppConstants.ratingModerateValue;

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category.index,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'rating': rating,
      'description': description,
      'tips': tips,
    };
  }

  // Create from Map
  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: FoodCategory.values[map['category'] as int],
      carbs: map['carbs'] as double,
      protein: map['protein'] as double,
      fat: map['fat'] as double,
      calories: map['calories'] as double,
      rating: map['rating'] as int,
      description: map['description'] as String?,
      tips: map['tips'] as String?,
    );
  }

  // Copy with
  FoodModel copyWith({
    int? id,
    String? name,
    FoodCategory? category,
    double? carbs,
    double? protein,
    double? fat,
    double? calories,
    int? rating,
    String? description,
    String? tips,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      calories: calories ?? this.calories,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      tips: tips ?? this.tips,
    );
  }
}