import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary       = Color(0xFFE91E8C);
  static const Color primaryDark   = Color(0xFFC2185B);
  static const Color primaryLight  = Color(0xFFF06292);

  static const Color backgroundDark    = Color(0xFF0A0A0F);
  static const Color backgroundCard    = Color(0xFF13131F);
  static const Color backgroundSurface = Color(0xFF1C1C2E);
  static const Color backgroundChip   = Color(0xFF252538);

  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0CC);
  static const Color textMuted     = Color(0xFF6B6B8A);

  static const Color accentBlue    = Color(0xFF4FC3F7);
  static const Color accentPurple  = Color(0xFF9C27B0);
  static const Color divider       = Color(0xFF2A2A3E);

  static Color primaryGlow  = primary.withValues(alpha: 0.3);
  static Color shadowDark   = Colors.black.withValues(alpha: 0.5);
}