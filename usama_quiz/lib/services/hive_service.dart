import 'package:hive_flutter/hive_flutter.dart';
import '../models/models.dart';

class HiveService {
  static const String usersBoxName = 'users';
  static const String progressBoxName = 'progress';
  static const String currentUserKey = 'currentUser';

  late Box<UserProfile> usersBox;
  late Box<LevelProgress> progressBox;
  late Box<String> settingsBox;

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(LevelProgressAdapter());

    // Open boxes
    usersBox = await Hive.openBox<UserProfile>(usersBoxName);
    progressBox = await Hive.openBox<LevelProgress>(progressBoxName);
    settingsBox = await Hive.openBox<String>('settings');
  }

  // ============= USER OPERATIONS =============
  Future<void> createUser(String username) async {
    final user = UserProfile(
      username: username,
      createdAt: DateTime.now(),
    );
    await usersBox.put(username, user);
    await setCurrentUser(username);
  }

  Future<UserProfile?> getUser(String username) async {
    return usersBox.get(username);
  }

  Future<List<UserProfile>> getAllUsers() async {
    return usersBox.values.toList();
  }

  Future<void> deleteUser(String username) async {
    await usersBox.delete(username);
    final current = getCurrentUser();
    if (current == username) {
      await settingsBox.delete(currentUserKey);
    }
  }

  String? getCurrentUser() {
    return settingsBox.get(currentUserKey);
  }

  Future<void> setCurrentUser(String username) async {
    await settingsBox.put(currentUserKey, username);
  }

  // ============= LEVEL PROGRESS OPERATIONS =============
  Future<void> saveLevelProgress(
    String username,
    int levelNumber,
    int correctAnswers,
    int totalAttempts,
    int starsEarned,
  ) async {
    final progress = LevelProgress(
      levelNumber: levelNumber,
      username: username,
      correctAnswers: correctAnswers,
      totalAttempts: totalAttempts,
      stars: starsEarned,
      isCompleted: correctAnswers >= 7,
      completedAt: DateTime.now(),
    );

    final key = '${username}_level_$levelNumber';
    await progressBox.put(key, progress);

    // Update user profile
    final user = await getUser(username);
    if (user != null) {
      user.currentLevel = levelNumber;
      user.totalStars += starsEarned;
      user.totalCorrect += correctAnswers;
      user.totalQuestions += totalAttempts;
      await user.save();
    }
  }

  Future<LevelProgress?> getLevelProgress(String username, int levelNumber) async {
    final key = '${username}_level_$levelNumber';
    return progressBox.get(key);
  }

  Future<List<LevelProgress>> getUserProgress(String username) async {
    return progressBox.values
        .where((p) => p.username == username)
        .toList()
      ..sort((a, b) => a.levelNumber.compareTo(b.levelNumber));
  }

  Future<int> getUserHighestLevel(String username) async {
    final allProgress = await getUserProgress(username);
    if (allProgress.isEmpty) return 1;
    
    final completed = allProgress.where((p) => p.isPassed).toList();
    if (completed.isEmpty) return 1;
    
    completed.sort((a, b) => b.levelNumber.compareTo(a.levelNumber));
    return completed.first.levelNumber + 1;
  }

  Future<Map<String, dynamic>> getUserStats(String username) async {
    final user = await getUser(username);
    if (user == null) return {};

    final progress = await getUserProgress(username);
    final completedLevels = progress.where((p) => p.isPassed).length;
    final totalStars = progress.fold<int>(0, (sum, p) => sum + p.stars);

    return {
      'username': username,
      'totalStars': totalStars,
      'completedLevels': completedLevels,
      'accuracy': user.accuracy,
      'totalCorrect': user.totalCorrect,
      'totalQuestions': user.totalQuestions,
      'createdAt': user.createdAt,
    };
  }
}