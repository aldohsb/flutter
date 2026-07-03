import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Palette ──────────────────────────────────────────────
  static const Color sage100 = Color(0xFFF0F4EF);
  static const Color sage200 = Color(0xFFD6E4D3);
  static const Color sage300 = Color(0xFFB5CEB0);
  static const Color sage400 = Color(0xFF8FB589);
  static const Color sage500 = Color(0xFF6A9A63);
  static const Color sage600 = Color(0xFF4E7A47);
  static const Color sage700 = Color(0xFF375C31);
  static const Color sage800 = Color(0xFF243D1F);

  static const Color stone100 = Color(0xFFF7F6F3);
  static const Color stone200 = Color(0xFFEAE8E2);
  static const Color stone300 = Color(0xFFD4D0C7);
  static const Color stone500 = Color(0xFF8B8678);
  static const Color stone700 = Color(0xFF4A4740);

  static const Color errorRed = Color(0xFFD64E4E);
  static const Color warningAmber = Color(0xFFD4882A);
  static const Color successGreen = Color(0xFF4E9A47);
  static const Color accentGold = Color(0xFFC9A84C);

  // ── Streak color tiers ───────────────────────────────────
  static Color streakColor(int streak) {
    if (streak == 0) return stone300;
    if (streak < 3) return const Color(0xFF8FB589);
    if (streak < 7) return const Color(0xFF6A9A63);
    if (streak < 14) return const Color(0xFF4E7A47);
    if (streak < 30) return const Color(0xFF375C31);
    return const Color(0xFFC9A84C); // gold for 30+
  }

  // ── Completion color tiers ───────────────────────────────
  static Color completionColor(double pct) {
    if (pct >= 90) return successGreen;
    if (pct >= 70) return sage500;
    if (pct >= 50) return warningAmber;
    return errorRed;
  }

  // ── Weight deviation color ───────────────────────────────
  static Color weightDeviationColor(double deviationPct) {
    // deviationPct = (actual - target) / target * 100
    // positive = above target (bad for weight loss), negative = below (good)
    if (deviationPct <= -2) return successGreen;
    if (deviationPct <= 0) return sage500;
    if (deviationPct <= 2) return warningAmber;
    return errorRed;
  }

  // ── Theme ────────────────────────────────────────────────
  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: sage600,
        onPrimary: Colors.white,
        primaryContainer: sage200,
        onPrimaryContainer: sage800,
        secondary: accentGold,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFF5E9C8),
        onSecondaryContainer: Color(0xFF4A3800),
        tertiary: sage400,
        onTertiary: Colors.white,
        tertiaryContainer: sage100,
        onTertiaryContainer: sage800,
        error: errorRed,
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: stone100,
        onSurface: stone700,
        surfaceContainerHighest: stone200,
        outline: stone300,
        outlineVariant: sage200,
      ),
      scaffoldBackgroundColor: sage100,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: sage200, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: sage100,
        foregroundColor: sage800,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: sage800,
        ),
      ),
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: sage800,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: sage700,
        ),
        titleLarge: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: sage800,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: sage700,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: stone700,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: stone500,
        ),
        labelSmall: GoogleFonts.dmMono(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: stone500,
          letterSpacing: 0.5,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: sage200,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: sage200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: sage200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: sage500, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: sage600,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: sage600,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return sage600;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: sage400, width: 1.5),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: sage800,
        contentTextStyle: GoogleFonts.dmSans(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
    return base;
  }
}
