// ============================================================================
// FILE: lib/main.dart
// FUNGSI: Entry point aplikasi Flutter - tempat pertama kali app dijalankan
// ============================================================================

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

// ============================================================================
// MAIN FUNCTION - Titik mulai eksekusi program
// ============================================================================
// Setiap program Dart harus memiliki main() sebagai entry point
// Di sini kita call runApp() dengan widget utama kita

void main() {
  // runApp() menjalankan aplikasi Flutter dengan widget yang diberikan
  // Widget pertama akan menjadi root dari widget tree
  runApp(
    const MyApp(),
  );
}

// ============================================================================
// MY APP WIDGET - Root widget aplikasi
// ============================================================================
// Ini adalah StatelessWidget karena tidak perlu mengubah state global
// (aplikasi config yang stabil)

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // =========================================================================
  // BUILD METHOD - Menggambar struktur aplikasi
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget yang menyediakan infrastruktur Material Design
    // Ini adalah wrapper untuk aplikasi yang menggunakan design system Material

    return MaterialApp(
      // =====================================================================
      // KONFIGURASI DASAR
      // =====================================================================

      // Judul aplikasi (terlihat di task manager, dll)
      title: 'SkyMood',

      // =====================================================================
      // THEME - Konfigurasi visual global
      // =====================================================================
      // Menggunakan theme yang sudah kita buat di theme.dart
      theme: AppTheme.lightTheme,

      // =====================================================================
      // ROUTING - Halaman utama yang ditampilkan
      // =====================================================================
      // home: widget yang pertama kali ditampilkan saat app start
      home: const HomeScreen(),

      // =====================================================================
      // DEBUG BANNER - Hapus banner "Debug" di atas kanan
      // =====================================================================
      // Dalam production, debug banner sudah tidak muncul otomatis
      // Tapi untuk clarity, kita set false
      debugShowCheckedModeBanner: false,

      // =====================================================================
      // UI PROPERTIES
      // =====================================================================

      // usesMaterialDesign: Material Design sudah default di Flutter 2.0+
      // Tidak perlu set lagi

      // showPerformanceOverlay: false
      // Jika true, akan menampilkan performance metrics (untuk debugging)
      // Biarkan false untuk production

      // =====================================================================
      // MATERIAL 3 SETTINGS
      // =====================================================================
      // Material 3 adalah versi terbaru Material Design dari Google
      // Sudah di-include di theme.dart dengan useMaterial3: true
    );
  }
}

// ============================================================================
// STRUKTUR WIDGET TREE APLIKASI
// ============================================================================
// Berikut adalah hirarki widget yang akan dirender:
//
// MyApp (MaterialApp)
//   ├── theme (AppTheme.lightTheme)
//   └── home: HomeScreen
//       ├── AppBar
//       └── body: Stack
//           ├── CustomPaint (ParticlePainter) - Background animasi
//           ├── Center
//           │   └── Column
//           │       ├── Text (Heading)
//           │       └── WeatherCard (Animated)
//           │           ├── ScaleTransition
//           │           ├── FadeTransition
//           │           └── SlideTransition
//           └── Positioned
//               └── Wrap (Weather Buttons)
//                   ├── ElevatedButton (Sunny)
//                   ├── ElevatedButton (Cloudy)
//                   └── ElevatedButton (Rainy)
//
// ============================================================================

// ============================================================================
// NOTES & TIPS UNTUK PEMBELAJARAN
// ============================================================================
// 
// 1. KEY CONCEPTS YANG DIGUNAKAN:
//    - StatelessWidget vs StatefulWidget
//    - AnimationController & Tween
//    - CustomPaint untuk drawing
//    - Stack & Positioned untuk layout
//    - Claymorphism design pattern
//
// 2. PERFORMA:
//    - AnimatedBuilder hanya rebuild saat animation berubah
//    - CustomPaint hanya repaint saat shouldRepaint() return true
//    - MaterialApp theme di-cache untuk performa
//
// 3. BEST PRACTICES:
//    - Selalu dispose AnimationController di dispose()
//    - Gunakan const constructor jika tidak ada property yang berubah
//    - Pisahkan helper methods untuk readability
//    - Comment code untuk dokumentasi
//
// 4. CARA DEVELOP:
//    - Hot Reload (Ctrl+S) untuk quick testing
//    - Hot Restart (Shift+Ctrl+F5) jika ada error state
//    - Flutter DevTools untuk debugging
//
// ============================================================================