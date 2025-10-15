import 'package:flutter/material.dart';

/// AppColors - Pallet warna Memphis Design
/// Memphis design terkenal dengan warna-warna bold, bright, dan kontras tinggi
/// Terinspirasi dari gerakan design tahun 1980an
class AppColors {
  // Private constructor untuk mencegah instantiasi
  // Class ini hanya berisi static constants
  AppColors._();

  // === PRIMARY COLORS - Warna utama Memphis ===
  
  /// Cyan terang - warna signature Memphis
  static const Color cyan = Color(0xFF00D9FF);
  
  /// Pink vibrant - memberikan energi dan playfulness
  static const Color pink = Color(0xFFFF006E);
  
  /// Yellow cerah - untuk aksen dan highlight
  static const Color yellow = Color(0xFFFFBE0B);
  
  /// Purple bold - menambah kedalaman visual
  static const Color purple = Color(0xFF8338EC);

  // === SECONDARY COLORS - Warna pendukung ===
  
  /// Orange energik - untuk variasi warm colors
  static const Color orange = Color(0xFFFF6B35);
  
  /// Green mint - memberikan kesegaran
  static const Color mint = Color(0xFF06FFA5);
  
  /// Red coral - untuk aksen dramatic
  static const Color coral = Color(0xFFFF5A5F);
  
  /// Blue electric - untuk kontras dengan warm colors
  static const Color electricBlue = Color(0xFF3A86FF);

  // === NEUTRAL COLORS - Untuk background dan teks ===
  
  /// Background terang - warna dasar aplikasi
  static const Color background = Color(0xFFFAFAFA);
  
  /// Background gelap untuk card/container
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  /// Dark gray untuk teks utama
  static const Color textPrimary = Color(0xFF2B2D42);
  
  /// Medium gray untuk teks secondary
  static const Color textSecondary = Color(0xFF8D99AE);

  // === GRADIENT COMBINATIONS - Kombinasi warna untuk effects ===
  
  /// Gradient cyan ke purple - untuk header/hero section
  static const LinearGradient cyanPurpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cyan, purple],
  );
  
  /// Gradient pink ke orange - untuk cards yang energik
  static const LinearGradient pinkOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [pink, orange],
  );
  
  /// Gradient yellow ke mint - untuk fresh looking elements
  static const LinearGradient yellowMintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [yellow, mint],
  );

  // === UTILITY FUNCTIONS ===
  
  /// Mendapatkan list semua warna accent untuk digunakan secara random
  /// Berguna untuk memberikan variasi warna pada grid items
  static List<Color> get accentColors => [
        cyan,
        pink,
        yellow,
        purple,
        orange,
        mint,
        coral,
        electricBlue,
      ];

  /// Mendapatkan warna random dari accent colors
  /// Menggunakan index untuk konsistensi (bukan random sebenarnya)
  /// Ini memastikan warna yang sama untuk item yang sama
  static Color getAccentColor(int index) {
    return accentColors[index % accentColors.length];
  }
}