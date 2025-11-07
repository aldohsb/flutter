// Import Flutter Material untuk akses Color class
import 'package:flutter/material.dart';

// Class AppColors menyimpan semua warna aplikasi
// Kita pakai class karena bisa dikelompokkan dan mudah diakses
// Semua property static supaya bisa diakses tanpa instansiasi
class AppColors {
  // Constructor private (_) supaya class ini tidak bisa di-instantiate
  // Kita hanya butuh static properties, bukan object
  AppColors._();

  // === PRIMARY COLORS (Warna Utama) ===
  // Warna coklat tua untuk AppBar dan elemen utama
  static const Color primary = Color(0xFF5D4037); // Brown 800
  
  // Warna coklat lebih terang untuk hover/selected state
  static const Color primaryLight = Color(0xFF8D6E63); // Brown 400
  
  // Warna coklat sangat gelap untuk teks pada background terang
  static const Color primaryDark = Color(0xFF3E2723); // Brown 900

  // === ACCENT COLORS (Warna Aksen) ===
  // Warna emas/gold untuk highlight dan CTA (Call To Action)
  static const Color accent = Color(0xFFD4AF37); // Gold
  
  // Warna emas lebih terang untuk hover effect
  static const Color accentLight = Color(0xFFE8C468);

  // === BACKGROUND COLORS ===
  // Background utama aplikasi (off-white untuk kesan elegant)
  static const Color background = Color(0xFFFAF8F6);
  
  // Background untuk card dan elevated surface
  static const Color surface = Color(0xFFFFFFFF);
  
  // Background untuk section yang perlu dibedakan
  static const Color surfaceVariant = Color(0xFFF5F3F1);

  // === TEXT COLORS ===
  // Warna teks utama (hampir hitam)
  static const Color textPrimary = Color(0xFF212121);
  
  // Warna teks secondary (abu-abu gelap)
  static const Color textSecondary = Color(0xFF757575);
  
  // Warna teks hint/placeholder (abu-abu terang)
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Warna teks di atas background gelap
  static const Color textOnDark = Color(0xFFFFFFFF);

  // === SEMANTIC COLORS (Warna dengan Makna) ===
  // Hijau untuk success message (pembelian berhasil, dll)
  static const Color success = Color(0xFF4CAF50);
  
  // Merah untuk error message
  static const Color error = Color(0xFFE53935);
  
  // Kuning untuk warning
  static const Color warning = Color(0xFFFFA726);
  
  // Biru untuk info
  static const Color info = Color(0xFF42A5F5);

  // === DIVIDER & BORDER COLORS ===
  // Warna untuk garis pemisah
  static const Color divider = Color(0xFFE0E0E0);
  
  // Warna untuk border input field
  static const Color border = Color(0xFFCCCCCC);

  // === SHADOW COLOR ===
  // Warna untuk box shadow (transparansi 15%)
  static Color shadow = const Color(0xFF000000).withOpacity(0.15);
  
  // Shadow untuk card (transparansi 10%)
  static Color cardShadow = const Color(0xFF000000).withOpacity(0.10);
}