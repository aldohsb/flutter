// ============================================================================
// FILE: lib/utils/theme.dart
// FUNGSI: Konfigurasi tema global aplikasi dengan Claymorphism design
// ============================================================================

import 'package:flutter/material.dart';
import 'constants.dart';

// ============================================================================
// CLAYMORPHISM THEME
// ============================================================================
// Claymorphism adalah gaya desain yang membuat UI terlihat seperti tanah liat
// lunak 3D dengan shadow lembut. Ciri-cirinya:
// 1. Border radius besar (membulat)
// 2. Shadow lembut (tidak tajam)
// 3. Warna pastel (soft, tidak vibrant)
// 4. Depth dan dimensi (kedalaman)

class AppTheme {
  // Membuat ThemeData untuk Material Design
  static ThemeData get lightTheme {
    return ThemeData(
      // Warna brand utama - biru muda
      primaryColor: AppColors.primaryLight,

      // Definisi color scheme (palet warna aplikasi)
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.sunny,
        surface: AppColors.bgLight,
        onSurface: AppColors.textDark,
      ),

      // Warna latar belakang scaffold
      scaffoldBackgroundColor: AppColors.bgLight,

      // Konfigurasi teks default
      textTheme: TextTheme(
        // Heading besar (untuk judul utama)
        displayLarge: TextStyle(
          fontSize: AppSizes.fontSizeXXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
          letterSpacing: -0.5,
        ),

        // Heading sedang
        headlineMedium: TextStyle(
          fontSize: AppSizes.fontSizeXLarge,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),

        // Teks body utama
        bodyLarge: TextStyle(
          fontSize: AppSizes.fontSizeMedium,
          color: AppColors.textDark,
          height: 1.5,
        ),

        // Teks body secondary
        bodySmall: TextStyle(
          fontSize: AppSizes.fontSizeSmall,
          color: AppColors.textGray,
        ),
      ),

      // Konfigurasi app bar
      appBarTheme: AppBarTheme(
        // Warna background app bar - transparan agar blend dengan bg
        backgroundColor: AppColors.bgLight,
        // Hapus shadow default
        elevation: 0,
        // Warna teks/icon - biru tua
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(
          fontSize: AppSizes.fontSizeXLarge,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),

      // Konfigurasi floating action button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        // Warna FAB - kuning lembut
        backgroundColor: AppColors.sunny,
        // Foreground color - ikon
        foregroundColor: AppColors.textDark,
        // Elevation - shadow 3D
        elevation: 8,
      ),

      // Konfigurasi card
      cardTheme: CardThemeData(
        // Warna background card
        color: AppColors.primaryLight,
        // Shadow lembut untuk claymorphism
        elevation: 4,
        // Padding/margin card
        margin: EdgeInsets.zero,
        // Border radius membulat (claymorphism)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
      ),

      // Useless properties yang dihapus untuk cleaner code
      useMaterial3: true,
    );
  }
}

// ============================================================================
// BOX SHADOW UTILITY - Untuk shadow claymorphism
// ============================================================================
// Shadow adalah elemen penting dalam claymorphism. Kita buat preset shadow
// yang bisa digunakan berkali-kali

class AppShadows {
  // Shadow lembut kecil - untuk elemen yang sedang
  static List<BoxShadow> softShadowSmall() {
    return [
      BoxShadow(
        // Warna shadow - abu-abu transparan
        color: AppColors.shadowColor.withOpacity(0.08),
        // Blur radius - seberapa blur shadow (lebih besar = lebih soft)
        blurRadius: 8,
        // Offset - posisi shadow ke arah x, y
        offset: Offset(0, 4),
        // Spread radius - seberapa luas shadow menyebar
        spreadRadius: 0,
      ),
    ];
  }

  // Shadow medium - untuk kartu utama
  static List<BoxShadow> softShadowMedium() {
    return [
      BoxShadow(
        color: AppColors.shadowColor.withOpacity(0.12),
        blurRadius: 16,
        offset: Offset(0, 8),
        spreadRadius: 0,
      ),
      // Shadow kedua - untuk efek depth lebih
      BoxShadow(
        color: AppColors.shadowColor.withOpacity(0.04),
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: 0,
      ),
    ];
  }

  // Shadow besar - untuk hover/elevated effect
  static List<BoxShadow> softShadowLarge() {
    return [
      BoxShadow(
        color: AppColors.shadowColor.withOpacity(0.16),
        blurRadius: 24,
        offset: Offset(0, 12),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.shadowColor.withOpacity(0.08),
        blurRadius: 8,
        offset: Offset(0, 4),
        spreadRadius: 0,
      ),
    ];
  }

  // Inner shadow - untuk efek inset (masuk ke dalam)
  static List<BoxShadow> innerShadow() {
    return [
      BoxShadow(
        color: AppColors.shadowColor.withOpacity(0.06),
        blurRadius: 12,
        offset: Offset(4, 4),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.highlight.withOpacity(0.4),
        blurRadius: 12,
        offset: Offset(-4, -4),
        spreadRadius: 0,
      ),
    ];
  }
}