import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'food_model.g.dart';

@HiveType(typeId: 1)
class FoodModel extends HiveObject {
  @HiveField(0)
  int? id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final int categoryIndex;
  
  @HiveField(3)
  final double carbs;
  
  @HiveField(4)
  final double protein;
  
  @HiveField(5)
  final double fat;
  
  @HiveField(6)
  final double calories;
  
  @HiveField(7)
  final int rating;
  
  @HiveField(8)
  final String? description;
  
  @HiveField(9)
  final String? tips;
  
  FoodModel({
    this.id,
    required this.name,
    required FoodCategory category,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.rating,
    this.description,
    this.tips,
  }) : categoryIndex = category.index;

  // Getter for category
  FoodCategory get category => FoodCategory.values[categoryIndex];

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

  // Calculate net carbs
  double get netCarbs => carbs;

  // Is keto friendly
  bool get isKetoFriendly => rating >= AppConstants.ratingModerateValue;

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': categoryIndex,
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