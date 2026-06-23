import 'package:hive/hive.dart';

part 'quiz_result.g.dart';

/// Menyimpan satu sesi hasil tes OCEAN milik seorang pengguna.
///
/// Skor tiap trait disimpan dalam rentang 0-100 (persentase) agar mudah
/// ditampilkan pada grafik maupun dibandingkan antar sesi.
@HiveType(typeId: 1)
class QuizResult extends HiveObject {
  QuizResult({
    required this.id,
    required this.userId,
    required this.completedAt,
    required this.opennessScore,
    required this.conscientiousnessScore,
    required this.extraversionScore,
    required this.agreeablenessScore,
    required this.neuroticismScore,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final DateTime completedAt;

  @HiveField(3)
  final double opennessScore;

  @HiveField(4)
  final double conscientiousnessScore;

  @HiveField(5)
  final double extraversionScore;

  @HiveField(6)
  final double agreeablenessScore;

  @HiveField(7)
  final double neuroticismScore;

  /// Mengembalikan peta trait-ke-skor untuk mempermudah iterasi pada UI.
  Map<String, double> toScoreMap() {
    return {
      'O': opennessScore,
      'C': conscientiousnessScore,
      'E': extraversionScore,
      'A': agreeablenessScore,
      'N': neuroticismScore,
    };
  }
}
