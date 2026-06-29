import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryOlive = Color(0xFF4A6741);
  static const Color secondaryOlive = Color(0xFF6B8F5E);
  static const Color lightOlive = Color(0xFFB8C5AA);
  static const Color backgroundCream = Color(0xFFF5F3EE);
  static const Color textDark = Color(0xFF1E2D1F);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color cardWhite = Color(0xFFFFFFFF);

  // Streak colors
  static Color streakColor(int streak) {
    if (streak == 0) return const Color(0xFFBDBDBD);
    if (streak < 3) return const Color(0xFF81C784);
    if (streak < 7) return const Color(0xFF42A5F5);
    if (streak < 14) return const Color(0xFFAB47BC);
    if (streak < 30) return const Color(0xFFFF7043);
    return const Color(0xFFFFD700);
  }

  static String streakLabel(int streak) {
    if (streak == 0) return '';
    if (streak < 3) return '🌱';
    if (streak < 7) return '🔥';
    if (streak < 14) return '⚡';
    if (streak < 30) return '🚀';
    return '👑';
  }

  // Percentage colors
  static Color completionColor(double pct) {
    if (pct >= 80) return const Color(0xFF2E7D32);
    if (pct >= 60) return const Color(0xFF558B2F);
    if (pct >= 40) return const Color(0xFFF9A825);
    if (pct >= 20) return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  // Weight percentage colors (di atas 100% = buruk untuk weight loss)
  static Color weightPercentageColor(double pct) {
    if (pct <= 95) return const Color(0xFF2E7D32);   // bagus banget
    if (pct <= 100) return const Color(0xFF388E3C);   // on track
    if (pct <= 103) return const Color(0xFFF9A825);   // warning
    if (pct <= 107) return const Color(0xFFE65100);   // buruk
    return const Color(0xFFC62828);                    // merah terang
  }

  // Earning percentage colors
  static Color earningPercentageColor(double pct) {
    if (pct >= 100) return const Color(0xFF2E7D32);
    if (pct >= 75) return const Color(0xFF558B2F);
    if (pct >= 50) return const Color(0xFFF9A825);
    if (pct >= 25) return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryOlive,
        secondary: secondaryOlive,
        surface: backgroundCream,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textDark,
      ),
      scaffoldBackgroundColor: backgroundCream,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryOlive,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryOlive,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightOlive),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightOlive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOlive, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOlive,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primaryOlive),
      ),
      iconTheme: const IconThemeData(color: primaryOlive),
    );
  }
}
