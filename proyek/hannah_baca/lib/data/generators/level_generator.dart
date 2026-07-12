import 'dart:math';
import '../../core/constants/app_constants.dart';
import '../models/level_config.dart';
import '../models/page_data.dart';
import '../models/word_entry.dart';
import '../wordbank/word_bank.dart';

class LevelGenerator {
  LevelGenerator._();

  // Deterministic (seeded) agar konten level konsisten tiap dibuka
  static List<PageData> generatePages(int level) {
    final config = LevelConfig.fromLevel(level);
    final pool = _combinedPool(config.activeTiers);
    final random = Random(level * 7919);
    final pages = <PageData>[];

    for (var i = 0; i < AppConstants.pagesPerLevel; i++) {
      final words = _pickWords(pool, config.wordsPerPage, random);
      pages.add(PageData(pageIndex: i, words: words));
    }
    return pages;
  }

  static List<WordEntry> _combinedPool(List<int> tiers) {
    final pool = <WordEntry>[];
    for (final tier in tiers) {
      pool.addAll(WordBank.byTier(tier));
    }
    return pool;
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