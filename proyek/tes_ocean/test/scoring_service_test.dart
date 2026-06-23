import 'package:flutter_test/flutter_test.dart';
import 'package:tes_ocean/data/quiz_questions.dart';
import 'package:tes_ocean/models/ocean_trait.dart';
import 'package:tes_ocean/services/scoring_service.dart';

void main() {
  group('ScoringService', () {
    test('bank soal berisi tepat 50 pertanyaan', () {
      expect(quizQuestions.length, 50);
    });

    test('setiap trait memiliki tepat 10 pertanyaan', () {
      for (final trait in OceanTrait.values) {
        final count = quizQuestions.where((q) => q.trait == trait).length;
        expect(count, 10, reason: 'Trait $trait harus memiliki 10 soal');
      }
    });

    test('skor 100 tercapai saat jawaban substantif tinggi secara konsisten', () {
      final answers = <int, int>{
        for (final q in quizQuestions) q.id: q.isReversed ? 1 : 5,
      };

      final scores = ScoringService.calculateScores(answers);

      for (final trait in OceanTrait.values) {
        expect(scores[trait], closeTo(100, 0.01));
      }
    });

    test('skor 0 tercapai saat jawaban substantif rendah secara konsisten', () {
      final answers = <int, int>{
        for (final q in quizQuestions) q.id: q.isReversed ? 5 : 1,
      };

      final scores = ScoringService.calculateScores(answers);

      for (final trait in OceanTrait.values) {
        expect(scores[trait], closeTo(0, 0.01));
      }
    });

    test('skor berada di sekitar 50 saat seluruh jawaban netral', () {
      final answers = <int, int>{
        for (final q in quizQuestions) q.id: 3,
      };

      final scores = ScoringService.calculateScores(answers);

      for (final trait in OceanTrait.values) {
        expect(scores[trait], closeTo(50, 0.01));
      }
    });

    test('isComplete mengembalikan false jika belum semua soal dijawab', () {
      final partialAnswers = <int, int>{1: 5, 2: 4};
      expect(ScoringService.isComplete(partialAnswers), isFalse);
    });
  });
}
