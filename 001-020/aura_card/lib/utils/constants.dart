// ============================================================================
// FILE: lib/utils/constants.dart
// FUNGSI: Menyimpan semua konstanta warna, ukuran, dan data profil
// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// WARNA - Glassmorphism Color Palette
// ============================================================================
class AppColors {
  // Warna-warna untuk gradien dan efek glassmorphism
  // Kami menggunakan warna ungu, biru, dan pink untuk efek holistik yang modern
  
  // Warna gradien pertama (warna terang di atas)
  static const Color primaryGradientStart = Color(0xFF8B5FFF);
  
  // Warna gradien kedua (warna gelap di bawah)
  static const Color primaryGradientEnd = Color(0xFF5B7CFF);
  
  // Warna aksen untuk border glassmorphism
  static const Color glassAccent = Color(0xFFFFFFFF);
  
  // Warna teks utama
  static const Color textPrimary = Color(0xFFFFFFFF);
  
  // Warna teks sekunder (sedikit lebih transparan)
  static const Color textSecondary = Color(0xFFE0E0E0);
  
  // Warna background utama
  static const Color backgroundDark = Color(0xFF0F0F23);
}

// ============================================================================
// UKURAN - Dimensi Widget
// ============================================================================
class AppSizes {
  // Ukuran untuk padding dan margin
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  // Ukuran border radius (sudut melengkung)
  static const double borderRadiusSmall = 12.0;
  static const double borderRadiusMedium = 20.0;
  static const double borderRadiusLarge = 32.0;
  
  // Ukuran kartu profil
  static const double cardWidth = 320.0;
  static const double cardHeight = 420.0;
  
  // Ukuran foto profil
  static const double profileImageSize = 120.0;
  
  // Ukuran blur untuk BackdropFilter
  // Semakin besar, semakin blur efeknya
  static const double blurSigma = 15.0;
}

// ============================================================================
// DATA PROFIL - Informasi yang Ditampilkan di Kartu
// ============================================================================
class ProfileData {
  // Nama profil
  static const String profileName = 'Alex Rivera';
  
  // Bio atau deskripsi singkat
  static const String profileBio = 'UI/UX Designer & Flutter Developer';
  
  // Emoji untuk karakter profil (bisa diganti dengan asset image)
  static const String profileEmoji = '✨';
}

// ============================================================================
// OPACITY - Tingkat Transparansi untuk Glassmorphism
// ============================================================================
class AppOpacity {
  // Transparansi untuk glass effect (kaca buram)
  // Nilai 0.0 = transparan penuh, 1.0 = tidak transparan
  static const double glassOpacity = 0.25;
  
  // Transparansi untuk border
  static const double borderOpacity = 0.5;
  
  // Transparansi untuk shadow
  static const double shadowOpacity = 0.3;
}