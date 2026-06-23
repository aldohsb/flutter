import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../models/quiz_result_model.dart';

/// Service untuk semua operasi local storage
/// Keys: users_list, results_{userId}, active_user_id
class StorageService {
  static const String _usersKey = 'users_list';
  static const String _activeUserKey = 'active_user_id';
  static const String _resultsPrefix = 'results_';

  final SharedPreferences _prefs;

  StorageService._(this._prefs);

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService._(prefs);
  }

  // ── USERS ────────────────────────────────────────────────

  Future<List<UserModel>> getUsers() async {
    final raw = _prefs.getString(_usersKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveUser(UserModel user) async {
    final users = await getUsers();
    final idx = users.indexWhere((u) => u.id == user.id);
    if (idx >= 0) {
      users[idx] = user;
    } else {
      users.add(user);
    }
    await _prefs.setString(
      _usersKey,
      jsonEncode(users.map((u) => u.toMap()).toList()),
    );
  }

  Future<void> deleteUser(String userId) async {
    final users = await getUsers();
    users.removeWhere((u) => u.id == userId);
    await _prefs.setString(
      _usersKey,
      jsonEncode(users.map((u) => u.toMap()).toList()),
    );
    // Hapus juga semua hasil quiz user tersebut
    await _prefs.remove('$_resultsPrefix$userId');
    // Reset active user jika yang aktif adalah user yang dihapus
    final activeId = _prefs.getString(_activeUserKey);
    if (activeId == userId) {
      await _prefs.remove(_activeUserKey);
    }
  }

  // ── ACTIVE USER ───────────────────────────────────────────

  String? getActiveUserId() => _prefs.getString(_activeUserKey);

  Future<void> setActiveUserId(String? userId) async {
    if (userId == null) {
      await _prefs.remove(_activeUserKey);
    } else {
      await _prefs.setString(_activeUserKey, userId);
    }
  }

  // ── QUIZ RESULTS ─────────────────────────────────────────

  Future<List<QuizResultModel>> getResults(String userId) async {
    final raw = _prefs.getString('$_resultsPrefix$userId');
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => QuizResultModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveResult(QuizResultModel result) async {
    final results = await getResults(result.userId);
    results.add(result);
    await _prefs.setString(
      '$_resultsPrefix${result.userId}',
      jsonEncode(results.map((r) => r.toMap()).toList()),
    );
  }

  Future<void> deleteResult(String userId, String resultId) async {
    final results = await getResults(userId);
    results.removeWhere((r) => r.id == resultId);
    await _prefs.setString(
      '$_resultsPrefix$userId',
      jsonEncode(results.map((r) => r.toMap()).toList()),
    );
  }

  Future<void> clearAllResults(String userId) async {
    await _prefs.remove('$_resultsPrefix$userId');
  }
}