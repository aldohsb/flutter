import '../models/ocean_trait.dart';

/// Kategori tingkat skor pada suatu trait kepribadian.
enum ScoreLevel { low, moderate, high }

/// Berisi logika untuk mengubah skor numerik (0-100) menjadi kategori
/// dan narasi interpretasi yang mudah dipahami pengguna awam.
class ScoreInterpreter {
  ScoreInterpreter._();

  static ScoreLevel levelOf(double score) {
    if (score < 40) return ScoreLevel.low;
    if (score < 70) return ScoreLevel.moderate;
    return ScoreLevel.high;
  }

  static String levelLabel(ScoreLevel level) {
    switch (level) {
      case ScoreLevel.low:
        return 'Rendah';
      case ScoreLevel.moderate:
        return 'Sedang';
      case ScoreLevel.high:
        return 'Tinggi';
    }
  }

  /// Memberikan narasi singkat berdasarkan kombinasi trait dan level skor.
  static String interpretation(OceanTrait trait, double score) {
    final level = levelOf(score);
    switch (trait) {
      case OceanTrait.openness:
        switch (level) {
          case ScoreLevel.low:
            return 'Anda cenderung praktis dan menyukai hal-hal yang familiar '
                'dibandingkan ide-ide abstrak atau pengalaman baru.';
          case ScoreLevel.moderate:
            return 'Anda cukup terbuka terhadap ide baru, namun tetap '
                'nyaman dengan rutinitas yang sudah dikenal.';
          case ScoreLevel.high:
            return 'Anda sangat terbuka terhadap ide baru, imajinatif, dan '
                'antusias mengeksplorasi pengalaman yang belum pernah dicoba.';
        }
      case OceanTrait.conscientiousness:
        switch (level) {
          case ScoreLevel.low:
            return 'Anda cenderung spontan dan fleksibel, terkadang kurang '
                'terstruktur dalam merencanakan sesuatu.';
          case ScoreLevel.moderate:
            return 'Anda cukup terorganisir dan bertanggung jawab, dengan '
                'keseimbangan antara disiplin dan fleksibilitas.';
          case ScoreLevel.high:
            return 'Anda sangat disiplin, terorganisir, dan dapat diandalkan '
                'dalam menyelesaikan tanggung jawab.';
        }
      case OceanTrait.extraversion:
        switch (level) {
          case ScoreLevel.low:
            return 'Anda cenderung introvert, lebih menikmati ketenangan '
                'dan interaksi sosial dalam skala kecil.';
          case ScoreLevel.moderate:
            return 'Anda memiliki keseimbangan antara menikmati interaksi '
                'sosial dan waktu sendiri.';
          case ScoreLevel.high:
            return 'Anda sangat ekstrover, mudah bergaul, dan mendapatkan '
                'energi dari interaksi dengan banyak orang.';
        }
      case OceanTrait.agreeableness:
        switch (level) {
          case ScoreLevel.low:
            return 'Anda cenderung kompetitif, kritis, dan lebih '
                'mengutamakan logika daripada perasaan dalam berinteraksi.';
          case ScoreLevel.moderate:
            return 'Anda cukup kooperatif dan ramah, namun tetap bisa '
                'tegas saat diperlukan.';
          case ScoreLevel.high:
            return 'Anda sangat ramah, empatik, dan selalu mengutamakan '
                'keharmonisan dalam hubungan dengan orang lain.';
        }
      case OceanTrait.neuroticism:
        switch (level) {
          case ScoreLevel.low:
            return 'Anda cenderung tenang, stabil secara emosi, dan tidak '
                'mudah terpengaruh oleh tekanan.';
          case ScoreLevel.moderate:
            return 'Anda cukup stabil secara emosional, meski sesekali '
                'merasa cemas dalam situasi tertentu.';
          case ScoreLevel.high:
            return 'Anda cenderung sensitif terhadap stres dan lebih mudah '
                'mengalami emosi seperti cemas atau khawatir.';
        }
    }
  }
}
