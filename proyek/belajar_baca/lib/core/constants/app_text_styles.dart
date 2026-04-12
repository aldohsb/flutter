import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle syllableMain(Color color) => GoogleFonts.baloo2(
        fontSize: 130,
        fontWeight: FontWeight.w800,
        color: color,
        height: 1.0,
        shadows: [
          Shadow(
            color: Colors.black.withAlpha(60),
            offset: const Offset(3, 4),
            blurRadius: 0,
          ),
        ],
      );

  static TextStyle syllableSmall(Color color) => GoogleFonts.baloo2(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.1,
        shadows: [
          Shadow(
            color: Colors.black.withAlpha(60),
            offset: const Offset(2, 3),
            blurRadius: 0,
          ),
        ],
      );

  static TextStyle cardCounter(Color color) => GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle chapterTitle = GoogleFonts.baloo2(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF2D2D2D),
  );

  static TextStyle chapterSubtitle = GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF888888),
  );

  static TextStyle homeTitle = GoogleFonts.baloo2(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: const Color(0xFF2D2D2D),
  );

  static TextStyle homeSubtitle = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF888888),
  );

  static TextStyle chapterLabel(Color color) => GoogleFonts.baloo2(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: color,
      );
}
