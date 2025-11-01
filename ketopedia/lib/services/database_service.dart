import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/food_model.dart';
import '../models/weight_entry_model.dart';
import '../models/notification_setting_model.dart';
import '../data/food_data.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  DatabaseService._();

  bool _initialized = false;
  
  // Box names
  static const String usersBox = 'users';
  static const String foodsBox = 'foods';
  static const String weightEntriesBox = 'weight_entries';
  static const String favoritesBox = 'favorites';
  static const String notificationSettingsBox = 'notification_settings';

  Future<void> init() async {
    if (_initialized) return;

    try {
      await Hive.initFlutter();

      // Register adapters
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(UserModelAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(FoodModelAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(WeightEntryModelAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(NotificationSettingModelAdapter());
      }

      // Open boxes
      await Hive.openBox<UserModel>(usersBox);
      await Hive.openBox<FoodModel>(foodsBox);
      await Hive.openBox<WeightEntryModel>(weightEntriesBox);
      await Hive.openBox<Map>(favoritesBox);
      await Hive.openBox<NotificationSettingModel>(notificationSettingsBox);

      // Populate foods if empty
      final foodsBoxRef = Hive.box<FoodModel>(foodsBox);
      if (foodsBoxRef.isEmpty) {
        await _populateFoods();
      }

      _initialized = true;
      print('Hive database initialized successfully');
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow;
    }
  }

  Future<void> _populateFoods() async {
    final foodsBoxRef = Hive.box<FoodModel>(foodsBox);
    final foods = FoodData.getAllFoods();
    
    int id = 1;
    for (final food in foods) {
      final foodWithId = food.copyWith(id: id);
      await foodsBoxRef.put(id, foodWithId);
      id++;
    }
    print('${foods.length} foods added to database');
  }

  // USER OPERATIONS
  Future<int> insertUser(UserModel user) async {
    try {
      final box = Hive.box<UserModel>(usersBox);
      final id = box.isEmpty ? 1 : box.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
      final userWithId = user.copyWith(
        id: id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await box.put(id, userWithId);
      print('User inserted with ID: $id');
      return id;
    } catch (e) {
      print('Error inserting user: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUser(int id) async {
    final box = Hive.box<UserModel>(usersBox);
    return box.get(id);
  }

  Future<UserModel?> getFirstUser() async {
    final box = Hive.box<UserModel>(usersBox);
    if (box.isEmpty) return null;
    return box.values.first;
  }

  Future<int> updateUser(UserModel user) async {
    final box = Hive.box<UserModel>(usersBox);
    if (user.id == null) return 0;
    await box.put(user.id, user.copyWith(updatedAt: DateTime.now()));
    return 1;
  }

  Future<int> deleteUser(int id) async {
    final box = Hive.box<UserModel>(usersBox);
    await box.delete(id);
    return 1;
  }

  // FOOD OPERATIONS
  Future<List<FoodModel>> getAllFoods() async {
    final box = Hive.box<FoodModel>(foodsBox);
    return box.values.toList();
  }

  Future<List<FoodModel>> getFoodsByCategory(int categoryIndex) async {
    final box = Hive.box<FoodModel>(foodsBox);
    return box.values.where((food) => food.categoryIndex == categoryIndex).toList();
  }

  Future<List<FoodModel>> searchFoods(String query) async {
    final box = Hive.box<FoodModel>(foodsBox);
    final lowerQuery = query.toLowerCase();
    return box.values
        .where((food) => food.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  Future<List<FoodModel>> getFoodsByRating(int rating) async {
    final box = Hive.box<FoodModel>(foodsBox);
    return box.values.where((food) => food.rating == rating).toList();
  }

  Future<FoodModel?> getFood(int id) async {
    final box = Hive.box<FoodModel>(foodsBox);
    return box.get(id);
  }

  // WEIGHT ENTRY OPERATIONS
  Future<int> insertWeightEntry(WeightEntryModel entry) async {
    final box = Hive.box<WeightEntryModel>(weightEntriesBox);
    final id = box.isEmpty ? 1 : box.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
    final entryWithId = entry.copyWith(
      id: id,
      createdAt: DateTime.now(),
    );
    await box.put(id, entryWithId);
    return id;
  }

  Future<List<WeightEntryModel>> getWeightEntries(int userId) async {
    final box = Hive.box<WeightEntryModel>(weightEntriesBox);
    final entries = box.values.where((entry) => entry.userId == userId).toList();
    entries.sort((a, b) => b.date.compareTo(a.date)); // Descending
    return entries;
  }

  Future<WeightEntryModel?> getLatestWeightEntry(int userId) async {
    final entries = await getWeightEntries(userId);
    return entries.isEmpty ? null : entries.first;
  }

  Future<int> updateWeightEntry(WeightEntryModel entry) async {
    final box = Hive.box<WeightEntryModel>(weightEntriesBox);
    if (entry.id == null) return 0;
    await box.put(entry.id, entry);
    return 1;
  }

  Future<int> deleteWeightEntry(int id) async {
    final box = Hive.box<WeightEntryModel>(weightEntriesBox);
    await box.delete(id);
    return 1;
  }

  // FAVORITES OPERATIONS
  Future<int> addFavorite(int userId, int foodId) async {
    final box = Hive.box<Map>(favoritesBox);
    final key = '${userId}_$foodId';
    await box.put(key, {
      'user_id': userId,
      'food_id': foodId,
      'created_at': DateTime.now().toIso8601String(),
    });
    return 1;
  }

  Future<int> removeFavorite(int userId, int foodId) async {
    final box = Hive.box<Map>(favoritesBox);
    final key = '${userId}_$foodId';
    await box.delete(key);
    return 1;
  }

  Future<bool> isFavorite(int userId, int foodId) async {
    final box = Hive.box<Map>(favoritesBox);
    final key = '${userId}_$foodId';
    return box.containsKey(key);
  }

  Future<List<FoodModel>> getFavorites(int userId) async {
    final favBox = Hive.box<Map>(favoritesBox);
    final foodBox = Hive.box<FoodModel>(foodsBox);
    
    final favoriteIds = <int>[];
    for (final key in favBox.keys) {
      if (key.toString().startsWith('${userId}_')) {
        final data = favBox.get(key);
        if (data != null) {
          favoriteIds.add(data['food_id'] as int);
        }
      }
    }

    final favorites = <FoodModel>[];
    for (final id in favoriteIds) {
      final food = foodBox.get(id);
      if (food != null) {
        favorites.add(food);
      }
    }
    return favorites;
  }

  // NOTIFICATION SETTINGS OPERATIONS
  Future<int> insertNotificationSetting(NotificationSettingModel setting) async {
    final box = Hive.box<NotificationSettingModel>(notificationSettingsBox);
    final id = box.isEmpty ? 1 : box.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;
    final settingWithId = setting.copyWith(
      id: id,
      createdAt: DateTime.now(),
    );
    await box.put(id, settingWithId);
    return id;
  }

  Future<List<NotificationSettingModel>> getNotificationSettings(int userId) async {
    final box = Hive.box<NotificationSettingModel>(notificationSettingsBox);
    final settings = box.values.where((s) => s.userId == userId).toList();
    settings.sort((a, b) => a.time.compareTo(b.time));
    return settings;
  }

  Future<int> updateNotificationSetting(NotificationSettingModel setting) async {
    final box = Hive.box<NotificationSettingModel>(notificationSettingsBox);
    if (setting.id == null) return 0;
    await box.put(setting.id, setting);
    return 1;
  }

  Future<int> deleteNotificationSetting(int id) async {
    final box = Hive.box<NotificationSettingModel>(notificationSettingsBox);
    await box.delete(id);
    return 1;
  }

  // Clear all data (for testing/reset)
  Future<void> clearAllData() async {
    await Hive.box<UserModel>(usersBox).clear();
    await Hive.box<WeightEntryModel>(weightEntriesBox).clear();
    await Hive.box<Map>(favoritesBox).clear();
    await Hive.box<NotificationSettingModel>(notificationSettingsBox).clear();
    // Don't clear foods box
  }

  // Close all boxes
  Future<void> close() async {
    await Hive.close();
  }
}