import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'character_stat.dart';
import 'level_progress.dart';
import 'quiz_category.dart';

/// Lapisan akses penyimpanan lokal (local storage) menggunakan
/// [SharedPreferences]. Progres level & statistik kesalahan sama-sama
/// disimpan sebagai JSON per kategori, sehingga hanya butuh 6 key total
/// (3 kategori x 2 jenis data: progres level & statistik aksara).
class StorageService {
  static const String _keyPrefix = 'usama_quiz_progress_';
  static const String _statsPrefix = 'usama_quiz_stats_';

  Future<Map<int, LevelProgress>> loadCategoryProgress(
    QuizCategory category,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyFor(category));
    if (raw == null || raw.isEmpty) {
      return <int, LevelProgress>{};
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final result = <int, LevelProgress>{};
      for (final entry in decoded.entries) {
        final level = int.tryParse(entry.key);
        if (level == null) continue;
        result[level] =
            LevelProgress.fromJson(entry.value as Map<String, dynamic>);
      }
      return result;
    } catch (_) {
      // Data korup / format lama -> mulai bersih agar aplikasi tidak crash.
      return <int, LevelProgress>{};
    }
  }

  Future<void> saveCategoryProgress(
    QuizCategory category,
    Map<int, LevelProgress> progress,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = <String, dynamic>{
      for (final entry in progress.entries) '${entry.key}': entry.value.toJson(),
    };
    await prefs.setString(_keyFor(category), jsonEncode(jsonMap));
  }

  /// Menghapus seluruh data progres level (skor terbaik & bintang) untuk
  /// semua kategori. Tidak menyentuh statistik kesalahan aksara.
  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (final category in QuizCategory.values) {
      await prefs.remove(_keyFor(category));
    }
  }

  Future<Map<String, CharacterStat>> loadCategoryStats(
    QuizCategory category,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_statsKeyFor(category));
    if (raw == null || raw.isEmpty) {
      return <String, CharacterStat>{};
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return {
        for (final entry in decoded.entries)
          entry.key: CharacterStat.fromJson(entry.value as Map<String, dynamic>),
      };
    } catch (_) {
      // Data korup / format lama -> mulai bersih agar aplikasi tidak crash.
      return <String, CharacterStat>{};
    }
  }

  Future<void> saveCategoryStats(
    QuizCategory category,
    Map<String, CharacterStat> stats,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = <String, dynamic>{
      for (final entry in stats.entries) entry.key: entry.value.toJson(),
    };
    await prefs.setString(_statsKeyFor(category), jsonEncode(jsonMap));
  }

  /// Menghapus seluruh statistik kesalahan aksara untuk semua kategori.
  /// Tidak menyentuh progres level.
  Future<void> clearStats() async {
    final prefs = await SharedPreferences.getInstance();
    for (final category in QuizCategory.values) {
      await prefs.remove(_statsKeyFor(category));
    }
  }

  String _keyFor(QuizCategory category) => '$_keyPrefix${category.storageKey}';

  String _statsKeyFor(QuizCategory category) => '$_statsPrefix${category.storageKey}';
}