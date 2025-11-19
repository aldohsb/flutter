import '../models/food_item.dart';

class FoodDatabase {
  // Database makanan - dalam aplikasi nyata, ini bisa dari API
  static final List<FoodItem> foods = [
    // Breakfast
    FoodItem(
      id: '1',
      name: 'Nasi Putih',
      calories: 130,
      protein: 2.7,
      carbs: 28,
      fat: 0.3,
      servingSize: 100,
      category: 'Carbs',
      emoji: '🍚',
    ),
    FoodItem(
      id: '2',
      name: 'Telur Ayam',
      calories: 155,
      protein: 13,
      carbs: 1.1,
      fat: 11,
      servingSize: 100,
      category: 'Protein',
      emoji: '🥚',
    ),
    FoodItem(
      id: '3',
      name: 'Ayam Goreng',
      calories: 246,
      protein: 27,
      carbs: 0,
      fat: 15,
      servingSize: 100,
      category: 'Protein',
      emoji: '🍗',
    ),
    FoodItem(
      id: '4',
      name: 'Tempe Goreng',
      calories: 193,
      protein: 18,
      carbs: 9,
      fat: 11,
      servingSize: 100,
      category: 'Protein',
      emoji: '🟫',
    ),
    FoodItem(
      id: '5',
      name: 'Pisang',
      calories: 89,
      protein: 1.1,
      carbs: 23,
      fat: 0.3,
      servingSize: 100,
      category: 'Fruits',
      emoji: '🍌',
    ),
    FoodItem(
      id: '6',
      name: 'Apel',
      calories: 52,
      protein: 0.3,
      carbs: 14,
      fat: 0.2,
      servingSize: 100,
      category: 'Fruits',
      emoji: '🍎',
    ),
    FoodItem(
      id: '7',
      name: 'Roti Tawar',
      calories: 265,
      protein: 9,
      carbs: 49,
      fat: 3.2,
      servingSize: 100,
      category: 'Carbs',
      emoji: '🍞',
    ),
    FoodItem(
      id: '8',
      name: 'Susu',
      calories: 61,
      protein: 3.2,
      carbs: 4.8,
      fat: 3.3,
      servingSize: 100,
      category: 'Dairy',
      emoji: '🥛',
    ),
    FoodItem(
      id: '9',
      name: 'Wortel',
      calories: 41,
      protein: 0.9,
      carbs: 10,
      fat: 0.2,
      servingSize: 100,
      category: 'Vegetables',
      emoji: '🥕',
    ),
    FoodItem(
      id: '10',
      name: 'Kentang Goreng',
      calories: 312,
      protein: 3.4,
      carbs: 41,
      fat: 15,
      servingSize: 100,
      category: 'Carbs',
      emoji: '🍟',
    ),
    FoodItem(
      id: '11',
      name: 'Mie Goreng',
      calories: 188,
      protein: 5.1,
      carbs: 27,
      fat: 6.6,
      servingSize: 100,
      category: 'Carbs',
      emoji: '🍜',
    ),
    FoodItem(
      id: '12',
      name: 'Ikan Salmon',
      calories: 208,
      protein: 20,
      carbs: 0,
      fat: 13,
      servingSize: 100,
      category: 'Protein',
      emoji: '🐟',
    ),
    FoodItem(
      id: '13',
      name: 'Bayam',
      calories: 23,
      protein: 2.9,
      carbs: 3.6,
      fat: 0.4,
      servingSize: 100,
      category: 'Vegetables',
      emoji: '🥬',
    ),
    FoodItem(
      id: '14',
      name: 'Kacang Almond',
      calories: 579,
      protein: 21,
      carbs: 22,
      fat: 50,
      servingSize: 100,
      category: 'Nuts',
      emoji: '🥜',
    ),
    FoodItem(
      id: '15',
      name: 'Yogurt',
      calories: 59,
      protein: 10,
      carbs: 3.6,
      fat: 0.4,
      servingSize: 100,
      category: 'Dairy',
      emoji: '🥛',
    ),
  ];

  // Get all foods
  static List<FoodItem> getAllFoods() {
    return foods;
  }

  // Search foods by name
  static List<FoodItem> searchFoods(String query) {
    if (query.isEmpty) return foods;
    
    final lowerQuery = query.toLowerCase();
    return foods.where((food) {
      return food.name.toLowerCase().contains(lowerQuery) ||
             food.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Get foods by category
  static List<FoodItem> getFoodsByCategory(String category) {
    return foods.where((food) => food.category == category).toList();
  }

  // Get all categories
  static List<String> getCategories() {
    return foods.map((food) => food.category).toSet().toList();
  }
}