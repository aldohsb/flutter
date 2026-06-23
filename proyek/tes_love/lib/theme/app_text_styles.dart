import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Sistem tipografi tes_love
/// Display: Playfair Display (karakteristik, elegan, emosional)
/// Body: DM Sans (modern, bersih, mudah dibaca)
abstract final class AppTextStyles {
  // ── Display / Heading ─────────────────────────────────────
  static TextStyle get display => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get headingLarge => GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingMedium => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // ── Body ──────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        height: 1.5,
      );

  // ── Label / Button ────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.surface,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMedium => GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        letterSpacing: 0.5,
      );

  // ── Quiz question ─────────────────────────────────────────
  static TextStyle get question => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.5,
        fontStyle: FontStyle.italic,
      );

  // ── Number / Data ─────────────────────────────────────────
  static TextStyle get numberLarge => GoogleFonts.dmSans(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.0,
      );

  static TextStyle get numberMedium => GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.1,
      );
}