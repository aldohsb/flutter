import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/food_model.dart';
import '../models/weight_entry_model.dart';
import '../models/notification_setting_model.dart';
import '../utils/constants.dart';
import '../data/food_data.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService instance = DatabaseService._();

  DatabaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, AppConstants.dbName);

      return await openDatabase(
        path,
        version: AppConstants.dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      // Create users table
      await db.execute('''
        CREATE TABLE ${AppConstants.tableUsers} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          gender INTEGER NOT NULL,
          height REAL NOT NULL,
          current_weight REAL NOT NULL,
          target_weight REAL NOT NULL,
          start_date TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');

      // Create foods table
      await db.execute('''
        CREATE TABLE ${AppConstants.tableFoods} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          category INTEGER NOT NULL,
          carbs REAL NOT NULL,
          protein REAL NOT NULL,
          fat REAL NOT NULL,
          calories REAL NOT NULL,
          rating INTEGER NOT NULL,
          description TEXT,
          tips TEXT
        )
      ''');

      // Create weight_entries table
      await db.execute('''
        CREATE TABLE ${AppConstants.tableWeightEntries} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          weight REAL NOT NULL,
          date TEXT NOT NULL,
          notes TEXT,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES ${AppConstants.tableUsers} (id)
        )
      ''');

      // Create favorites table
      await db.execute('''
        CREATE TABLE ${AppConstants.tableFavorites} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          food_id INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES ${AppConstants.tableUsers} (id),
          FOREIGN KEY (food_id) REFERENCES ${AppConstants.tableFoods} (id),
          UNIQUE(user_id, food_id)
        )
      ''');

      // Create notification_settings table
      await db.execute('''
        CREATE TABLE ${AppConstants.tableNotificationSettings} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          time TEXT NOT NULL,
          is_enabled INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES ${AppConstants.tableUsers} (id)
        )
      ''');

      // Populate foods data
      await _populateFoods(db);
      
      print('Database created successfully');
    } catch (e) {
      print('Error creating database tables: $e');
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades if needed
  }

  Future<void> _populateFoods(Database db) async {
    final foods = FoodData.getAllFoods();
    for (final food in foods) {
      await db.insert(AppConstants.tableFoods, food.toMap());
    }
  }

  // USER OPERATIONS
  Future<int> insertUser(UserModel user) async {
    try {
      final db = await database;
      final id = await db.insert(
        AppConstants.tableUsers, 
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('User inserted successfully with ID: $id');
      return id;
    } catch (e) {
      print('Error inserting user: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUser(int id) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) return null;
    return UserModel.fromMap(results.first);
  }

  Future<UserModel?> getFirstUser() async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableUsers,
      limit: 1,
    );

    if (results.isEmpty) return null;
    return UserModel.fromMap(results.first);
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      AppConstants.tableUsers,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // FOOD OPERATIONS
  Future<List<FoodModel>> getAllFoods() async {
    final db = await database;
    final results = await db.query(AppConstants.tableFoods);
    return results.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<List<FoodModel>> getFoodsByCategory(FoodCategory category) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableFoods,
      where: 'category = ?',
      whereArgs: [category.index],
    );
    return results.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<List<FoodModel>> searchFoods(String query) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableFoods,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<List<FoodModel>> getFoodsByRating(int rating) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableFoods,
      where: 'rating = ?',
      whereArgs: [rating],
    );
    return results.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<FoodModel?> getFood(int id) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableFoods,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) return null;
    return FoodModel.fromMap(results.first);
  }

  // WEIGHT ENTRY OPERATIONS
  Future<int> insertWeightEntry(WeightEntryModel entry) async {
    final db = await database;
    return await db.insert(AppConstants.tableWeightEntries, entry.toMap());
  }

  Future<List<WeightEntryModel>> getWeightEntries(int userId) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableWeightEntries,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
    return results.map((map) => WeightEntryModel.fromMap(map)).toList();
  }

  Future<WeightEntryModel?> getLatestWeightEntry(int userId) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableWeightEntries,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
      limit: 1,
    );

    if (results.isEmpty) return null;
    return WeightEntryModel.fromMap(results.first);
  }

  Future<int> updateWeightEntry(WeightEntryModel entry) async {
    final db = await database;
    return await db.update(
      AppConstants.tableWeightEntries,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteWeightEntry(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableWeightEntries,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // FAVORITES OPERATIONS
  Future<int> addFavorite(int userId, int foodId) async {
    final db = await database;
    return await db.insert(
      AppConstants.tableFavorites,
      {
        'user_id': userId,
        'food_id': foodId,
        'created_at': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<int> removeFavorite(int userId, int foodId) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableFavorites,
      where: 'user_id = ? AND food_id = ?',
      whereArgs: [userId, foodId],
    );
  }

  Future<bool> isFavorite(int userId, int foodId) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableFavorites,
      where: 'user_id = ? AND food_id = ?',
      whereArgs: [userId, foodId],
    );
    return results.isNotEmpty;
  }

  Future<List<FoodModel>> getFavorites(int userId) async {
    final db = await database;
    final results = await db.rawQuery('''
      SELECT f.* FROM ${AppConstants.tableFoods} f
      INNER JOIN ${AppConstants.tableFavorites} fav ON f.id = fav.food_id
      WHERE fav.user_id = ?
      ORDER BY fav.created_at DESC
    ''', [userId]);
    return results.map((map) => FoodModel.fromMap(map)).toList();
  }

  // NOTIFICATION SETTINGS OPERATIONS
  Future<int> insertNotificationSetting(NotificationSettingModel setting) async {
    final db = await database;
    return await db.insert(AppConstants.tableNotificationSettings, setting.toMap());
  }

  Future<List<NotificationSettingModel>> getNotificationSettings(int userId) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableNotificationSettings,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'time ASC',
    );
    return results.map((map) => NotificationSettingModel.fromMap(map)).toList();
  }

  Future<int> updateNotificationSetting(NotificationSettingModel setting) async {
    final db = await database;
    return await db.update(
      AppConstants.tableNotificationSettings,
      setting.toMap(),
      where: 'id = ?',
      whereArgs: [setting.id],
    );
  }

  Future<int> deleteNotificationSetting(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableNotificationSettings,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all data (for testing/reset)
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(AppConstants.tableUsers);
    await db.delete(AppConstants.tableWeightEntries);
    await db.delete(AppConstants.tableFavorites);
    await db.delete(AppConstants.tableNotificationSettings);
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}