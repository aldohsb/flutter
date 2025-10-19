import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/progress_model.dart';

class StorageService {
  static final StorageService instance = StorageService._init();
  StorageService._init();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User Management
  Future<void> saveCurrentUser(UserModel user) async {
    await _prefs?.setString('current_user_id', user.id);
    await _prefs?.setString('user_${user.id}', jsonEncode(user.toJson()));
  }

  Future<UserModel?> getCurrentUser() async {
    final userId = _prefs?.getString('current_user_id');
    if (userId == null) return null;
    
    final userJson = _prefs?.getString('user_$userId');
    if (userJson == null) return null;
    
    return UserModel.fromJson(jsonDecode(userJson));
  }

  Future<List<UserModel>> getAllUsers() async {
    final keys = _prefs?.getKeys() ?? {};
    final userKeys = keys.where((key) => key.startsWith('user_') && key != 'current_user_id');
    
    final users = <UserModel>[];
    for (var key in userKeys) {
      final userJson = _prefs?.getString(key);
      if (userJson != null) {
        users.add(UserModel.fromJson(jsonDecode(userJson)));
      }
    }
    
    users.sort((a, b) => b.lastActive.compareTo(a.lastActive));
    return users;
  }

  Future<void> updateUserLastActive(String userId) async {
    final userJson = _prefs?.getString('user_$userId');
    if (userJson == null) return;
    
    final user = UserModel.fromJson(jsonDecode(userJson));
    final updatedUser = user.copyWith(lastActive: DateTime.now());
    await _prefs?.setString('user_$userId', jsonEncode(updatedUser.toJson()));
  }

  Future<void> deleteUser(String userId) async {
    await _prefs?.remove('user_$userId');
    await _prefs?.remove('progress_list_$userId');
    
    final currentUserId = _prefs?.getString('current_user_id');
    if (currentUserId == userId) {
      await _prefs?.remove('current_user_id');
    }
  }

  // Progress Management
  Future<void> saveProgress(ProgressModel progress) async {
    final progressList = await getUserProgressList(progress.userId);
    
    // Remove existing progress for this level
    progressList.removeWhere((p) => p.levelNumber == progress.levelNumber);
    
    // Add new progress
    progressList.add(progress);
    
    // Save to storage
    final jsonList = progressList.map((p) => p.toJson()).toList();
    await _prefs?.setString('progress_list_${progress.userId}', jsonEncode(jsonList));
  }

  Future<List<ProgressModel>> getUserProgressList(String userId) async {
    final progressJson = _prefs?.getString('progress_list_$userId');
    if (progressJson == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(progressJson);
    return jsonList.map((json) => ProgressModel.fromJson(json)).toList();
  }

  Future<ProgressModel?> getLevelProgress(String userId, int levelNumber) async {
    final progressList = await getUserProgressList(userId);
    try {
      return progressList.firstWhere((p) => p.levelNumber == levelNumber);
    } catch (e) {
      return null;
    }
  }

  Future<int> getHighestUnlockedLevel(String userId) async {
    final progressList = await getUserProgressList(userId);
    if (progressList.isEmpty) return 1;
    
    final passedLevels = progressList.where((p) => p.isPassed).toList();
    if (passedLevels.isEmpty) return 1;
    
    passedLevels.sort((a, b) => b.levelNumber.compareTo(a.levelNumber));
    return passedLevels.first.levelNumber + 1;
  }

  Future<int> getTotalStars(String userId) async {
    final progressList = await getUserProgressList(userId);
    return progressList.fold<int>(0, (sum, progress) => sum + progress.stars);
  }

  Future<int> getCompletedLevels(String userId) async {
    final progressList = await getUserProgressList(userId);
    return progressList.where((p) => p.isPassed).length;
  }

  // Settings
  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs?.setBool('sound_enabled', enabled);
  }

  Future<bool> isSoundEnabled() async {
    return _prefs?.getBool('sound_enabled') ?? true;
  }

  // Clear all data
  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}