class LevelConfig {
  final int level;
  final List<int> activeTiers;
  final int wordsPerPage;

  const LevelConfig({
    required this.level,
    required this.activeTiers,
    required this.wordsPerPage,
  });

  factory LevelConfig.fromLevel(int level) {
    return LevelConfig(
      level: level,
      activeTiers: _tiersForLevel(level),
      wordsPerPage: 1,
    );
  }

  // 01-10: tier1 | 11-30: tier1-2 | 31-40: tier1-3
  // 41-44: tier1-4 | 45-50: tier1-5
  static List<int> _tiersForLevel(int level) {
    if (level <= 60) return const [1, 2];
    if (level <= 90) return const [1, 2, 3];
    if (level <= 120) return const [1, 2, 3, 4];
    return const [1, 2, 3, 4, 5];
  }

  int get maxTier => activeTiers.last;
}