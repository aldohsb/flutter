import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

// ============================================================================
// MAIN FUNCTION - Titik awal aplikasi Flutter
// ============================================================================
// Penjelasan: void main() adalah fungsi pertama yang dijalankan ketika app dimulai
// Fungsi async berarti bisa menjalankan operasi asynchronous
void main() {
  // Kalau ada inisialisasi yang dibutuhkan (Firebase, dll), letakkan di sini
  // Untuk sekarang kosong dulu karena masih basic
  runApp(const LetterhannaApp());
  // runApp() adalah fungsi Flutter yang menjalankan widget root
}

// ============================================================================
// LETTERANNA APP - Widget Root / Konfigurasi Global App
// ============================================================================
class LetterhannaApp extends StatelessWidget {
  // StatelessWidget: Widget yang tidak memiliki state (data yang berubah)
  // Karena konfigurasi app tidak perlu berubah saat runtime
  
  const LetterhannaApp({super.key});
  // Constructor dengan parameter optional key untuk identifikasi widget
  // super.key merupakan best practice di Flutter terbaru

  @override
  Widget build(BuildContext context) {
    // build() method: fungsi yang mengembalikan UI/Widget yang ingin ditampilkan
    // BuildContext: konteks dari widget tree (hierarchy)
    
    return MaterialApp(
      // MaterialApp: Widget wrapper utama yang menyediakan konfigurasi Material Design
      
      // ===== DEBUGGING & DEVELOPMENT =====
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: false - menyembunyikan banner "DEBUG" di pojok
      
      // ===== TEMA & STYLING =====
      title: 'Letterhanna',
      // title: judul aplikasi yang muncul di recent apps dan browser tab
      
      theme: ThemeData(
        // ThemeData: konfigurasi tema global aplikasi (warna, font, style)
        
        useMaterial3: true,
        // useMaterial3: true - menggunakan Material Design 3 (design terbaru Google)
        
        colorScheme: ColorScheme.fromSeed(
          // colorScheme: palet warna yang konsisten di seluruh app
          // fromSeed: membuat color scheme dari satu warna utama
          
          seedColor: const Color(0xFF2C2C2C),
          // seedColor: warna dasar - kita gunakan coklat tua untuk elegant classic
          // 0xFF2C2C2C adalah format hex color di Flutter (FF = opacity penuh)
          
          brightness: Brightness.light,
          // brightness: mode terang/gelap
        ),
        
        textTheme: GoogleFonts.playfairDisplayTextTheme(),
        // textTheme: menggunakan Google Font "Playfair Display" untuk teks
        // Font ini elegant, classic, cocok untuk brand premium
        // TextTheme: definisi style untuk Heading, Body, Label, dll
        // CATATAN: Hari-hari berikutnya akan customize lebih detail
        
        scaffoldBackgroundColor: const Color(0xFFFAF9F7),
        // scaffoldBackgroundColor: warna background utama semua halaman
        // 0xFFFAF9F7: warna cream/beige yang elegant
      ),
      
      // ===== ROUTING =====
      home: const HomePage(),
      // home: halaman pertama yang ditampilkan saat app dibuka
      // HomePage: widget yang akan kita buat selanjutnya
      
      // CATATAN untuk materi berikutnya:
      // routes: akan ditambahkan untuk navigasi antar halaman
      // onGenerateRoute: untuk dynamic routing
    );
  }
}

// ============================================================================
// PENJELASAN STRUKTUR FOLDER YANG HARUS DIBUAT:
// ============================================================================
// letterhanna/
// ├── lib/
// │   ├── main.dart (file ini)
// │   ├── pages/
// │   │   ├── home_page.dart (akan dibuat)
// │   │   └── (halaman lain akan ditambah bertahap)
// │   ├── widgets/
// │   │   ├── custom_widgets.dart (akan dibuat)
// │   │   └── (widget reusable lain)
// │   ├── models/
// │   │   ├── product.dart (akan dibuat)
// │   │   └── (model data lain)
// │   ├── services/
// │   │   └── (API services, database, dll - ditambah kemudian)
// │   └── utils/
// │       ├── constants.dart
// │       └── (utilities lain)
// ├── assets/
// │   ├── images/
// │   ├── icons/
// │   └── fonts/ (handwriting fonts - ditambah kemudian)
// ├── pubspec.yaml (file konfigurasi - sudah dibuat)
// └── README.md
//
// ============================================================================
// ALASAN STRUKTUR INI:
// ============================================================================
// - Modular: setiap folder punya tanggung jawab yang jelas
// - Scalable: mudah ditambah file baru tanpa kacau
// - Maintainable: mudah dicari dan diubah
// - Best Practice: struktur standar industri Flutter
// ============================================================================