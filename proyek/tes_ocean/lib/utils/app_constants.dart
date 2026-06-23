/// Kumpulan konstanta yang dipakai di seluruh aplikasi agar nilai-nilai
/// penting (skala jawaban, nama box Hive, dsb.) terpusat di satu tempat.
class AppConstants {
  AppConstants._();

  /// Label skala Likert 1-7 yang ditampilkan pada setiap pertanyaan.
  /// Skala 7 poin terbukti lebih akurat secara psikometri dibanding 5 poin
  /// karena menangkap gradasi sikap yang lebih halus, mengurangi central
  /// tendency bias, dan meningkatkan reliabilitas (α ≈ 0.85–0.92).
  static const List<String> likertLabels = [
    'Sangat Tidak Setuju',
    'Tidak Setuju',
    'Agak Tidak Setuju',
    'Netral / Tergantung Situasi',
    'Agak Setuju',
    'Setuju',
    'Sangat Setuju',
  ];

  /// Nilai mentah (1-7) yang berkorespondensi dengan [likertLabels].
  static const List<int> likertValues = [1, 2, 3, 4, 5, 6, 7];

  /// Instruksi kejujuran yang ditampilkan di halaman intro sebelum quiz
  /// dimulai, untuk meminimalkan social desirability bias dan mendorong
  /// responden memilih jawaban yang benar-benar mencerminkan diri mereka.
  static const String honestInstruction =
      'Jawablah berdasarkan diri Anda yang sebenarnya — bukan '
      'yang Anda harapkan atau yang terlihat baik di mata orang lain.';

  static const String neutralWarning =
      'Hindari terlalu sering memilih "Netral / Tergantung Situasi". '
      'Jika Anda ragu, pilihlah yang paling mendekati perasaan Anda '
      'secara umum — bukan dalam satu situasi tertentu.';

  static const String introInstructions = '''Tes ini terdiri dari 50 pernyataan tentang kepribadian Anda.

Untuk setiap pernyataan, pilih jawaban yang paling mencerminkan diri Anda secara umum dalam kehidupan sehari-hari — bukan bagaimana Anda ingin terlihat, dan bukan berdasarkan situasi yang sangat khusus.

Tidak ada jawaban benar atau salah. Hasil yang paling akurat hanya bisa Anda dapatkan dengan bersikap jujur pada diri sendiri.''';

  static const int totalQuestions = 50;
  static const int questionsPerTrait = 10;

  static const String userProfileBox = 'user_profiles_box';
  static const String quizResultBox = 'quiz_results_box';
  static const String activeUserKey = 'active_user_key';
  static const String settingsBox = 'settings_box';
}