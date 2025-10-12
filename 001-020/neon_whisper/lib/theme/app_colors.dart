import 'package:flutter/material.dart';

/// Class untuk mendefinisikan semua warna yang digunakan di aplikasi
/// Mengikuti tema Synthwave dengan purple-pink neon palette
/// 
/// Menggunakan pattern singleton untuk konsistensi warna
class AppColors {
  // Private constructor
  const AppColors._();

  // === BACKGROUND COLORS ===
  
  /// Warna gelap untuk background atas
  /// #0a0015 adalah dark purple yang sangat gelap
  static const Color backgroundDark = Color(0xFF0a0015);
  
  /// Warna gelap dengan hint purple untuk background bawah
  /// #1a0033 adalah dark purple yang sedikit lebih terang
  static const Color backgroundDeep = Color(0xFF1a0033);

  // === NEON COLORS ===
  
  /// Warna neon pink terang untuk efek glow
  /// #ff10f0 adalah hot pink yang sangat vibrant
  static const Color neonPink = Color(0xFFff10f0);
  
  /// Warna neon purple untuk efek glow
  /// #b624ff adalah purple yang vibrant
  static const Color neonPurple = Color(0xFFb624ff);
  
  /// Warna cyan untuk aksen neon
  /// #00f0ff adalah cyan terang untuk contrast
  static const Color neonCyan = Color(0xFF00f0ff);

  // === TEXT COLORS ===
  
  /// Warna putih untuk text utama
  static const Color textPrimary = Color(0xFFffffff);
  
  /// Warna putih dengan opacity untuk text secondary
  static const Color textSecondary = Color(0xB3ffffff); // 70% opacity

  // === GRADIENT PRESETS ===
  
  /// Linear gradient untuk background dengan efek synthwave
  /// Dari dark purple di atas ke deeper purple di bawah
  static const LinearGradient backgroundGradient = LinearGradient(
    // begin: titik awal gradient (atas-kiri)
    begin: Alignment.topLeft,
    // end: titik akhir gradient (bawah-kanan)
    end: Alignment.bottomRight,
    // colors: array warna yang akan di-blend
    colors: [
      backgroundDark,    // Warna pertama (atas-kiri)
      backgroundDeep,    // Warna kedua (bawah-kanan)
    ],
  );

  /// Linear gradient untuk efek neon text
  /// Dari pink ke purple untuk tampilan synthwave authentic
  static const LinearGradient neonTextGradient = LinearGradient(
    // Gradient horizontal dari kiri ke kanan
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      neonPink,      // Pink di kiri
      neonPurple,    // Purple di kanan
    ],
  );
}