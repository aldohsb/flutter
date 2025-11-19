class FoodItem {
  final String id;
  final String name;
  final double calories;
  final double protein; // grams
  final double carbs; // grams
  final double fat; // grams
  final double servingSize; // grams
  final String category;
  final String emoji;

  FoodItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.servingSize,
    required this.category,
    this.emoji = '🍽️',
  });

  // Convert to Map untuk disimpan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'servingSize': servingSize,
      'category': category,
      'emoji': emoji,
    };
  }

  // Buat object dari Map
  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      calories: (map['calories'] ?? 0).toDouble(),
      protein: (map['protein'] ?? 0).toDouble(),
      carbs: (map['carbs'] ?? 0).toDouble(),
      fat: (map['fat'] ?? 0).toDouble(),
      servingSize: (map['servingSize'] ?? 100).toDouble(),
      category: map['category'] ?? 'Other',
      emoji: map['emoji'] ?? '🍽️',
    );
  }

  // Copy dengan perubahan tertentu
  FoodItem copyWith({
    String? id,
    String? name,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? servingSize,
    String? category,
    String? emoji,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      servingSize: servingSize ?? this.servingSize,
      category: category ?? this.category,
      emoji: emoji ?? this.emoji,
    );
  }
}