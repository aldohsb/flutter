class HijaiyahLevelConfig {
  HijaiyahLevelConfig._();

  static const int totalLevels = 30;
  static const int pagesPerLevel = 20;
  static const int lettersPerPage = 1;
  static const int totalLetterCount = 28;
  static const int startingLetterCount = 5;

  // Level 1 = 5 huruf, tiap level berikutnya +1 huruf baru.
  // Setelah mencapai 28 huruf (level 24), level selanjutnya
  // tetap memakai semua 28 huruf sebagai pool pemantapan.
  static int unlockedCountForLevel(int level) {
    final count = startingLetterCount + (level - 1);
    return count.clamp(startingLetterCount, totalLetterCount);
  }
}