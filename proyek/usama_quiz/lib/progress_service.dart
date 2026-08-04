import 'package:flutter/foundation.dart';

import 'level_progress.dart';
import 'quiz_category.dart';
import 'storage_service.dart';

/// Sumber kebenaran (single source of truth) untuk seluruh progres pemain.
///
/// Karena spesifikasi produk membuat semua level terbuka bebas dari awal,
/// service ini murni bertugas mencatat skor terbaik & bintang per level,
/// lalu menyediakan angka ringkasan (total bintang, level yang sudah
/// selesai) untuk ditampilkan di halaman pemilihan level.
class ProgressService extends ChangeNotifier {
  ProgressService({StorageService? storageService})
      : _storage = storageService ?? StorageService();

  final StorageService _storage;

  final Map<QuizCategory, Map<int, LevelProgress>> _progress = {
    QuizCategory.hiragana: {},
    QuizCategory.katakana: {},
    QuizCategory.kanji: {},
  };

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> loadAll() async {
    for (final category in QuizCategory.values) {
      _progress[category] = await _storage.loadCategoryProgress(category);
    }
    _isLoaded = true;
    notifyListeners();
  }

  LevelProgress progressFor(QuizCategory category, int level) {
    return _progress[category]?[level] ?? LevelProgress.empty(level);
  }

  /// Menyimpan hasil kuis. Hanya menimpa skor lama jika skor baru lebih baik.
  Future<void> recordResult({
    required QuizCategory category,
    required int level,
    required int correctCount,
  }) async {
    final categoryMap = _progress[category]!;
    final current = categoryMap[level] ?? LevelProgress.empty(level);
    final updated = current.mergeWithNewScore(correctCount);
    categoryMap[level] = updated;
    await _storage.saveCategoryProgress(category, categoryMap);
    notifyListeners();
  }

  int totalStars(QuizCategory category) {
    final categoryMap = _progress[category];
    if (categoryMap == null) return 0;
    return categoryMap.values.fold(0, (sum, p) => sum + p.stars);
  }

  int completedLevels(QuizCategory category) {
    final categoryMap = _progress[category];
    if (categoryMap == null) return 0;
    return categoryMap.values.where((p) => p.isCompleted).length;
  }

  double categoryCompletionRatio(QuizCategory category) {
    return completedLevels(category) / kLevelsPerCategory;
  }

  Future<void> resetAllProgress() async {
    await _storage.clearProgress();
    for (final category in QuizCategory.values) {
      _progress[category] = {};
    }
    notifyListeners();
  }
}