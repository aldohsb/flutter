// lib/data/datasources/local_storage.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../models/progress_model.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    assert(_prefs != null, 'LocalStorage.init() harus dipanggil lebih dulu');
    return _prefs!;
  }

  // ── Progress per bab ────────────────────────────────────────
  static Future<void> saveChapterProgress(ChapterProgress progress) async {
    final key = '${AppConstants.prefKeyProgress}_${progress.chapterId}';
    final jsonStr = jsonEncode(progress.toJson());
    await _instance.setString(key, jsonStr);
  }

  static ChapterProgress? getChapterProgress(int chapterId) {
    final key = '${AppConstants.prefKeyProgress}_$chapterId';
    final jsonStr = _instance.getString(key);
    if (jsonStr == null) return null;
    try {
      return ChapterProgress.fromJson(
          jsonDecode(jsonStr) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearChapterProgress(int chapterId) async {
    final key = '${AppConstants.prefKeyProgress}_$chapterId';
    await _instance.remove(key);
  }

  // ── Last position ────────────────────────────────────────────
  static Future<void> saveLastPosition(int chapterId, int pageIndex) async {
    await _instance.setInt(AppConstants.prefKeyLastChapter, chapterId);
    await _instance.setInt(AppConstants.prefKeyLastPage, pageIndex);
  }

  static int? getLastChapterId() =>
      _instance.getInt(AppConstants.prefKeyLastChapter);

  static int? getLastPageIndex() =>
      _instance.getInt(AppConstants.prefKeyLastPage);

  // ── Completed chapters ───────────────────────────────────────
  static Future<void> markChapterCompleted(int chapterId) async {
    final completed = getCompletedChapterIds();
    if (!completed.contains(chapterId)) {
      completed.add(chapterId);
      await _instance.setString(
        AppConstants.prefKeyCompletedChapters,
        jsonEncode(completed),
      );
    }
  }

  static List<int> getCompletedChapterIds() {
    final jsonStr =
        _instance.getString(AppConstants.prefKeyCompletedChapters);
    if (jsonStr == null) return [];
    try {
      final list = jsonDecode(jsonStr) as List<dynamic>;
      return list.cast<int>();
    } catch (_) {
      return [];
    }
  }

  // ── Reset semua ──────────────────────────────────────────────
  static Future<void> clearAll() async {
    await _instance.clear();
  }
}