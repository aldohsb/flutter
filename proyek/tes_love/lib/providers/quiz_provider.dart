import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../data/questions_data.dart';
import '../models/quiz_result_model.dart';
import '../utils/storage_service.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuizQuestion> _questions = List.from(quizQuestions);
  int _currentIndex = 0;
  // Map soal id → love language yang dipilih
  final Map<int, LoveLanguage> _answers = {};
  QuizResultModel? _lastResult;
  List<QuizResultModel> _history = [];
  bool _isFinished = false;

  // ── Getters ───────────────────────────────────────────────

  List<QuizQuestion> get questions => _questions;
  int get currentIndex => _currentIndex;
  QuizQuestion get currentQuestion => _questions[_currentIndex];
  int get totalQuestions => _questions.length;
  bool get isFinished => _isFinished;
  QuizResultModel? get lastResult => _lastResult;
  List<QuizResultModel> get history => List.unmodifiable(_history);

  double get progress => (_currentIndex) / totalQuestions;
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;
  LoveLanguage? get currentAnswer => _answers[currentQuestion.id];
  bool get hasAnswered => _answers.containsKey(currentQuestion.id);

  // ── Quiz Flow ─────────────────────────────────────────────

  void answer(LoveLanguage language) {
    _answers[currentQuestion.id] = language;
    notifyListeners();
  }

  void nextQuestion() {
    if (!hasAnswered) return;
    if (isLastQuestion) {
      _finishQuiz();
    } else {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void _finishQuiz() {
    final scores = <LoveLanguage, int>{};
    for (final ll in LoveLanguage.values) {
      scores[ll] = 0;
    }
    for (final ll in _answers.values) {
      scores[ll] = (scores[ll] ?? 0) + 1;
    }
    _lastResult = QuizResultModel(
      id: const Uuid().v4(),
      userId: '', // diisi saat save
      takenAt: DateTime.now(),
      scores: scores,
    );
    _isFinished = true;
    notifyListeners();
  }

  Future<void> saveResult(String userId, StorageService storage) async {
    if (_lastResult == null) return;
    final result = QuizResultModel(
      id: _lastResult!.id,
      userId: userId,
      takenAt: _lastResult!.takenAt,
      scores: _lastResult!.scores,
    );
    await storage.saveResult(result);
    _lastResult = result;
    notifyListeners();
  }

  Future<void> loadHistory(String userId, StorageService storage) async {
    _history = await storage.getResults(userId);
    _history.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _answers.clear();
    _lastResult = null;
    _isFinished = false;
    notifyListeners();
  }
}