import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Arabian Garden Color Palette - Olive Green Theme
  static const Color primaryGreen = Color(0xFF6B8E23); // Olive Green
  static const Color lightGreen = Color(0xFF9ACD32); // Yellow Green
  static const Color paleGreen = Color(0xFFE8F5E9); // Very light green
  static const Color darkGreen = Color(0xFF556B2F); // Dark Olive
  static const Color accentGold = Color(0xFFD4AF37); // Arabic Gold
  static const Color sandBeige = Color(0xFFF5F5DC); // Beige
  static const Color terracotta = Color(0xFFD2691E); // Terracotta
  
  // Status Colors
  static const Color correctGreen = Color(0xFF4CAF50);
  static const Color wrongRed = Color(0xFFE53935);
  static const Color starGold = Color(0xFFFFD700);
  
  // Text Colors
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textLight = Color(0xFF757575);
  static const Color textWhite = Color(0xFFFFFFFF);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: paleGreen,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: accentGold,
        surface: Colors.white,
        error: wrongRed,
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryGreen,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textWhite,
        ),
        iconTheme: const IconThemeData(color: textWhite),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: textWhite,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightGreen, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        labelStyle: GoogleFonts.cairo(
          color: textDark,
          fontSize: 16,
        ),
        hintStyle: GoogleFonts.cairo(
          color: textLight,
          fontSize: 14,
        ),
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cairo(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displayMedium: GoogleFonts.cairo(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displaySmall: GoogleFonts.cairo(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        headlineMedium: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleLarge: GoogleFonts.amiri( // Arabic font for Arabic text
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          color: textDark,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          color: textDark,
        ),
        labelLarge: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textWhite,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryGreen,
        size: 24,
      ),
    );
  }

  // Custom Text Styles
  static TextStyle get arabicTextStyle => GoogleFonts.amiri(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: textDark,
    height: 1.5,
  );

  static TextStyle get transliterationStyle => GoogleFonts.cairo(
    fontSize: 18,
    fontStyle: FontStyle.italic,
    color: textLight,
  );

  static TextStyle get levelNumberStyle => GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textWhite,
  );

  // Custom Gradients
  static LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryGreen,
      darkGreen,
    ],
  );

  static LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      paleGreen.withOpacity(0.3),
    ],
  );

  static LinearGradient get goldGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      accentGold,
      Color(0xFFB8860B),
    ],
  );

  // Box Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primaryGreen.withOpacity(0.2),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  // Decorations
  static BoxDecoration gardenDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        paleGreen,
        Colors.white,
      ],
    ),
  );

  static BoxDecoration arabianCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: accentGold.withOpacity(0.3),
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: primaryGreen.withOpacity(0.1),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );

  // Animations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
}