import '../models/word_entry.dart';
import 'tier1_words.dart';
import 'tier2_words.dart';
import 'tier3_words.dart';
import 'tier4_words.dart';
import 'tier5_words.dart';

class WordBank {
  WordBank._();

  static const Map<int, List<WordEntry>> _byTier = {
    1: tier1Words,
    2: tier2Words,
    3: tier3Words,
    4: tier4Words,
    5: tier5Words,
  };

  static List<WordEntry> byTier(int tier) => _byTier[tier] ?? tier1Words;
}