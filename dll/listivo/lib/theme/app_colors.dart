// lib/theme/app_colors.dart
// Palet warna kustom untuk membangun identitas visual unik Listivo

import 'package:flutter/material.dart'; // dibutuhkan untuk tipe data Color

class AppColors {
  // Warna seed utama; dari sinilah Material 3 menurunkan seluruh ColorScheme
  static const Color seed = Color(0xFF4C5FD5);

  // Warna hangat untuk merayakan progres yang mendekati 100% selesai
  static const Color celebrate = Color(0xFFFFB74D);

  // Warna tenang untuk kondisi progres masih di awal (baru mulai bekerja)
  static const Color calm = Color(0xFF64B5F6);

  // Warna untuk area swipe-to-delete, merah yang tidak terlalu mencolok
  static const Color danger = Color(0xFFE85D53);

  // Warna netral untuk teks sekunder dan elemen yang tidak butuh penekanan
  static const Color neutral = Color(0xFF9AA0B4);
}