class LessonCard {
  final List<String> syllables; // max 3 suku kata
  final int cardIndex;

  const LessonCard({
    required this.syllables,
    required this.cardIndex,
  });

  String get fullText => syllables.join('');

  bool get isSingle => syllables.length == 1;
}
