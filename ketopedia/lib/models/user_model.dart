import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final int genderIndex;
  
  @HiveField(3)
  final int age;
  
  @HiveField(4)
  final double height;
  
  @HiveField(5)
  final double currentWeight;
  
  @HiveField(6)
  final double targetWeight;
  
  @HiveField(7)
  final DateTime startDate;
  
  @HiveField(8)
  final DateTime? createdAt;
  
  @HiveField(9)
  final DateTime? updatedAt;

  // Main constructor
  UserModel({
    this.id,
    required this.name,
    required Gender gender,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.startDate,
    this.createdAt,
    this.updatedAt,
  }) : genderIndex = gender.index;

  // Private constructor for Hive
  UserModel._internal({
    this.id,
    required this.name,
    required this.genderIndex,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.startDate,
    this.createdAt,
    this.updatedAt,
  });

  // Factory for Hive adapter
  factory UserModel.fromHive({
    int? id,
    required String name,
    required int genderIndex,
    required int age,
    required double height,
    required double currentWeight,
    required double targetWeight,
    required DateTime startDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel._internal(
      id: id,
      name: name,
      genderIndex: genderIndex,
      age: age,
      height: height,
      currentWeight: currentWeight,
      targetWeight: targetWeight,
      startDate: startDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Getter for gender
  Gender get gender => Gender.values[genderIndex];

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

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'gender': genderIndex,
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
    return UserModel._internal(
      id: map['id'] as int?,
      name: map['name'] as String,
      genderIndex: map['gender'] as int,
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
    return UserModel._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      genderIndex: gender?.index ?? genderIndex,
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