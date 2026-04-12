import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background gradients per chapter group
  static const List<List<Color>> chapterGradients = [
    // Vokal A
    [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
    // Vokal I
    [Color(0xFF4ECDC4), Color(0xFF44A08D)],
    // Vokal U
    [Color(0xFF667EEA), Color(0xFF764BA2)],
    // Vokal E
    [Color(0xFFF093FB), Color(0xFFF5576C)],
    // Vokal O
    [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    // Konsonan Lanjutan
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
    // Kompleks 1
    [Color(0xFFFA709A), Color(0xFFFEE140)],
    // Kompleks 2
    [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
    // Kompleks 3
    [Color(0xFFFF9A9E), Color(0xFFFFD1FF)],
    // Kompleks 4
    [Color(0xFF96FBC4), Color(0xFFF9F586)],
  ];

  // Syllable colors — alternating per card
  static const List<Color> syllableColors = [
    Color(0xFFFFFFFF),
    Color(0xFFFFF176),
  ];

  static const Color cardShadow = Color(0x55000000);
  static const Color arrowColor = Colors.white;
  static const Color progressActive = Colors.white;
  static const Color progressInactive = Color(0x55FFFFFF);
  static const Color homeBackground = Color(0xFFFFF8F0);
  static const Color homePrimary = Color(0xFFFF6B6B);
  static const Color homeAccent = Color(0xFFFF8E53);
  static const Color chapterCardBg = Colors.white;
  static const Color textDark = Color(0xFF2D2D2D);
}
