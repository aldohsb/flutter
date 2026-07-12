import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'level_progress.dart';
import 'quiz_category.dart';

/// Lapisan akses penyimpanan lokal (local storage) menggunakan
/// [SharedPreferences]. Seluruh progres disimpan sebagai JSON per kategori
/// sehingga hanya butuh 3 key total (hiragana, katakana, kanji).
class StorageService {
  static const String _keyPrefix = 'usama_quiz_progress_';

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

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    for (final category in QuizCategory.values) {
      await prefs.remove(_keyFor(category));
    }
  }

  String _keyFor(QuizCategory category) => '$_keyPrefix${category.storageKey}';
}
