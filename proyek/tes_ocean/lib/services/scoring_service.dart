import '../data/quiz_questions.dart';
import '../models/ocean_trait.dart';
import '../models/quiz_question.dart';

/// Menghitung skor akhir lima trait OCEAN dari kumpulan jawaban mentah.
///
/// Jawaban diberikan dalam skala Likert 1-7. Untuk pertanyaan dengan
/// [QuizQuestion.isReversed] bernilai true, nilai jawaban dibalik terlebih
/// dahulu (skor 8 - jawaban) sebelum dijumlahkan, sesuai konvensi
/// reverse-scoring pada instrumen kepribadian Big Five.
///
/// Rentang skor mentah per trait (10 soal × skala 1-7):
///   Minimum : 10 × 1 = 10
///   Maksimum : 10 × 7 = 70
/// Dinormalisasi ke skala 0-100 untuk kemudahan tampilan.
class ScoringService {
  ScoringService._();

  /// [answers] adalah peta dari id pertanyaan ke nilai jawaban (1-7).
  /// Mengembalikan peta trait ke skor dalam rentang 0-100.
  static Map<OceanTrait, double> calculateScores(Map<int, int> answers) {
    final Map<OceanTrait, int> rawTotals = {
      for (final trait in OceanTrait.values) trait: 0,
    };

    for (final question in quizQuestions) {
      final rawAnswer = answers[question.id];
      if (rawAnswer == null) continue;

      // Reverse scoring: nilai dibalik dengan rumus (maxScale + 1 - jawaban)
      // Untuk skala 1-7: nilai balik = 8 - jawaban
      final effectiveValue = question.isReversed ? (8 - rawAnswer) : rawAnswer;
      rawTotals[question.trait] = rawTotals[question.trait]! + effectiveValue;
    }

    // Rentang skor mentah per trait: min=10, max=70
    // Dikonversi ke skala 0-100 agar konsisten dan mudah ditampilkan.
    const int minRaw = 10;
    const int maxRaw = 70;

    return rawTotals.map((trait, total) {
      final normalized = ((total - minRaw) / (maxRaw - minRaw)) * 100;
      return MapEntry(trait, normalized.clamp(0, 100).toDouble());
    });
  }

  /// Menghitung jumlah pertanyaan yang sudah terjawab.
  static int answeredCount(Map<int, int> answers) => answers.length;

  static bool isComplete(Map<int, int> answers) {
    return answers.length == quizQuestions.length;
  }
}