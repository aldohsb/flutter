import '../models/word_entry.dart';
import '../models/word_group.dart';
import 'group1_kv_words.dart';
import 'group2_vk_words.dart';
import 'group3_kvk_words.dart';
import 'group4_ngcoda_words.dart';
import 'group5_ngonset_words.dart';
import 'group6_nyonset_words.dart';
import 'group7_diftong_words.dart';
import 'group8_kkv_words.dart';

const List<WordGroup> wordGroups = [
  WordGroup(id: 1, label: 'Pola KV', words: group1KvWords, levelCount: 10),
  WordGroup(id: 2, label: 'Pola VK', words: group2VkWords, levelCount: 5),
  WordGroup(id: 3, label: 'Pola KVK', words: group3KvkWords, levelCount: 10),
  WordGroup(id: 4, label: 'Akhiran NG', words: group4NgCodaWords, levelCount: 5),
  WordGroup(id: 5, label: 'Awalan NG', words: group5NgOnsetWords, levelCount: 5),
  WordGroup(id: 6, label: 'Awalan NY', words: group6NyOnsetWords, levelCount: 5),
  WordGroup(id: 7, label: 'Diftong', words: group7DiftongWords, levelCount: 5),
  WordGroup(id: 8, label: 'Gugus Konsonan', words: group8KkvWords, levelCount: 5),
];

class WordBank {
  WordBank._();

  static int get totalLevels =>
      wordGroups.fold(0, (sum, g) => sum + g.levelCount);

  static int groupIndexForLevel(int level) {
    var remaining = level;
    for (var i = 0; i < wordGroups.length; i++) {
      if (remaining <= wordGroups[i].levelCount) return i;
      remaining -= wordGroups[i].levelCount;
    }
    return wordGroups.length - 1;
  }

  static int levelStartOfGroup(int groupIndex) {
    var start = 1;
    for (var i = 0; i < groupIndex; i++) {
      start += wordGroups[i].levelCount;
    }
    return start;
  }

  static WordGroup groupAt(int index) => wordGroups[index];

  static List<WordEntry> previousPool(int groupIndex) {
    final pool = <WordEntry>[];
    for (var i = 0; i < groupIndex; i++) {
      pool.addAll(wordGroups[i].words);
    }
    return pool;
  }
}