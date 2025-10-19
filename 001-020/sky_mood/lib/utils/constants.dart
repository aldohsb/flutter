// ============================================================================
// FILE: lib/utils/constants.dart
// FUNGSI: Menyimpan semua nilai konstanta global (warna, ukuran, dll)
// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// WARNA - CLAYMORPHISM PALETTE (Palet warna design claymorphism)
// ============================================================================
// Claymorphism menggunakan warna pastel lembut untuk efek 3D yang soft

class AppColors {
  // Warna latar belakang utama - biru muda lembut seperti langit cerah
  static const Color bgLight = Color(0xFFE8F4F8);

  // Warna elemen utama - biru lebih terang untuk kontras
  static const Color primaryLight = Color(0xFFB4E7FF);

  // Warna highlight/accent - putih dengan sedikit biru
  static const Color highlight = Color(0xFFFFFFFF);

  // Warna shadow untuk efek 3D - abu-abu lembut
  static const Color shadowColor = Color(0xFF000000);

  // Warna teks utama - biru tua untuk readability
  static const Color textDark = Color(0xFF2C3E50);

  // Warna teks secondary - abu-abu untuk keterangan
  static const Color textGray = Color(0xFF7F8C8D);

  // Warna cuaca cerah - kuning emas lembut
  static const Color sunny = Color(0xFFFFD56F);

  // Warna cuaca berawan - abu-abu lembut
  static const Color cloudy = Color(0xFFD0D8E0);

  // Warna cuaca hujan - biru gelap
  static const Color rainy = Color(0xFF6C8EBF);
}

// ============================================================================
// UKURAN - TYPOGRAPHY & SPACING
// ============================================================================

class AppSizes {
  // Padding dan margin standar
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Ukuran border radius untuk claymorphism
  static const double radiusSmall = 12.0;
  static const double radiusMedium = 20.0;
  static const double radiusLarge = 28.0;
  static const double radiusXLarge = 40.0;

  // Ukuran teks
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 28.0;
  static const double fontSizeXXLarge = 36.0;

  // Ukuran widget
  static const double cardWidth = 280.0;
  static const double cardHeight = 360.0;
  static const double iconSize = 48.0;
}

// ============================================================================
// ANIMASI
// ============================================================================

class AppAnimations {
  // Durasi animasi utama dalam milliseconds (1000 ms = 1 detik)
  static const int animationDuration = 1500;

  // Durasi animasi partikel
  static const int particleAnimationDuration = 3000;

  // Kurva animasi (easing) - membuat gerak terasa natural
  static const Curve defaultCurve = Curves.easeInOut;

  // Kurva untuk partikel - smooth dan natural
  static const Curve particleCurve = Curves.linear;
}

// ============================================================================
// PARTICLE SETTINGS (Pengaturan partikel animasi)
// ============================================================================

class ParticleSettings {
  // Jumlah partikel yang akan dihasilkan
  static const int particleCount = 30;

  // Ukuran partikel minimal dan maksimal
  static const double minParticleSize = 2.0;
  static const double maxParticleSize = 6.0;

  // Kecepatan partikel (opacity change per frame)
  static const double particleSpeed = 0.02;

  // Alpha (transparansi) awal partikel
  static const double particleInitialAlpha = 0.6;
}