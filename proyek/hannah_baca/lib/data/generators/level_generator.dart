import 'dart:math';
import '../../core/constants/app_constants.dart';
import '../models/level_config.dart';
import '../models/page_data.dart';
import '../models/word_entry.dart';
import '../wordbank/word_bank.dart';

class LevelGenerator {
  LevelGenerator._();

  // 50% dari kelompok saat ini, 50% dari gabungan kelompok sebelumnya,
  // lalu diacak (seeded per level agar konsisten tiap dibuka)
  static List<PageData> generatePages(int level) {
    final config = LevelConfig.fromLevel(level);
    final group = WordBank.groupAt(config.groupIndex);
    final previousPool = WordBank.previousPool(config.groupIndex);
    final random = Random(level * 7919);

    const totalPages = AppConstants.pagesPerLevel;
    final half = totalPages ~/ 2;

    final slots = <WordEntry>[];
    if (previousPool.isEmpty) {
      slots.addAll(_pickWords(group.words, totalPages, random));
    } else {
      slots.addAll(_pickWords(group.words, half, random));
      slots.addAll(_pickWords(previousPool, totalPages - half, random));
    }
    slots.shuffle(random);

    return [
      for (var i = 0; i < slots.length; i++)
        PageData(pageIndex: i, words: [slots[i]]),
    ];
  }

  static List<WordEntry> _pickWords(
    List<WordEntry> pool,
    int count,
    Random random,
  ) {
    final shuffled = List<WordEntry>.from(pool)..shuffle(random);
    if (shuffled.length >= count) return shuffled.take(count).toList();

    final result = <WordEntry>[];
    while (result.length < count) {
      result.add(pool[random.nextInt(pool.length)]);
    }
    return result;
  }
}