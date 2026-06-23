// ============================================================
// lib/theme/app_theme.dart
// Konfigurasi tema Flutter Material 3 untuk Moodly
//
// KONSEP: ThemeData
// Flutter punya sistem tema terpusat. Dengan mendefinisikan
// ThemeData sekali di sini, semua widget bawaan Flutter
// (AppBar, TextField, BottomNav, dll) otomatis mengikuti
// gaya yang kita tentukan, tanpa perlu styling manual.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';   // Untuk SystemUiOverlayStyle
import 'app_colors.dart';
import 'app_text_styles.dart';

// abstract class sebagai namespace untuk fungsi factory tema
abstract class AppTheme {

  // lightTheme() mengembalikan konfigurasi tema lengkap
  // Dipanggil sekali di MaterialApp pada main.dart
  static ThemeData get lightTheme {
    return ThemeData(
      // ======================================================
      // MATERIAL 3 – Aktifkan sistem desain Material terbaru
      // ======================================================
      useMaterial3: true,

      // ======================================================
      // COLOR SCHEME – Palet warna sistem Material 3
      // ColorScheme.fromSeed() otomatis menghasilkan 30+ warna
      // turunan dari 1 warna "seed"
      // ======================================================
      colorScheme: ColorScheme.fromSeed(
        // Warna benih = pink pastel utama kita
        seedColor: AppColors.pink,
        // brightness.light = tema terang
        brightness: Brightness.light,
        // Override beberapa warna penting secara manual:
        primary: AppColors.pink,
        onPrimary: AppColors.textOnClay,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceSecondary,
      ),

      // ======================================================
      // SCAFFOLD – Warna latar halaman utama
      // ======================================================
      scaffoldBackgroundColor: AppColors.background,

      // ======================================================
      // TYPOGRAPHY – Gaya teks global
      // TextTheme mengatur gaya untuk semua level teks Material
      // ======================================================
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ======================================================
      // APP BAR – Gaya bar navigasi atas
      // ======================================================
      appBarTheme: AppBarTheme(
        // Latar AppBar transparan (warna halaman yang terlihat)
        backgroundColor: Colors.transparent,
        // elevation: 0 = tidak ada garis bayangan di bawah AppBar
        elevation: 0,
        // scrolledUnderElevation: 0 = tidak berubah saat scroll
        scrolledUnderElevation: 0,
        // centerTitle: judul di tengah
        centerTitle: true,
        // titleTextStyle – gaya teks judul AppBar
        titleTextStyle: AppTextStyles.headlineMedium,
        // iconTheme – gaya ikon di AppBar (tombol back, menu, dll)
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
        ),
        // systemOverlayStyle – mengatur warna status bar OS
        // (jam, baterai, sinyal di bagian atas layar)
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar transparan (menyatu dengan AppBar)
          statusBarColor: Colors.transparent,
          // Ikon status bar berwarna gelap (karena latar terang)
          statusBarIconBrightness: Brightness.dark,
          // Untuk iOS
          statusBarBrightness: Brightness.light,
        ),
      ),

      // ======================================================
      // BOTTOM NAVIGATION BAR – Navigasi bawah layar
      // ======================================================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        // Latar nav bar – putih bersih
        backgroundColor: AppColors.surface,
        // Warna ikon & label yang TERPILIH
        selectedItemColor: AppColors.textPrimary,
        // Warna ikon & label yang TIDAK terpilih
        unselectedItemColor: AppColors.textHint,
        // Selalu tampilkan label (tidak hilang saat tidak dipilih)
        showUnselectedLabels: true,
        // Ukuran font label nav
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
        // elevation – bayangan di atas nav bar
        elevation: 0,
        // type.fixed – semua item punya lebar yang sama
        type: BottomNavigationBarType.fixed,
      ),

      // ======================================================
      // INPUT DECORATION – Gaya field input teks
      // ======================================================
      inputDecorationTheme: InputDecorationTheme(
        // filled: true = field punya warna latar
        filled: true,
        // fillColor = warna latar field
        fillColor: AppColors.surfaceSecondary,
        // Gaya border saat tidak fokus
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        // Gaya border saat fokus (user sedang mengetik)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.pink,
            width: 2,
          ),
        ),
        // Border saat error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B6B),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFFF6B6B),
            width: 2,
          ),
        ),
        // contentPadding = jarak konten dari tepi field
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        // Gaya teks hint (placeholder)
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textHint,
        ),
        // Gaya teks label (mengambang di atas field saat fokus)
        labelStyle: AppTextStyles.bodyMedium,
        // Gaya teks saat error
        errorStyle: AppTextStyles.bodySmall.copyWith(
          color: const Color(0xFFFF6B6B),
        ),
      ),

      // ======================================================
      // ELEVATED BUTTON – Gaya tombol dengan elevation
      // (Kita punya ClayButton custom, tapi ini fallback)
      // ======================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pink,
          foregroundColor: AppColors.textOnClay,
          // Padding dalam tombol
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 14,
          ),
          // Sudut melengkung tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // elevation = ketinggian bayangan
          elevation: 0,
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ======================================================
      // CARD – Gaya widget Card bawaan Flutter
      // ======================================================
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      // ======================================================
      // DIVIDER – Garis pemisah
      // ======================================================
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),
    );
  }
}