// ============================================================================
// FILE: lib/main.dart
// FUNGSI: Entry point (titik masuk) aplikasi Flutter
// Ini adalah file yang pertama dijalankan ketika aplikasi dimulai
// ============================================================================

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

// ============================================================================
// MAIN FUNCTION - Fungsi Utama
// ============================================================================
void main() {
  // runApp(): Menjalankan aplikasi Flutter
  // Parameter: Widget utama aplikasi (MyApp)
  runApp(const MyApp());
}

// ============================================================================
// MY APP - Aplikasi Utama
// ============================================================================
class MyApp extends StatelessWidget {
  // const: Konstruktor const (tidak dapat diubah setelah dibuat)
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Widget root untuk aplikasi Material Design
    // Material Design adalah design system dari Google yang digunakan Flutter
    return MaterialApp(
      // title: Judul aplikasi (ditampilkan di recent apps, dll)
      title: 'AuraCard - Holographic Profile',
      
      // debugShowCheckedModeBanner: Menampilkan/menyembunyikan banner "DEBUG"
      // false = sembunyikan banner (untuk tampilan lebih clean)
      debugShowCheckedModeBanner: false,
      
      // theme: Tema visual aplikasi (warna, font, dll)
      theme: ThemeData(
        // Menggunakan tema Material 3 (latest Material Design)
        useMaterial3: true,
        
        // brightness: Terang atau gelap
        // Brightness.dark = tema gelap (dark mode)
        brightness: Brightness.dark,
        
        // primaryColor: Warna utama aplikasi
        primaryColor: AppColors.primaryGradientStart,
        
        // scaffoldBackgroundColor: Warna latar belakang Scaffold
        scaffoldBackgroundColor: AppColors.backgroundDark,
        
        // useMaterial3: Menggunakan Material 3 design system (lebih modern)
        // Sudah di-set di atas dengan: useMaterial3: true,
      ),
      
      // home: Layar yang ditampilkan saat aplikasi dimulai
      // Dalam kasus ini: HomeScreen yang berisi AuraCard
      home: const HomeScreen(),
    );
  }
}