import 'word_entry.dart';

class WordGroup {
  final int id;
  final String label;
  final List<WordEntry> words;
  final int levelCount;

  const WordGroup({
    required this.id,
    required this.label,
    required this.words,
    required this.levelCount,
  });
}