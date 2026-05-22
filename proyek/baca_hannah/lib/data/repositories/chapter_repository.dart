// lib/data/repositories/chapter_repository.dart

import '../datasources/chapter_data.dart';
import '../models/chapter_model.dart';

class ChapterRepository {
  const ChapterRepository();

  /// Ambil semua bab
  List<ChapterModel> getAllChapters() => allChapters;

  /// Ambil bab berdasarkan id (1-based)
  ChapterModel? getChapterById(int id) {
    try {
      return allChapters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Ambil bab berdasarkan index (0-based)
  ChapterModel? getChapterByIndex(int index) {
    if (index < 0 || index >= allChapters.length) return null;
    return allChapters[index];
  }

  /// Total jumlah bab tersedia
  int get totalChapters => allChapters.length;
}