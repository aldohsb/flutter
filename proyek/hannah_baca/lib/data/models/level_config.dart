import '../wordbank/word_bank.dart';

class LevelConfig {
  final int level;
  final int groupIndex;

  const LevelConfig({required this.level, required this.groupIndex});

  factory LevelConfig.fromLevel(int level) {
    return LevelConfig(
      level: level,
      groupIndex: WordBank.groupIndexForLevel(level),
    );
  }
}