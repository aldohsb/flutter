import 'food_item.dart';

class DailyLog {
  final String date; // Format: yyyy-MM-dd
  final List<FoodEntry> entries;

  DailyLog({
    required this.date,
    required this.entries,
  });

  // Hitung total kalori
  double get totalCalories {
    return entries.fold(0, (sum, entry) => sum + entry.totalCalories);
  }

  // Hitung total protein
  double get totalProtein {
    return entries.fold(0, (sum, entry) => sum + entry.totalProtein);
  }

  // Hitung total carbs
  double get totalCarbs {
    return entries.fold(0, (sum, entry) => sum + entry.totalCarbs);
  }

  // Hitung total fat
  double get totalFat {
    return entries.fold(0, (sum, entry) => sum + entry.totalFat);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'entries': entries.map((e) => e.toMap()).toList(),
    };
  }

  factory DailyLog.fromMap(Map<String, dynamic> map) {
    return DailyLog(
      date: map['date'] ?? '',
      entries: (map['entries'] as List<dynamic>?)
              ?.map((e) => FoodEntry.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class FoodEntry {
  final String id;
  final FoodItem food;
  final double servings; // Berapa porsi yang dimakan
  final DateTime timestamp;

  FoodEntry({
    required this.id,
    required this.food,
    required this.servings,
    required this.timestamp,
  });

  // Kalori total berdasarkan jumlah porsi
  double get totalCalories => food.calories * servings;
  double get totalProtein => food.protein * servings;
  double get totalCarbs => food.carbs * servings;
  double get totalFat => food.fat * servings;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'food': food.toMap(),
      'servings': servings,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory FoodEntry.fromMap(Map<String, dynamic> map) {
    return FoodEntry(
      id: map['id'] ?? '',
      food: FoodItem.fromMap(map['food'] as Map<String, dynamic>),
      servings: (map['servings'] ?? 1).toDouble(),
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }
}