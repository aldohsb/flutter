// lib/core/theme/app_text_styles.dart
// ─────────────────────────────────────────────────────────
// Mendefinisikan semua TextStyle yang dipakai di aplikasi.
// Dipanggil dengan: AppTextStyles.greeting
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// google_fonts: memungkinkan pakai font dari Google Fonts tanpa aset manual

import 'app_colors.dart';

abstract final class AppTextStyles {
  // ── Teks sambutan besar (nama pengguna) ─────────────────
  static TextStyle get greeting => GoogleFonts.poppins(
    fontSize: 52,
    // Ukuran besar agar nama terlihat sebagai focal point
    fontWeight: FontWeight.w800,
    // ExtraBold untuk kesan tegas dan modern
    color: AppColors.coral,
    // Coral sebagai warna utama branding
    height: 1.1,
    // Line height rapat agar teks multiline tidak terpisah jauh
  );
  // 'get' berarti ini adalah getter, dipanggil tanpa tanda kurung

  // ── Teks label kecil di atas nama ───────────────────────
  static TextStyle get label => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    // Medium weight untuk teks label
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
    // Spasi antar huruf besar membuat label terlihat lebih formal
  );

  // ── Teks di dalam tombol ─────────────────────────────────
  static TextStyle get button => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    // SemiBold untuk tombol
    color: AppColors.textOnDark,
    letterSpacing: 0.5,
  );
}