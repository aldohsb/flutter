import '../utils/constants.dart';

class UserModel {
  final int? id;
  final String name;
  final Gender gender;
  final int age; // Tambahkan umur
  final double height; // cm
  final double currentWeight; // kg
  final double targetWeight; // kg
  final DateTime startDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.startDate,
    this.createdAt,
    this.updatedAt,
  });

  // Calculate BMI
  double get bmi {
    final heightInMeters = height / 100;
    return currentWeight / (heightInMeters * heightInMeters);
  }

  // Get BMI Category
  String get bmiCategory {
    if (bmi < AppConstants.bmiUnderweight) {
      return 'Kurang Berat';
    } else if (bmi <= AppConstants.bmiNormal) {
      return 'Normal';
    } else if (bmi <= AppConstants.bmiOverweight) {
      return 'Kelebihan Berat';
    } else {
      return 'Obesitas';
    }
  }

  // Get weight to lose
  double get weightToLose {
    return currentWeight - targetWeight;
  }

  // Days on diet
  int get daysOnDiet {
    return DateTime.now().difference(startDate).inDays;
  }

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'gender': gender.index,
      'age': age,
      'height': height,
      'current_weight': currentWeight,
      'target_weight': targetWeight,
      'start_date': startDate.toIso8601String(),
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
    };
  }

  // Create from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      gender: Gender.values[map['gender'] as int],
      age: map['age'] as int,
      height: map['height'] as double,
      currentWeight: map['current_weight'] as double,
      targetWeight: map['target_weight'] as double,
      startDate: DateTime.parse(map['start_date'] as String),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }

  // Copy with
  UserModel copyWith({
    int? id,
    String? name,
    Gender? gender,
    int? age,
    double? height,
    double? currentWeight,
    double? targetWeight,
    DateTime? startDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      startDate: startDate ?? this.startDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}