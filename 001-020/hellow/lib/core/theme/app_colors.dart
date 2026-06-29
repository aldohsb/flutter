// lib/core/theme/app_colors.dart
// ─────────────────────────────────────────────────────────
// Semua warna aplikasi didefinisikan di satu tempat.
// Keuntungan: jika ingin ganti warna, cukup ubah di sini.
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
// Material package diperlukan untuk menggunakan tipe Color

abstract final class AppColors {
  // abstract: class ini tidak bisa di-instantiate (dibuat objeknya)
  // final: class ini tidak bisa di-extend (diturunkan)
  // Pola ini menggantikan 'class dengan constructor private'

  // ── Background ──────────────────────────────────────────
  static const Color background = Color(0xFFFDFCFB);
  // Putih bersih dengan sedikit warm tint, tidak mencolok

  static const Color surface = Color(0xFFF7F5F3);
  // Dipakai untuk area/card dengan background sedikit berbeda

  // ── Primary — Coral ─────────────────────────────────────
  static const Color coral = Color(0xFFFF6B6B);
  // Coral sebagai warna utama: energik tapi tetap lembut

  static const Color coralLight = Color(0xFFFFD5D5);
  // Versi terang coral, dipakai untuk highlight/fill

  static const Color coralDark = Color(0xFFE05555);
  // Versi gelap coral, dipakai untuk state pressed tombol

  // ── Secondary — Teal ────────────────────────────────────
  static const Color teal = Color(0xFF4ECDC4);
  // Teal sebagai aksen tombol: memberi kontras segar dengan coral

  static const Color tealDark = Color(0xFF3DBDB4);
  // Versi gelap teal untuk state hover/pressed

  // ── Teks ────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF2D2D2D);
  // Hampir hitam, lebih nyaman di mata dibanding pure black

  static const Color textSecondary = Color(0xFF9B9B9B);
  // Abu-abu untuk teks hint atau label sekunder

  static const Color textOnDark = Color(0xFFFFFFFF);
  // Putih untuk teks di atas background gelap (tombol teal)
}