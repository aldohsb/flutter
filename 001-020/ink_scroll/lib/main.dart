// File: lib/main.dart
// Penjelasan: Entry point aplikasi Flutter
// File ini adalah yang pertama dijalankan saat app start

import 'package:flutter/material.dart';
import 'utils/theme_utils.dart';
import 'screens/home_screen.dart';

/// Function main() adalah entry point untuk semua Flutter apps
/// Harus ada di project, dan dijalankan pertama kali saat app start
void main() {
  // runApp() adalah function yang memulai Flutter application
  // Parameter adalah root widget dari aplikasi
  runApp(const InkScrollApp());
}

/// Root widget aplikasi
/// StatelessWidget karena aplikasi structure tidak berubah (hanya theme)
class InkScrollApp extends StatelessWidget {
  const InkScrollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // === MATERIAL APP ===
    // MaterialApp adalah wrapper untuk aplikasi yang menggunakan Material Design
    return MaterialApp(
      // Judul aplikasi (untuk system/device)
      title: 'InkScroll',

      // Debug banner di corner kanan atas (biasanya debug)
      debugShowCheckedModeBanner: false,

      // === THEME ===
      // Gunakan theme yang kita definisikan di AppTheme
      theme: AppTheme.buildTheme(),

      // === HOME SCREEN ===
      // home adalah screen pertama yang ditampilkan saat app start
      home: const HomeScreen(),
    );
  }
}