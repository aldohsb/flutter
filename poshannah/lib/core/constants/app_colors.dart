import 'package:flutter/material.dart';

/// Color palette untuk POSHannah - Minimalis Modern Theme
class AppColors {
  AppColors._();
  
  // Primary Colors - Green tone untuk fresh juice vibe
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryLight = Color(0xFF40916C);
  static const Color primaryDark = Color(0xFF1B4332);
  
  // Accent Colors
  static const Color accent = Color(0xFF52B788);
  static const Color accentLight = Color(0xFF74C69D);
  
  // Neutral Colors - Clean & Minimal
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F5);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textTertiary = Color(0xFFADB5BD);
  
  // Semantic Colors
  static const Color success = Color(0xFF52B788);
  static const Color warning = Color(0xFFFFA94D);
  static const Color error = Color(0xFFE63946);
  static const Color info = Color(0xFF4EA8DE);
  
  // Border & Divider
  static const Color border = Color(0xFFDEE2E6);
  static const Color divider = Color(0xFFE9ECEF);
  
  // Shadow
  static Color shadow = Colors.black.withOpacity(0.08);
  
  // Card Gradient (opsional untuk highlight)
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2D6A4F),
      Color(0xFF52B788),
    ],
  );
}