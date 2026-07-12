import 'word_entry.dart';

class PageData {
  final int pageIndex;
  final List<WordEntry> words;

  const PageData({
    required this.pageIndex,
    required this.words,
  });
}