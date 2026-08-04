import 'dart:math';
import 'hijaiyah_level_config.dart';
import 'hijaiyah_letters.dart';
import 'hijaiyah_page_data.dart';
import '../models/hijaiyah_letter.dart';

class HijaiyahGenerator {
  HijaiyahGenerator._();

  static List<HijaiyahPageData> generatePages(int level) {
    final unlockedCount = HijaiyahLevelConfig.unlockedCountForLevel(level);
    final pool = hijaiyahLetters.take(unlockedCount).toList();
    final random = Random(level * 1013);
    final pages = <HijaiyahPageData>[];

    for (var i = 0; i < HijaiyahLevelConfig.pagesPerLevel; i++) {
      final letters = _pick(pool, HijaiyahLevelConfig.lettersPerPage, random);
      pages.add(HijaiyahPageData(pageIndex: i, letters: letters));
    }
    return pages;
  }

  static List<HijaiyahLetter> _pick(
    List<HijaiyahLetter> pool,
    int count,
    Random random,
  ) {
    final shuffled = List<HijaiyahLetter>.from(pool)..shuffle(random);
    if (shuffled.length >= count) return shuffled.take(count).toList();

    final result = <HijaiyahLetter>[];
    while (result.length < count) {
      result.add(pool[random.nextInt(pool.length)]);
    }
    return result;
  }
}
