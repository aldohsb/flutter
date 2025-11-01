import 'package:hive/hive.dart';

part 'weight_entry_model.g.dart';

@HiveType(typeId: 2)
class WeightEntryModel extends HiveObject {
  @HiveField(0)
  int? id;
  
  @HiveField(1)
  final int userId;
  
  @HiveField(2)
  final double weight;
  
  @HiveField(3)
  final DateTime date;
  
  @HiveField(4)
  final String? notes;
  
  @HiveField(5)
  final DateTime? createdAt;

  WeightEntryModel({
    this.id,
    required this.userId,
    required this.weight,
    required this.date,
    this.notes,
    this.createdAt,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'weight': weight,
      'date': date.toIso8601String(),
      'notes': notes,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  // Create from Map
  factory WeightEntryModel.fromMap(Map<String, dynamic> map) {
    return WeightEntryModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      weight: map['weight'] as double,
      date: DateTime.parse(map['date'] as String),
      notes: map['notes'] as String?,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
    );
  }

  // Copy with
  WeightEntryModel copyWith({
    int? id,
    int? userId,
    double? weight,
    DateTime? date,
    String? notes,
    DateTime? createdAt,
  }) {
    return WeightEntryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}