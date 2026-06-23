import 'package:flutter/material.dart';

/// Palet warna utama tes_love
/// Arah desain: Warm ivory + Rose-gold + Deep plum
/// Memberikan nuansa intim, dewasa, dan emosional — bukan pink cerah anak-anak
abstract final class AppColors {
  // ── Primary: Rose-gold ───────────────────────────────────
  static const Color primary = Color(0xFFBF7B5E);
  static const Color primaryLight = Color(0xFFD9A48E);
  static const Color primaryDark = Color(0xFF8C4D35);

  // ── Background ───────────────────────────────────────────
  static const Color background = Color(0xFFFBF5F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5EDE7);

  // ── Text ─────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF2D1F1A);
  static const Color textSecondary = Color(0xFF7A5C52);
  static const Color textHint = Color(0xFFBFA59B);

  // ── Accent: Deep plum ────────────────────────────────────
  static const Color accent = Color(0xFF6B3F5E);
  static const Color accentLight = Color(0xFF9C6B8C);

  // ── Love Language Colors (untuk chart & card) ─────────────
  static const Color llWords = Color(0xFFBF7B5E);    // Words of Affirmation
  static const Color llTime = Color(0xFF6B3F5E);     // Quality Time
  static const Color llGifts = Color(0xFFD4A574);    // Receiving Gifts
  static const Color llService = Color(0xFF7D9B8C);  // Acts of Service
  static const Color llTouch = Color(0xFFB8607A);    // Physical Touch

  // ── UI States ─────────────────────────────────────────────
  static const Color success = Color(0xFF5C8A6E);
  static const Color error = Color(0xFFBF4545);
  static const Color divider = Color(0xFFEADDD8);

  // ── Shadow ────────────────────────────────────────────────
  static const Color shadow = Color(0x1A2D1F1A);
  static const Color shadowMedium = Color(0x302D1F1A);
}