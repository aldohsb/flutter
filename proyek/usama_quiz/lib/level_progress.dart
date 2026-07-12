/// Menyimpan progres pemain untuk satu level tertentu.
///
/// `stars` bernilai 0-3, dihitung dari `bestScore` (jumlah jawaban benar
/// terbaik dari 10 soal):
///   - 0-6 benar  -> 0 bintang (belum lulus)
///   - 7-8 benar  -> 1 bintang
///   - 9 benar    -> 2 bintang
///   - 10 benar   -> 3 bintang
class LevelProgress {
  final int level;
  final int bestScore;
  final int stars;

  const LevelProgress({
    required this.level,
    this.bestScore = 0,
    this.stars = 0,
  });

  bool get isCompleted => stars > 0;

  factory LevelProgress.empty(int level) => LevelProgress(level: level);

  factory LevelProgress.fromScore(int level, int score) {
    return LevelProgress(
      level: level,
      bestScore: score,
      stars: starsForScore(score),
    );
  }

  /// Dipakai juga oleh [ResultScreen] untuk menghitung bintang secara
  /// konsisten dengan yang tersimpan di [ProgressService].
  static int starsForScore(int score) {
    if (score >= 10) return 3;
    if (score == 9) return 2;
    if (score >= 7) return 1;
    return 0;
  }

  /// Menggabungkan skor baru dengan progres lama, mengambil yang terbaik.
  LevelProgress mergeWithNewScore(int newScore) {
    if (newScore <= bestScore) return this;
    return LevelProgress.fromScore(level, newScore);
  }

  Map<String, dynamic> toJson() => {
        'level': level,
        'bestScore': bestScore,
        'stars': stars,
      };

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      level: json['level'] as int,
      bestScore: json['bestScore'] as int? ?? 0,
      stars: json['stars'] as int? ?? 0,
    );
  }
}
