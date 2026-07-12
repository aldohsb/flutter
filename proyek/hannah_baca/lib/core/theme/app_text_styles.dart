import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

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

  // Diperbesar dari 42 -> 64 agar lebih jelas dibaca anak TK
  static TextStyle get syllable => GoogleFonts.fredoka(
        fontSize: 90,
        fontWeight: FontWeight.w600,
        height: 1.15,
      );
}