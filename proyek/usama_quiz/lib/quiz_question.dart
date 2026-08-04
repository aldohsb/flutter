import 'character_item.dart';

/// Arah soal: apakah pertanyaan menampilkan aksara Jepang dan opsi jawaban
/// dalam huruf latin, atau sebaliknya. Diacak agar peserta terlatih dua arah.
enum QuestionDirection { scriptToRomaji, romajiToScript }

/// Satu soal pilihan ganda lengkap dengan 4 opsi jawaban (1 benar, 3 pengecoh).
class QuizQuestion {
  /// Aksara asli yang sedang diujikan pada soal ini. Disimpan agar
  /// [MistakeService] bisa mencatat statistik benar/salah per-aksara,
  /// terlepas dari arah soal ([direction]) yang sedang ditampilkan.
  final CharacterItem target;
  final String promptText;
  final QuestionDirection direction;
  final List<String> options;
  final String correctAnswer;

  const QuizQuestion({
    required this.target,
    required this.promptText,
    required this.direction,
    required this.options,
    required this.correctAnswer,
  });

  bool isCorrect(String selected) => selected == correctAnswer;
}