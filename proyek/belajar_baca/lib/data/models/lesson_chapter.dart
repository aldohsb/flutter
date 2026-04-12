import 'lesson_card.dart';

class LessonChapter {
  final String title;
  final String subtitle;
  final int gradientIndex;
  final List<LessonCard> cards;

  const LessonChapter({
    required this.title,
    required this.subtitle,
    required this.gradientIndex,
    required this.cards,
  });

  int get totalCards => cards.length;
}
