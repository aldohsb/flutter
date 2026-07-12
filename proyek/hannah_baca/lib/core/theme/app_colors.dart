import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFFFF8EC);
  static const Color primary = Color(0xFFFF6B6B);
  static const Color secondary = Color(0xFF4ECDC4);
  static const Color accent = Color(0xFFFFD93D);
  static const Color textDark = Color(0xFF2D2A32);
  static const Color locked = Color(0xFFBFC0C0);

  // Warna per suku kata (rotasi otomatis)
  static const List<Color> syllablePalette = [
    Color(0xFFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFFFFD93D),
    Color(0xFF6A67CE),
    Color(0xFFFF9F1C),
    Color(0xFF2EC4B6),
  ];

  // Warna kartu level per tier (1..5)
  static const List<Color> tierColors = [
    Color(0xFF7BC96F),
    Color(0xFF4ECDC4),
    Color(0xFFFFD93D),
    Color(0xFFFF9F1C),
    Color(0xFFFF6B6B),
  ];
}