// ============================================================
// lib/theme/app_text_styles.dart
// Sistem tipografi Moodly – skala font yang konsisten
//
// KONSEP: Type Scale
// Sama seperti warna, teks punya "hierarki" ukuran.
// Setiap level punya ukuran, ketebalan, dan warna sendiri.
// Ini memastikan tampilan teks konsisten di seluruh app.
// ============================================================

// google_fonts menyediakan font dari Google Fonts API
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart'; // Import palet warna kita sendiri

// abstract class lagi – hanya wadah konstanta statis
abstract class AppTextStyles {
  // ============================================================
  // DISPLAY – Teks sangat besar, judul halaman utama
  // ============================================================

  // displayLarge – judul yang paling besar (jarang dipakai)
  static TextStyle get displayLarge => GoogleFonts.nunito(
    fontSize: 36,
    fontWeight: FontWeight.w900,    // ExtraBold
    color: AppColors.textPrimary,
    height: 1.2,                    // Line height (jarak antar baris)
    letterSpacing: -0.5,            // Sedikit rapat untuk judul besar
  );

  // displayMedium – judul seksi atau halaman
  static TextStyle get displayMedium => GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w800,    // ExtraBold
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ============================================================
  // HEADLINE – Judul kartu, seksi, atau komponen besar
  // ============================================================

  // headlineLarge – judul kartu besar
  static TextStyle get headlineLarge => GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w700,    // Bold
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // headlineMedium – subjudul atau judul komponen menengah
  static TextStyle get headlineMedium => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // headlineSmall – label bagian atau heading kecil
  static TextStyle get headlineSmall => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ============================================================
  // BODY – Teks konten utama, paragraf, deskripsi
  // ============================================================

  // bodyLarge – teks utama konten
  static TextStyle get bodyLarge => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w500,    // Medium
    color: AppColors.textPrimary,
    height: 1.6,
  );

  // bodyMedium – teks sekunder, deskripsi pendek
  static TextStyle get bodyMedium => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // bodySmall – teks kecil, metadata, timestamp
  static TextStyle get bodySmall => GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
    height: 1.4,
  );

  // ============================================================
  // LABEL – Teks pendek pada tombol, tag, dan label UI
  // ============================================================

  // labelLarge – teks tombol utama
  static TextStyle get labelLarge => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnClay,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // labelMedium – teks tombol sekunder atau chip
  static TextStyle get labelMedium => GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnClay,
    height: 1.2,
  );

  // labelSmall – label sangat kecil, badge
  static TextStyle get labelSmall => GoogleFonts.nunito(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // ============================================================
  // SPECIAL – Gaya teks khusus untuk elemen tertentu
  // ============================================================

  // emoji – untuk menampilkan emoji besar
  static TextStyle get emoji => const TextStyle(
    // Emoji butuh font system agar render dengan benar
    fontFamily: 'NotoColorEmoji',
    fontSize: 40,
    height: 1.0,
  );

  // emojiLarge – emoji sangat besar (di layar utama)
  static TextStyle get emojiLarge => const TextStyle(
    fontSize: 64,
    height: 1.0,
  );

  // dateLabel – tanggal pada list item
  static TextStyle get dateLabel => GoogleFonts.nunito(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textHint,
    letterSpacing: 0.3,
  );
}