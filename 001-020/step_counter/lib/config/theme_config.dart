import 'package:flutter/material.dart';

class ThemeConfig {
  // Neumorphic Color Palette (Light Purple/Blue Gradient)
  static const Color backgroundColor = Color(0xFFE8EAF6);
  static const Color surfaceColor = Color(0xFFE8EAF6);
  static const Color primaryColor = Color(0xFF7E57C2);
  static const Color secondaryColor = Color(0xFF5C6BC0);
  static const Color accentColor = Color(0xFFAB47BC);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF37474F);
  static const Color textSecondary = Color(0xFF78909C);
  static const Color textLight = Color(0xFFB0BEC5);
  
  // Neumorphic Shadow Colors
  static const Color shadowLight = Color(0xFFFFFFFF);
  static const Color shadowDark = Color(0xFFBEC3D6);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF9575CD), Color(0xFF7E57C2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF7986CB), Color(0xFF5C6BC0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
        ),
      ),
    );
  }
}