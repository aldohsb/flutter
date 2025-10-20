// File: lib/utils/theme_utils.dart
// Penjelasan: File ini berisi semua pengaturan visual (warna, font, dll)
// Dengan centralisasi theme di sini, kita bisa mengubah desain di satu tempat

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Class AppTheme berisi semua konfigurasi visual aplikasi
/// Menggunakan "static" berarti semua variable bisa diakses tanpa perlu membuat object
class AppTheme {
  // ===== WARNA =====
  // Inspirasi dari minimalism Jepang: putih, hitam, abu-abu, dan aksen warna netral

  /// Warna background utama (putih susu/off-white)
  static const Color backgroundColor = Color(0xFFFAF8F3);

  /// Warna teks utama (hitam gelap)
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// Warna teks sekunder (abu-abu medium)
  static const Color textSecondary = Color(0xFF6B6B6B);

  /// Warna aksen (aksen brush stroke yang terinspirasi dari sumi-e Jepang)
  /// Warna biru-gelap untuk aksen artistik
  static const Color accentColor = Color(0xFF1D3B5E);

  /// Warna divider (garis pemisah yang subtle)
  static const Color dividerColor = Color(0xFFD9D4CC);

  /// Warna untuk efek ink bleed (tinta yang menyebar)
  static const Color inkBleedColor = Color(0xFF8B8B8B);

  // ===== TYPOGRAPHY (UKURAN FONT) =====

  /// Ukuran font untuk judul heading besar
  static const double fontSizeHeading = 28.0;

  /// Ukuran font untuk body text (teks utama)
  static const double fontSizeBody = 16.0;

  /// Ukuran font untuk caption/keterangan kecil
  static const double fontSizeCaption = 12.0;

  // ===== SPACING (JARAK) =====
  // Spacing yang konsisten membuat desain terlihat lebih rapi

  /// Jarak standar kecil
  static const double spacingSmall = 8.0;

  /// Jarak standar sedang
  static const double spacingMedium = 16.0;

  /// Jarak standar besar
  static const double spacingLarge = 24.0;

  /// Jarak untuk padding kartu
  static const double cardPadding = 20.0;

  // ===== BORDER RADIUS (SUDUT ROUNDED) =====

  /// Border radius untuk elemen yang subtle
  static const double borderRadiusSmall = 4.0;

  /// Border radius untuk kartu
  static const double borderRadiusMedium = 12.0;

  // ===== SHADOW & ELEVATION =====

  /// Boxshadow untuk kartu agar terlihat "floating"
  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromARGB(25, 0, 0, 0), // Warna hitam dengan transparansi
    blurRadius: 8.0,                     // Blur radius shadow
    offset: Offset(0, 2),                // Posisi shadow (x, y)
  );

  // ===== TEXTURE/PATTERN =====

  /// Opacity untuk efek transparansi yang subtle
  static const double subtleOpacity = 0.15;

  /// Opacity untuk divider line
  static const double dividerOpacity = 0.3;

  // ===== METHOD: BUILD THEME DATA =====
  /// Method ini membuat ThemeData untuk Material Design
  /// ThemeData adalah konfigurasi tema global Flutter
  static ThemeData buildTheme() {
    return ThemeData(
      // Gunakan Material 3 design system
      useMaterial3: true,

      // Warna utama aplikasi
      primaryColor: accentColor,

      // Warna untuk background
      scaffoldBackgroundColor: backgroundColor,

      // Konfigurasi AppBarTheme (style untuk AppBar)
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0, // Tidak ada shadow di AppBar
        centerTitle: true, // Judul di tengah
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: fontSizeHeading,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      // Konfigurasi text theme
      textTheme: TextTheme(
        // Heading besar
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: fontSizeHeading,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        // Body text besar
        bodyLarge: GoogleFonts.notoSerif(
          fontSize: fontSizeBody,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.6, // Line height untuk readability
        ),

        // Body text sedang
        bodyMedium: GoogleFonts.notoSerif(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
        ),

        // Caption kecil
        labelSmall: GoogleFonts.roboto(
          fontSize: fontSizeCaption,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ===== METHOD: GRADIENT UNTUK INK BLEED EFFECT =====
  /// Method untuk membuat gradient yang simulasi efek tinta menyebar
  /// Gradient ini akan digunakan di custom painter
  static LinearGradient getInkBleedGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        inkBleedColor.withOpacity(0.3),  // Warna atas (lebih transparan)
        inkBleedColor.withOpacity(0.1),  // Warna bawah (sangat transparan)
      ],
    );
  }
}