import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppTheme - Konfigurasi tema aplikasi dengan Brutalist Design
/// 
/// Class ini mengatur seluruh visual styling aplikasi termasuk:
/// - Typography dengan font tebal untuk hierarchy yang jelas
/// - Color scheme hitam-putih dengan kontras tinggi
/// - Border dan shape dengan sudut tegas (no rounded corners)
class AppTheme {
  // Private constructor
  AppTheme._();

  /// Mendapatkan ThemeData untuk aplikasi
  /// ThemeData adalah konfigurasi global theme Flutter
  static ThemeData get theme {
    return ThemeData(
      // Menggunakan Material 3 design system
      useMaterial3: true,

      // Color scheme dengan palet hitam-putih
      colorScheme: const ColorScheme.light(
        primary: AppColors.black, // Warna primary untuk button, accent, dll
        onPrimary: AppColors.white, // Warna text di atas primary color
        surface: AppColors.white, // Warna background card/surface
        onSurface: AppColors.black, // Warna text di atas surface
      ),

      // Scaffold background - base background untuk seluruh screen
      scaffoldBackgroundColor: AppColors.white,

      // Text theme - Brutalist menggunakan font tebal dan ukuran besar
      textTheme: const TextTheme(
        // Display large - untuk angka counter utama
        // fontWeight.w900 (Black) adalah paling tebal
        displayLarge: TextStyle(
          fontSize: 120, // Ukuran sangat besar untuk emphasis
          fontWeight: FontWeight.w900, // Black weight untuk impact maksimal
          color: AppColors.black, // Kontras dengan background putih
          height: 1.0, // Line height dikurangi untuk compactness
        ),

        // Headline large - untuk title/heading
        headlineLarge: TextStyle(
          fontSize: 32, // Ukuran besar untuk hierarchy
          fontWeight: FontWeight.w800, // Extra bold
          color: AppColors.black,
          letterSpacing: -0.5, // Negative letter spacing untuk tight spacing
        ),

        // Body large - untuk body text
        bodyLarge: TextStyle(
          fontSize: 18, // Ukuran readable
          fontWeight: FontWeight.w700, // Bold untuk consistency
          color: AppColors.black,
          height: 1.4, // Line height untuk readability
        ),

        // Label large - untuk button text
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800, // Extra bold untuk button
          color: AppColors.white,
          letterSpacing: 0.5, // Positive spacing untuk button text
        ),
      ),

      // FloatingActionButton theme - customization untuk FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.black, // Background hitam
        foregroundColor: AppColors.white, // Icon putih
        elevation: 0, // No shadow untuk flat design
        
        // Shape dengan sudut tajam (bukan rounded)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sudut 90 derajat
          side: BorderSide(
            color: AppColors.black, // Border hitam
            width: 3, // Border tebal untuk emphasis
          ),
        ),
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white, // Background putih
        foregroundColor: AppColors.black, // Text/icon hitam
        elevation: 0, // No shadow
        centerTitle: true, // Title di tengah
        
        // Title text style
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900, // Black weight
          color: AppColors.black,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  /// Text style khusus untuk counter display dengan effect
  /// Digunakan untuk angka counter dengan animasi heartbeat
  static const TextStyle counterTextStyle = TextStyle(
    fontSize: 120,
    fontWeight: FontWeight.w900, // Weight maksimal
    color: AppColors.black,
    height: 1.0,
    letterSpacing: -2, // Tight spacing untuk impact
  );
}