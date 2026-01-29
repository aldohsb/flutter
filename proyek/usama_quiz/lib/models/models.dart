import 'package:hive/hive.dart';

part 'models.g.dart';

// ============= USER MODEL =============
@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  late String username;
  
  @HiveField(1)
  late DateTime createdAt;
  
  @HiveField(2)
  late int currentLevel;
  
  @HiveField(3)
  late int totalStars;
  
  @HiveField(4)
  late int totalCorrect;
  
  @HiveField(5)
  late int totalQuestions;

  UserProfile({
    required this.username,
    required this.createdAt,
    this.currentLevel = 1,
    this.totalStars = 0,
    this.totalCorrect = 0,
    this.totalQuestions = 0,
  });

  double get accuracy => totalQuestions == 0 
    ? 0.0 
    : (totalCorrect / totalQuestions) * 100;
}

// ============= LEVEL PROGRESS MODEL =============
@HiveType(typeId: 1)
class LevelProgress extends HiveObject {
  @HiveField(0)
  late int levelNumber;
  
  @HiveField(1)
  late int correctAnswers;
  
  @HiveField(2)
  late int totalAttempts;
  
  @HiveField(3)
  late int stars; // 0-3 bintang
  
  @HiveField(4)
  late bool isCompleted;
  
  @HiveField(5)
  late DateTime completedAt;
  
  @HiveField(6)
  late String username;

  LevelProgress({
    required this.levelNumber,
    required this.username,
    this.correctAnswers = 0,
    this.totalAttempts = 0,
    this.stars = 0,
    this.isCompleted = false,
    required this.completedAt,
  });

  bool get isPassed => correctAnswers >= 7;
}

// ============= QUESTION MODEL =============
class Question {
  final int id;
  final int level;
  final String type; // 'romaji_to_aksara' atau 'aksara_to_romaji'
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String categoryType; // 'hiragana', 'katakana', 'kanji'

  Question({
    required this.id,
    required this.level,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.categoryType,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      level: json['level'] as int,
      type: json['type'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      categoryType: json['categoryType'] as String,
    );
  }
}

// ============= QUIZ ANSWER MODEL =============
class QuizAnswer {
  final int questionId;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final int timeSpentSeconds;

  QuizAnswer({
    required this.questionId,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.timeSpentSeconds,
  });
}

// ============= QUIZ SESSION MODEL =============
class QuizSession {
  final int levelNumber;
  final List<Question> questions;
  final List<QuizAnswer> answers;
  final DateTime startedAt;
  DateTime? endedAt;

  QuizSession({
    required this.levelNumber,
    required this.questions,
    this.answers = const [],
    required this.startedAt,
  });

  int get correctCount => answers.where((a) => a.isCorrect).length;
  int get totalDuration => endedAt != null 
    ? endedAt!.difference(startedAt).inSeconds 
    : 0;
  
  int get starsEarned {
    if (correctCount == 10) return 3;
    if (correctCount == 9) return 2;
    if (correctCount == 8) return 1;
    return 0;
  }
  
  bool get isPassed => correctCount >= 7;
}