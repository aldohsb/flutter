import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Kumpulan konfigurasi tema visual aplikasi Usama Quiz.
///
/// Font UI umum memakai Quicksand (rounded, tenang, mudah dibaca), sementara
/// aksara Jepang selalu dirender memakai Noto Sans JP lewat [jpTextStyle]
/// agar semua glyph hiragana/katakana/kanji ter-render dengan benar di
/// semua platform (web, Android, Windows).
abstract final class AppTheme {
  static ThemeData get light {
    final base = ColorScheme.fromSeed(
      seedColor: AppColors.sage,
      brightness: Brightness.light,
      primary: AppColors.sage,
      onPrimary: Colors.white,
      secondary: AppColors.clay,
      onSecondary: Colors.white,
      surface: AppColors.sandSurface,
      onSurface: AppColors.ink,
      error: AppColors.error,
      onError: Colors.white,
    );

    final textTheme = GoogleFonts.quicksandTextTheme().apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: base,
      scaffoldBackgroundColor: AppColors.sandBackground,
      textTheme: textTheme,
      fontFamily: GoogleFonts.quicksand().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.sandBackground,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.quicksand(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.sandSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AppColors.stone.withValues(alpha: 0.6)),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sage,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.sageDark,
          side: BorderSide(color: AppColors.sage.withValues(alpha: 0.6)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.sage,
        linearTrackColor: AppColors.stone,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.stone.withValues(alpha: 0.7),
        thickness: 1,
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }

  /// Gaya teks khusus untuk merender aksara Jepang (Hiragana/Katakana/Kanji)
  /// agar glyph selalu tampil benar di web, Android, maupun Windows.
  static TextStyle jpTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeight.w600,
    Color color = AppColors.ink,
  }) {
    return GoogleFonts.notoSansJp(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
