// lib/data/repositories/progress_repository.dart

import '../datasources/local_storage.dart';
import '../datasources/chapter_data.dart';
import '../models/progress_model.dart';

class ProgressRepository {
  const ProgressRepository();

  /// Ambil progress bab. Kalau belum ada, kembalikan initial.
  ChapterProgress getProgress(int chapterId) {
    final saved = LocalStorage.getChapterProgress(chapterId);
    if (saved != null) return saved;

    // Cari total pages dari data
    final chapter = allChapters.firstWhere(
      (c) => c.id == chapterId,
      orElse: () => throw ArgumentError('Chapter $chapterId tidak ditemukan'),
    );
    return ChapterProgress.initial(chapterId, chapter.totalPages);
  }

  /// Simpan/update progress
  Future<void> saveProgress(ChapterProgress progress) async {
    await LocalStorage.saveChapterProgress(progress);
    if (progress.isCompleted) {
      await LocalStorage.markChapterCompleted(progress.chapterId);
    }
  }

  /// Update halaman terakhir yang dibaca
  Future<ChapterProgress> updatePage(int chapterId, int pageReached) async {
    final current = getProgress(chapterId);
    final totalPages = current.totalPages;
    final isCompleted = pageReached >= totalPages;

    final updated = current.copyWith(
      lastPageReached: pageReached > current.lastPageReached
          ? pageReached
          : current.lastPageReached,
      isCompleted: isCompleted,
      lastReadAt: DateTime.now(),
    );

    await saveProgress(updated);
    await LocalStorage.saveLastPosition(chapterId, pageReached - 1);
    return updated;
  }

  /// Ambil semua progress
  List<ChapterProgress> getAllProgress() {
    return allChapters.map((c) => getProgress(c.id)).toList();
  }

  /// Ambil id bab yang sudah selesai
  List<int> getCompletedChapterIds() =>
      LocalStorage.getCompletedChapterIds();

  /// Reset progress bab tertentu
  Future<void> resetChapter(int chapterId) async {
    await LocalStorage.clearChapterProgress(chapterId);
  }

  /// Reset semua
  Future<void> resetAll() async {
    await LocalStorage.clearAll();
  }
}