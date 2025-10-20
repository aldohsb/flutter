import 'package:flutter/material.dart';
// Mengimpor file layar menu utama yang akan kita buat di file terpisah.
import 'package:maryam_fall/screens/main_menu_screen.dart'; // (A)

// Fungsi utama (main) aplikasi. Ini adalah titik awal eksekusi program.
void main() {
  // runApp akan menjalankan widget root dari aplikasi kita.
  runApp(const MyMaryamFallApp()); // (B)
}

// MyMaryamFallApp adalah widget utama/root aplikasi.
// Kita menggunakan StatelessWidget karena widget ini hanya mendefinisikan
// konfigurasi statis aplikasi (seperti tema dan rute awal).
class MyMaryamFallApp extends StatelessWidget {
  // Konstruktor konstan (const) adalah praktik baik untuk kinerja
  // karena Flutter tahu widget ini tidak akan berubah.
  const MyMaryamFallApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah fondasi untuk aplikasi Material Design. // (C)
    return MaterialApp(
      // Judul aplikasi (muncul di task switcher perangkat).
      title: 'MaryamFall - Game Belajar Flutter',
      
      // Mendefinisikan tema visual aplikasi secara keseluruhan.
      theme: ThemeData(
        // Menggunakan skema warna gelap (dark) untuk nuansa game.
        brightness: Brightness.dark,
        
        // Warna utama aplikasi (Primary Swatch).
        primarySwatch: Colors.blue,
        
        // Warna latar belakang default untuk Scaffold.
        // 0xFF1E1E2E adalah kode HEX untuk warna ungu/biru tua yang gelap dan elegan.
        scaffoldBackgroundColor: const Color(0xFF1E1E2E), 
        
        // Mengatur semua widget menggunakan font 'Inter'.
        // Catatan: Asumsikan font 'Inter' sudah diimpor/tersedia.
        fontFamily: 'Inter',
        
        // Mengaktifkan fitur Material 3 (opsional, tapi disarankan untuk modern app).
        useMaterial3: true, 
      ),
      
      // 'home' menentukan layar pertama yang akan ditampilkan saat aplikasi dibuka.
      home: const MainMenuScreen(), // (D)
      
      // Menghilangkan banner "DEBUG" di pojok kanan atas saat running.
      debugShowCheckedModeBanner: false,
    );
  }
}