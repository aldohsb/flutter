// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  static const String appName = 'Baca Hannah';
  static const String appVersion = '1.0.0';

  // SharedPreferences keys
  static const String prefKeyProgress = 'chapter_progress';
  static const String prefKeyLastChapter = 'last_chapter';
  static const String prefKeyLastPage = 'last_page';
  static const String prefKeyCompletedChapters = 'completed_chapters';

  // Reading page constraints
  static const int minSyllablesPerPage = 1;
  static const int maxSyllablesPerPage = 3;
  static const int minPagesPerChapter = 20;
  static const int maxPagesPerChapter = 30;

  // Animation durations
  static const Duration pageTransitionDuration = Duration(milliseconds: 350);
  static const Duration splashDuration = Duration(milliseconds: 2000);
  static const Duration celebrationDuration = Duration(milliseconds: 1500);

  // Total chapters (akan bertambah)
  static const int totalChapters = 80; 
}
