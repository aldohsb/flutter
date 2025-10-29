import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/hive_service.dart';
import '../services/quiz_service.dart';
import '../services/audio_service.dart';

// ============= USER PROVIDER =============
class UserProvider extends ChangeNotifier {
  final HiveService _hiveService;
  
  String? _currentUsername;
  UserProfile? _currentUser;
  List<UserProfile> _allUsers = [];

  UserProvider(this._hiveService);

  String? get currentUsername => _currentUsername;
  UserProfile? get currentUser => _currentUser;
  List<UserProfile> get allUsers => _allUsers;
  bool get isUserLoaded => _currentUser != null;

  Future<void> loadAllUsers() async {
    _allUsers = await _hiveService.getAllUsers();
    notifyListeners();
  }

  Future<void> createUser(String username) async {
    await _hiveService.createUser(username);
    _currentUsername = username;
    _currentUser = await _hiveService.getUser(username);
    _allUsers.add(_currentUser!);
    notifyListeners();
  }

  Future<void> switchUser(String username) async {
    _currentUsername = username;
    _currentUser = await _hiveService.getUser(username);
    await _hiveService.setCurrentUser(username);
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    final username = _hiveService.getCurrentUser();
    if (username != null) {
      _currentUsername = username;
      _currentUser = await _hiveService.getUser(username);
      notifyListeners();
    }
  }

  Future<void> deleteUser(String username) async {
    await _hiveService.deleteUser(username);
    _allUsers.removeWhere((u) => u.username == username);
    
    if (_currentUsername == username) {
      _currentUsername = null;
      _currentUser = null;
    }
    notifyListeners();
  }

  Future<void> updateUserStats() async {
    if (_currentUser != null) {
      _currentUser = await _hiveService.getUser(_currentUsername!);
      notifyListeners();
    }
  }
}

// ============= PROGRESS PROVIDER =============
class ProgressProvider extends ChangeNotifier {
  final HiveService _hiveService;
  
  final Map<int, LevelProgress?> _levelProgress = {};
  int _highestLevel = 1;

  ProgressProvider(this._hiveService);

  Map<int, LevelProgress?> get levelProgress => _levelProgress;
  int get highestLevel => _highestLevel;

  Future<void> loadProgress(String username) async {
    _highestLevel = await _hiveService.getUserHighestLevel(username);
    
    for (int i = 1; i <= 20; i++) {
      final progress = await _hiveService.getLevelProgress(username, i);
      _levelProgress[i] = progress;
    }
    notifyListeners();
  }

  Future<void> saveLevelProgress(
    String username,
    int levelNumber,
    int correctAnswers,
    int totalAttempts,
    int starsEarned,
  ) async {
    await _hiveService.saveLevelProgress(
      username,
      levelNumber,
      correctAnswers,
      totalAttempts,
      starsEarned,
    );
    
    _levelProgress[levelNumber] = await _hiveService.getLevelProgress(
      username,
      levelNumber,
    );
    
    _highestLevel = await _hiveService.getUserHighestLevel(username);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserStats(String username) async {
    return await _hiveService.getUserStats(username);
  }

  LevelProgress? getLevelProgress(int level) => _levelProgress[level];
  
  bool isLevelUnlocked(int level) => level <= _highestLevel;
}

// ============= QUIZ PROVIDER =============
class QuizProvider extends ChangeNotifier {
  final QuizService _quizService;
  
  QuizSession? _currentSession;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  String? _selectedAnswer;
  bool? _isCorrect;
  
  List<QuizAnswer> _answers = [];

  QuizProvider(this._quizService);

  QuizSession? get currentSession => _currentSession;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion => _currentQuestionIndex < _questions.length
      ? _questions[_currentQuestionIndex]
      : null;
  bool get isAnswered => _isAnswered;
  String? get selectedAnswer => _selectedAnswer;
  bool? get isCorrect => _isCorrect;
  List<QuizAnswer> get answers => _answers;
  
  int get progress => ((_currentQuestionIndex + 1) / _questions.length * 100).toInt();

  Future<void> initializeQuiz(int level) async {
    _questions = _quizService.generateQuestionsForLevel(level);
    _currentSession = QuizSession(
      levelNumber: level,
      questions: _questions,
      startedAt: DateTime.now(),
    );
    _currentQuestionIndex = 0;
    _isAnswered = false;
    _selectedAnswer = null;
    _isCorrect = null;
    _answers = [];
    notifyListeners();
  }

  void selectAnswer(String answer) {
    if (_isAnswered) return;
    
    _selectedAnswer = answer;
    final question = currentQuestion!;
    _isCorrect = _quizService.validateAnswer(answer, question.correctAnswer);
    _isAnswered = true;
    
    _answers.add(
      QuizAnswer(
        questionId: question.id,
        selectedAnswer: answer,
        correctAnswer: question.correctAnswer,
        isCorrect: _isCorrect!,
        timeSpentSeconds: 0,
      ),
    );
    
    notifyListeners();
  }

  void nextQuestion() {
    if (_isAnswered && _currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _isAnswered = false;
      _selectedAnswer = null;
      _isCorrect = null;
      notifyListeners();
    }
  }

  int getCorrectCount() {
    return _answers.where((a) => a.isCorrect).length;
  }

  int getStarsEarned() {
    final correctCount = getCorrectCount();
    return _quizService.calculateStars(correctCount);
  }

  bool isPassed() {
    return _quizService.checkIfPassed(getCorrectCount());
  }

  void reset() {
    _currentSession = null;
    _questions = [];
    _currentQuestionIndex = 0;
    _isAnswered = false;
    _selectedAnswer = null;
    _isCorrect = null;
    _answers = [];
    notifyListeners();
  }
}

// ============= AUDIO PROVIDER =============
class AudioProvider extends ChangeNotifier {
  final AudioService _audioService;
  
  bool _isMuted = false;

  AudioProvider(this._audioService);

  bool get isMuted => _isMuted;

  Future<void> init() async {
    await _audioService.init();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    _audioService.toggleMute();
    notifyListeners();
  }

  Future<void> playCorrectSound() => _audioService.playCorrectSound();
  Future<void> playWrongSound() => _audioService.playWrongSound();
  Future<void> playLevelCompleteSound() => _audioService.playLevelCompleteSound();
  Future<void> playTapSound() => _audioService.playTapSound();
}