import 'package:flutter/material.dart';

/// AppColors - Definisi warna untuk Brutalist Design
/// 
/// Brutalist design menggunakan palet warna minimal dengan kontras tinggi.
/// Fokus pada hitam-putih untuk menciptakan tampilan tegas dan fungsional.
class AppColors {
  // Private constructor untuk mencegah instantiation
  // Class ini hanya berisi static constants
  AppColors._();

  /// Warna hitam murni untuk background dan text primary
  /// Digunakan untuk menciptakan kontras maksimal
  static const Color black = Color(0xFF000000);

  /// Warna putih murni untuk background alternatif dan text on dark
  /// Complement dari black untuk high contrast
  static const Color white = Color(0xFFFFFFFF);

  /// Warna abu-abu gelap untuk border dan divider
  /// Memberikan subtle separation tanpa mengurangi kontras
  static const Color darkGrey = Color(0xFF333333);

  /// Warna abu-abu terang untuk disabled state
  /// Digunakan untuk elemen yang tidak aktif
  static const Color lightGrey = Color(0xFFCCCCCC);
}