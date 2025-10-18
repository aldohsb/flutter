import 'package:flutter/material.dart';

class AppColors {
  // Zen Garden - Hijau Muda Zaitun
  static const Color primaryLight = Color(0xFFA8D5BA); // Hijau Muda
  static const Color primaryMain = Color(0xFF6FB899); // Hijau Sedang
  static const Color primaryDark = Color(0xFF4A9B7E); // Hijau Tua
  
  static const Color secondaryOlive = Color(0xFF556B2F); // Zaitun
  static const Color secondaryLight = Color(0xFF7A8F42); // Zaitun Terang
  
  static const Color accentCyan = Color(0xFF5DADE2); // Aksen Cyan
  static const Color accentGold = Color(0xFFD4AF37); // Aksen Gold (Bintang)
  
  static const Color white = Color(0xFFFFFBF5); // Off-white cream
  static const Color greyLight = Color(0xFFF5F1E8);
  static const Color greyMid = Color(0xFFD4CFC7);
  static const Color greyDark = Color(0xFF8B8680);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE74C3C);
  
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textMid = Color(0xFF5D6D7B);
  static const Color textLight = Color(0xFF95A5A6);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double circle = 50.0;
}

class AppFontSizes {
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double huge = 32.0;
}

class AppConstants {
  static const int totalLevels = 200;
  static const int questionsPerLevel = 10;
  static const int minCorrectToPass = 7; // Minimal 7 soal benar
  static const int starsThreshold1 = 8; // 8 benar = 1 bintang
  static const int starsThreshold2 = 9; // 9 benar = 2 bintang
  static const int starsThreshold3 = 10; // 10 benar = 3 bintang
  
  // Level ranges
  static const int hiraganaStart = 1;
  static const int hiraganaEnd = 40;
  static const int katakanaStart = 41;
  static const int katakanaEnd = 80;
  static const int kanjiStart = 81;
  static const int kanjiEnd = 200;
}