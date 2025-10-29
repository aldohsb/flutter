class LevelModel {
  final int levelNumber;
  final int startRank; // Kata mulai dari rank berapa
  final int endRank; // Kata sampai rank berapa
  final int totalQuestions;
  final int minPassScore;

  LevelModel({
    required this.levelNumber,
    required this.startRank,
    required this.endRank,
    required this.totalQuestions,
    required this.minPassScore,
  });

  // Generate level configuration
  factory LevelModel.generate(int levelNumber) {
    // Setiap 20 level = 100 kata baru
    // Level 1-20: rank 100-200
    // Level 21-40: rank 200-300
    // dst sampai level 350
    // Level 341-350: rank 1800-1850 (karena 350/20 = 17.5, jadi butuh rank sampai 100 + (17*100) + 50 = 1850)
    
    int groupIndex = ((levelNumber - 1) ~/ 20);
    int startRank = 100 + (groupIndex * 100);
    int endRank = startRank + 300;

    return LevelModel(
      levelNumber: levelNumber,
      startRank: startRank,
      endRank: endRank,
      totalQuestions: 10,
      minPassScore: 7,
    );
  }

  // Hitung bintang berdasarkan score
  int calculateStars(int correctAnswers) {
    if (correctAnswers == 10) return 3;
    if (correctAnswers == 9) return 2;
    if (correctAnswers == 8) return 1;
    return 0;
  }

  // Apakah lulus level
  bool isPassed(int correctAnswers) {
    return correctAnswers >= minPassScore;
  }
}