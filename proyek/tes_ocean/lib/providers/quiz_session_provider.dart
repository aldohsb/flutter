import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/quiz_questions.dart';
import '../models/ocean_trait.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import '../services/scoring_service.dart';
import 'result_provider.dart';

const _uuid = Uuid();

/// Merepresentasikan state sesi quiz yang sedang berjalan: posisi soal saat
/// ini beserta seluruh jawaban yang sudah dipilih pengguna.
class QuizSessionState {
  const QuizSessionState({
    required this.currentIndex,
    required this.answers,
  });

  final int currentIndex;
  final Map<int, int> answers;

  List<QuizQuestion> get questions => quizQuestions;

  QuizQuestion get currentQuestion => questions[currentIndex];

  int get totalQuestions => questions.length;

  double get progress => (currentIndex + 1) / totalQuestions;

  bool get isFirstQuestion => currentIndex == 0;

  bool get isLastQuestion => currentIndex == totalQuestions - 1;

  int? get currentAnswer => answers[currentQuestion.id];

  bool get canGoNext => currentAnswer != null;

  bool get isComplete => answers.length == totalQuestions;

  QuizSessionState copyWith({
    int? currentIndex,
    Map<int, int>? answers,
  }) {
    return QuizSessionState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
    );
  }
}

/// Mengelola alur sesi quiz: menjawab pertanyaan, berpindah soal, dan
/// menyimpan hasil akhir ke penyimpanan lokal saat quiz selesai.
class QuizSessionNotifier extends Notifier<QuizSessionState> {
  @override
  QuizSessionState build() {
    return const QuizSessionState(currentIndex: 0, answers: {});
  }

  void selectAnswer(int value) {
    final updatedAnswers = Map<int, int>.from(state.answers);
    updatedAnswers[state.currentQuestion.id] = value;
    state = state.copyWith(answers: updatedAnswers);
  }

  void goToNext() {
    if (state.isLastQuestion) return;
    state = state.copyWith(currentIndex: state.currentIndex + 1);
  }

  void goToPrevious() {
    if (state.isFirstQuestion) return;
    state = state.copyWith(currentIndex: state.currentIndex - 1);
  }

  void reset() {
    state = const QuizSessionState(currentIndex: 0, answers: {});
  }

  /// Menghitung skor akhir, menyimpannya sebagai [QuizResult] baru untuk
  /// [userId], lalu mengembalikan hasilnya.
  Future<QuizResult> finishAndSave(String userId) async {
    final scores = ScoringService.calculateScores(state.answers);

    final result = QuizResult(
      id: _uuid.v4(),
      userId: userId,
      completedAt: DateTime.now(),
      opennessScore: scores[OceanTrait.openness]!,
      conscientiousnessScore: scores[OceanTrait.conscientiousness]!,
      extraversionScore: scores[OceanTrait.extraversion]!,
      agreeablenessScore: scores[OceanTrait.agreeableness]!,
      neuroticismScore: scores[OceanTrait.neuroticism]!,
    );

    final repo = ref.read(resultRepositoryProvider);
    await repo.add(result);

    ref.invalidate(userResultHistoryProvider(userId));

    return result;
  }
}

final quizSessionProvider =
    NotifierProvider<QuizSessionNotifier, QuizSessionState>(
  QuizSessionNotifier.new,
);
