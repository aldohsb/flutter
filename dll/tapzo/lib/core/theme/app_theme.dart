import 'package:flutter/material.dart'; // import ThemeData, ColorScheme, dan komponen Material lain

import 'app_colors.dart'; // import warna seed kustom yang sudah didefinisikan terpisah

// Kelas berisi konfigurasi tema aplikasi, dipisah agar nanti mudah ditambah dark theme
class AppTheme {
  // Constructor privat, class ini hanya wadah getter statis
  AppTheme._();

  // Tema terang utama aplikasi, dibangun dari satu seed color agar palet otomatis harmonis
  static ThemeData get lightTheme {
    // Generate ColorScheme lengkap (primary, secondary, tertiary, dst) dari satu warna dasar
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed, // warna dasar pembentuk seluruh palet warna tema
      brightness: Brightness.light, // mode terang, sesuai kebutuhan tampilan saat ini
    );

    // Kembalikan objek ThemeData lengkap yang akan dipakai di MaterialApp
    return ThemeData(
      useMaterial3: true, // aktifkan Material 3, standar desain resmi terbaru Flutter
      colorScheme: colorScheme, // terapkan skema warna hasil generate dari seed color
      scaffoldBackgroundColor: colorScheme.surface, // warna dasar latar belakang seluruh Scaffold
      fontFamily: 'Roboto', // font default aplikasi, konsisten di semua platform target
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface, // AppBar default mengikuti warna surface tema
        surfaceTintColor: Colors.transparent, // matikan efek tint otomatis Material 3 di AppBar
      ),
    );
  }
}