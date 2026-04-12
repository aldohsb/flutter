import '../models/lesson_card.dart';
import '../models/lesson_chapter.dart';
import '../../core/constants/syllable_data.dart';

class LessonRepository {
  static LessonRepository? _instance;
  LessonRepository._();

  static LessonRepository get instance {
    _instance ??= LessonRepository._();
    return _instance!;
  }

  late final List<LessonChapter> _chapters = _buildChapters();

  List<LessonChapter> get chapters => _chapters;

  LessonChapter getChapter(int index) => _chapters[index];

  List<LessonChapter> _buildChapters() {
    return SyllableData.chapters.asMap().entries.map((entry) {
      final data = entry.value;
      final rawCards = data['cards'] as List<List<String>>;

      final cards = rawCards.asMap().entries.map((e) {
        return LessonCard(syllables: e.value, cardIndex: e.key);
      }).toList();

      return LessonChapter(
        title: data['title'] as String,
        subtitle: data['subtitle'] as String,
        gradientIndex: data['gradientIndex'] as int,
        cards: cards,
      );
    }).toList();
  }
}
