import 'character_item.dart';

/// Statistik jawaban untuk satu aksara: berapa kali dijawab benar dan
/// berapa kali salah selama mengerjakan kuis. Dipakai untuk menyusun
/// daftar "aksara yang perlu diulang" di [MistakeReviewScreen].
class CharacterStat {
  final String character;
  final String romaji;
  final int wrongCount;
  final int correctCount;

  const CharacterStat({
    required this.character,
    required this.romaji,
    this.wrongCount = 0,
    this.correctCount = 0,
  });

  int get totalAttempts => wrongCount + correctCount;

  /// Persentase jawaban benar (0.0 - 1.0). Dianggap 1.0 jika belum pernah
  /// dicoba sama sekali agar tidak tampil seolah-olah 0%.
  double get accuracy => totalAttempts == 0 ? 1.0 : correctCount / totalAttempts;

  CharacterStat copyWithAnswer({required bool wasCorrect}) {
    return CharacterStat(
      character: character,
      romaji: romaji,
      wrongCount: wrongCount + (wasCorrect ? 0 : 1),
      correctCount: correctCount + (wasCorrect ? 1 : 0),
    );
  }

  Map<String, dynamic> toJson() => {
        'character': character,
        'romaji': romaji,
        'wrongCount': wrongCount,
        'correctCount': correctCount,
      };

  factory CharacterStat.fromJson(Map<String, dynamic> json) {
    return CharacterStat(
      character: json['character'] as String,
      romaji: json['romaji'] as String,
      wrongCount: json['wrongCount'] as int? ?? 0,
      correctCount: json['correctCount'] as int? ?? 0,
    );
  }

  factory CharacterStat.fromCharacterItem(CharacterItem item) {
    return CharacterStat(character: item.character, romaji: item.romaji);
  }
}