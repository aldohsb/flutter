import 'ocean_trait.dart';

/// Merepresentasikan satu butir pertanyaan dalam tes kepribadian OCEAN.
///
/// [isReversed] menandakan apakah pertanyaan ini bersifat negatif terhadap
/// trait-nya sehingga skor jawabannya perlu dibalik (reverse-scoring) saat
/// dihitung, sesuai konvensi standar instrumen Big Five.
class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.text,
    required this.trait,
    required this.isReversed,
  });

  final int id;
  final String text;
  final OceanTrait trait;
  final bool isReversed;
}
