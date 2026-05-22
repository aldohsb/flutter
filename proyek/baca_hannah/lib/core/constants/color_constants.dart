// lib/core/constants/color_constants.dart

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand Colors ──────────────────────────────────────────
  static const Color primary = Color(0xFFFF6B6B);       // Coral merah
  static const Color primaryLight = Color(0xFFFF8E8E);
  static const Color primaryDark = Color(0xFFE84343);

  static const Color secondary = Color(0xFF6BCB77);     // Hijau segar
  static const Color secondaryLight = Color(0xFF8FDE98);
  static const Color secondaryDark = Color(0xFF48B757);

  static const Color accent = Color(0xFFFFD93D);        // Kuning cerah
  static const Color accentLight = Color(0xFFFFE570);
  static const Color accentDark = Color(0xFFF5C400);

  // ── Background ────────────────────────────────────────────
  static const Color background = Color(0xFFFFF8F0);    // Krem hangat
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFFFF0E0);

  // ── Syllable Colors (warna per suku kata) ─────────────────
  static const List<Color> syllableColors = [
    Color(0xFFFF6B6B), // Merah coral
    Color(0xFF4ECDC4), // Teal
    Color(0xFFFFD93D), // Kuning
    Color(0xFF6BCB77), // Hijau
    Color(0xFFFF9F43), // Oranye
    Color(0xFFA29BFE), // Ungu muda
    Color(0xFFFD79A8), // Pink
    Color(0xFF00CEC9), // Cyan
  ];

  // ── Chapter Card Colors ───────────────────────────────────
  static const List<Color> chapterCardColors = [
    Color(0xFFFF6B6B), // Bab 1 - merah coral
    Color(0xFF6BCB77), // Bab 2 - hijau
    Color(0xFF4ECDC4), // Bab 3 - teal
    Color(0xFFFFD93D), // Bab 4 - kuning
    Color(0xFFFF9F43), // Bab 5 - oranye
    Color(0xFFA29BFE), // Bab 6 - ungu
    Color(0xFFFD79A8), // Bab 7 - pink
    Color(0xFF00CEC9), // Bab 8 - cyan
  ];

  // ── Text Colors ───────────────────────────────────────────
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Color(0xFFB2BEC3);
  static const Color textOnColor = Color(0xFFFFFFFF);

  // ── Status Colors ─────────────────────────────────────────
  static const Color success = Color(0xFF6BCB77);
  static const Color warning = Color(0xFFFFD93D);
  static const Color error = Color(0xFFFF6B6B);

  // ── Star Colors ───────────────────────────────────────────
  static const Color starFilled = Color(0xFFFFD93D);
  static const Color starEmpty = Color(0xFFDFE6E9);

  // ── Gradient ──────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFF8F0), Color(0xFFFFEDD5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Helper: ambil warna suku kata berdasarkan index
  static Color syllableColor(int index) {
    return syllableColors[index % syllableColors.length];
  }

  // Helper: ambil warna chapter card berdasarkan index
  static Color chapterColor(int index) {
    return chapterCardColors[index % chapterCardColors.length];
  }
}