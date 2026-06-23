import 'package:flutter/material.dart';

/// Palet warna utama aplikasi. Dipisah dari [ThemeData] agar dapat
/// direferensikan langsung oleh widget kustom (mis. grafik, kartu trait)
/// tanpa harus menggali `Theme.of(context)` setiap saat.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4338CA);
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF312E81);

  static const Color secondary = Color(0xFF06B6D4);

  static const Color background = Color(0xFFF7F7FB);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1E1B2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  static const Color border = Color(0xFFE5E7EB);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  static const List<Color> profileAvatarPalette = [
    Color(0xFF6C5CE7),
    Color(0xFF00B894),
    Color(0xFFE17055),
    Color(0xFF0984E3),
    Color(0xFFD63031),
    Color(0xFFE84393),
    Color(0xFF00CEC9),
    Color(0xFFFDCB6E),
  ];
}
