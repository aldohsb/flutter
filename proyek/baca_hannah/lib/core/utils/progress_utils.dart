// lib/core/utils/progress_utils.dart

class ProgressUtils {
  ProgressUtils._();

  /// Hitung persentase progres bab
  static double calculateChapterProgress(int currentPage, int totalPages) {
    if (totalPages == 0) return 0.0;
    return (currentPage / totalPages).clamp(0.0, 1.0);
  }

  /// Hitung bintang berdasarkan progres
  /// 1 bintang: mulai (page 1)
  /// 2 bintang: setengah
  /// 3 bintang: selesai
  static int calculateStars(int currentPage, int totalPages) {
    if (totalPages == 0) return 0;
    final progress = calculateChapterProgress(currentPage, totalPages);
    if (progress >= 1.0) return 3;
    if (progress >= 0.5) return 2;
    if (progress > 0) return 1;
    return 0;
  }

  /// Format label progres: "Halaman 5 dari 20"
  static String formatPageLabel(int currentPage, int totalPages) {
    return 'Halaman $currentPage dari $totalPages';
  }

  /// Format label persentase: "75%"
  static String formatPercent(double progress) {
    return '${(progress * 100).round()}%';
  }

  /// Cek apakah bab sudah selesai
  static bool isChapterCompleted(int currentPage, int totalPages) {
    return currentPage >= totalPages;
  }

  /// Cek apakah bab boleh diakses (belum ada lock system — semua terbuka)
  static bool isChapterUnlocked(int chapterIndex, List<int> completedChapters) {
    if (chapterIndex == 0) return true;
    return completedChapters.contains(chapterIndex - 1);
  }
}