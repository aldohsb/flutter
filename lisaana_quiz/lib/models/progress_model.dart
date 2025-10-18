class ProgressModel {
  final String userId;
  final int levelNumber;
  final int correctAnswers;
  final int totalQuestions;
  final int stars;
  final bool isPassed;
  final DateTime completedAt;

  ProgressModel({
    required this.userId,
    required this.levelNumber,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.stars,
    required this.isPassed,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'levelNumber': levelNumber,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'stars': stars,
      'isPassed': isPassed,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      userId: json['userId'] as String,
      levelNumber: json['levelNumber'] as int,
      correctAnswers: json['correctAnswers'] as int,
      totalQuestions: json['totalQuestions'] as int,
      stars: json['stars'] as int,
      isPassed: json['isPassed'] as bool,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );
  }

  double get scorePercentage => (correctAnswers / totalQuestions) * 100;
}