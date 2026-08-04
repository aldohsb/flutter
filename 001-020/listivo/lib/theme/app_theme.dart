// lib/theme/app_theme.dart
// Konfigurasi ThemeData terpusat agar seluruh layar punya tampilan yang konsisten

import 'package:flutter/material.dart'; // sumber ThemeData, ColorScheme, dsb
import 'app_colors.dart'; // memakai palet warna kustom yang sudah dibuat
import '../constants/app_constants.dart'; // memakai konstanta radius & padding

class AppTheme {
  // Method statis agar bisa dipanggil tanpa perlu membuat instance AppTheme
  static ThemeData light() {
    // Membangun ColorScheme Material 3 lengkap hanya dari satu warna seed
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      // useMaterial3 mengaktifkan sistem desain terbaru Flutter (default sejak 3.16+)
      useMaterial3: true,

      // Menerapkan colorScheme yang sudah diturunkan dari seed color
      colorScheme: colorScheme,

      // Latar scaffold dibuat off-white agar card putih di atasnya lebih menonjol
      scaffoldBackgroundColor: const Color(0xFFF7F7FB),

      // AppBar transparan tanpa bayangan memberi kesan flat & modern
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: Color(0xFF1B1B2F),
      ),

      // CardThemeData (bukan CardTheme lama) sesuai normalisasi tema Flutter terbaru
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
      ),

      // FloatingActionButton dibuat pil (stadium) agar terasa lebih premium
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
      ),

      // Style default untuk TextField pada bottom sheet tambah tugas
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0F1F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          borderSide: BorderSide.none, // tanpa garis tepi agar tampilan flat
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),

      // Penyesuaian ketebalan font pada beberapa level teks yang sering dipakai
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}