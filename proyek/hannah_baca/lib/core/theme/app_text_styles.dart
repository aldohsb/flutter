import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const double baseSyllableFontSize = 64;
  static const double baseHijaiyahFontSize = 96;

  static TextStyle get title => GoogleFonts.fredoka(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get heading => GoogleFonts.fredoka(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get body => GoogleFonts.nunito(
        fontSize: 16,
        color: AppColors.textDark,
      );

  static TextStyle syllableScaled(double scale) => GoogleFonts.fredoka(
        fontSize: baseSyllableFontSize * scale,
        fontWeight: FontWeight.w600,
        height: 1.15,
      );

  static TextStyle hijaiyahScaled(double scale) => GoogleFonts.notoNaskhArabic(
        fontSize: baseHijaiyahFontSize * scale,
        fontWeight: FontWeight.w600,
      );
}