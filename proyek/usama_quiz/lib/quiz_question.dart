/// Arah soal: apakah pertanyaan menampilkan aksara Jepang dan opsi jawaban
/// dalam huruf latin, atau sebaliknya. Diacak agar peserta terlatih dua arah.
enum QuestionDirection { scriptToRomaji, romajiToScript }

/// Satu soal pilihan ganda lengkap dengan 4 opsi jawaban (1 benar, 3 pengecoh).
class QuizQuestion {
  final String promptText;
  final QuestionDirection direction;
  final List<String> options;
  final String correctAnswer;

  const QuizQuestion({
    required this.promptText,
    required this.direction,
    required this.options,
    required this.correctAnswer,
  });

  bool isCorrect(String selected) => selected == correctAnswer;
}
