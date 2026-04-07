import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9E97FF);
  static const Color primaryDark = Color(0xFF4A42CC);

  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color backgroundMid = Color(0xFF1A1A2E);
  static const Color backgroundCard = Color(0xFF252540);
  static const Color backgroundSurface = Color(0xFF2D2D4E);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFBBBBCC);
  static const Color textMuted = Color(0xFF7777AA);

  static const Color accentTeal = Color(0xFF00D4AA);
  static const Color accentAmber = Color(0xFFFFB347);

  static const Color divider = Color(0xFF3A3A5C);
  static const Color border = Color(0xFF4A4A6A);

  static Color primaryGlow = primary.withValues(alpha: 0.25);
  static Color shadowColor = Colors.black.withValues(alpha: 0.3);
}