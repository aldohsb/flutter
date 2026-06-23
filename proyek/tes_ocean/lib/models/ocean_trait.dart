import 'package:flutter/material.dart';

/// Lima dimensi kepribadian dalam model Big Five (OCEAN).
enum OceanTrait {
  openness,
  conscientiousness,
  extraversion,
  agreeableness,
  neuroticism,
}

/// Ekstensi untuk menyediakan metadata tampilan setiap trait.
extension OceanTraitX on OceanTrait {
  String get code {
    switch (this) {
      case OceanTrait.openness:
        return 'O';
      case OceanTrait.conscientiousness:
        return 'C';
      case OceanTrait.extraversion:
        return 'E';
      case OceanTrait.agreeableness:
        return 'A';
      case OceanTrait.neuroticism:
        return 'N';
    }
  }

  String get label {
    switch (this) {
      case OceanTrait.openness:
        return 'Openness';
      case OceanTrait.conscientiousness:
        return 'Conscientiousness';
      case OceanTrait.extraversion:
        return 'Extraversion';
      case OceanTrait.agreeableness:
        return 'Agreeableness';
      case OceanTrait.neuroticism:
        return 'Neuroticism';
    }
  }

  String get labelId {
    switch (this) {
      case OceanTrait.openness:
        return 'Keterbukaan';
      case OceanTrait.conscientiousness:
        return 'Kehati-hatian';
      case OceanTrait.extraversion:
        return 'Ekstraversi';
      case OceanTrait.agreeableness:
        return 'Keramahan';
      case OceanTrait.neuroticism:
        return 'Neurotisisme';
    }
  }

  String get description {
    switch (this) {
      case OceanTrait.openness:
        return 'Menggambarkan seberapa terbuka Anda terhadap ide baru, '
            'imajinasi, dan pengalaman yang belum pernah dicoba.';
      case OceanTrait.conscientiousness:
        return 'Menggambarkan tingkat kedisiplinan, tanggung jawab, '
            'dan orientasi Anda terhadap tujuan jangka panjang.';
      case OceanTrait.extraversion:
        return 'Menggambarkan seberapa besar energi Anda diperoleh dari '
            'interaksi sosial dan lingkungan luar.';
      case OceanTrait.agreeableness:
        return 'Menggambarkan kecenderungan Anda untuk bersikap kooperatif, '
            'empatik, dan mengutamakan keharmonisan.';
      case OceanTrait.neuroticism:
        return 'Menggambarkan kecenderungan Anda mengalami emosi negatif '
            'seperti cemas, khawatir, atau mudah tertekan.';
    }
  }

  Color get color {
    switch (this) {
      case OceanTrait.openness:
        return const Color(0xFF6C5CE7);
      case OceanTrait.conscientiousness:
        return const Color(0xFF00B894);
      case OceanTrait.extraversion:
        return const Color(0xFFE17055);
      case OceanTrait.agreeableness:
        return const Color(0xFF0984E3);
      case OceanTrait.neuroticism:
        return const Color(0xFFD63031);
    }
  }

  IconData get icon {
    switch (this) {
      case OceanTrait.openness:
        return Icons.lightbulb_outline_rounded;
      case OceanTrait.conscientiousness:
        return Icons.task_alt_rounded;
      case OceanTrait.extraversion:
        return Icons.groups_rounded;
      case OceanTrait.agreeableness:
        return Icons.volunteer_activism_rounded;
      case OceanTrait.neuroticism:
        return Icons.sentiment_dissatisfied_rounded;
    }
  }
}
