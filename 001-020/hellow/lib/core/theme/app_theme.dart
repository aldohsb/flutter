// lib/core/theme/app_theme.dart
// ─────────────────────────────────────────────────────────
// Satu ThemeData untuk seluruh aplikasi.
// Dipasang di MaterialApp → semua widget otomatis mengikutinya.
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    // Material3 adalah design system terbaru Flutter (wajib sejak Flutter 3.16)

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.coral,
      // seedColor: Flutter akan generate palet warna harmonis dari warna ini
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: AppColors.background,
    // Warna background default semua Scaffold

    textTheme: GoogleFonts.poppinsTextTheme(),
    // Menjadikan Poppins sebagai font default seluruh aplikasi

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teal,
        // Warna tombol elevated: teal
        foregroundColor: AppColors.textOnDark,
        // Warna teks/ikon di dalam tombol
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        // Padding dalam tombol agar terlihat proporsional
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          // Radius 50 = tombol berbentuk pill (sangat rounded)
        ),
        elevation: 0,
        // Flat design: tidak ada shadow
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      // Background input berwarna surface (abu sangat terang)
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
        // Tanpa border garis, hanya fill
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.teal, width: 2),
        // Border teal muncul saat input difokus
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
    ),
  );
}