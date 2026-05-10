import 'package:flutter/material.dart'; // import library utama Flutter (widget, tema, material design)
import 'screens/home_screen.dart'; // import HomeScreen yang jadi halaman pertama saat app dibuka

void main() => runApp(const SnapListApp()); // titik masuk app — Flutter selalu mulai dari fungsi main()

class SnapListApp extends StatelessWidget { // widget root app, StatelessWidget karena tidak punya state yang berubah
  const SnapListApp({super.key}); // constructor const agar Flutter bisa reuse objek ini tanpa buat ulang

  @override
  Widget build(BuildContext context) { // Flutter memanggil build() setiap kali widget perlu digambar ulang
    return MaterialApp( // MaterialApp menyediakan navigator, tema global, dan routing antar halaman
      debugShowCheckedModeBanner: false, // hilangkan banner merah "DEBUG" di pojok kanan atas layar
      theme: ThemeData( // objek tema yang berlaku untuk seluruh widget di dalam app ini
        colorScheme: ColorScheme.fromSeed( // generate palet warna lengkap secara otomatis dari satu warna
          seedColor: const Color(0xFF6C63FF), // warna ungu sebagai seed — semua warna lain diturunkan dari ini
        ),
        useMaterial3: true, // aktifkan Material Design 3, desain sistem terbaru dari Google/Flutter
      ),
      home: const HomeScreen(), // screen pertama yang ditampilkan — tidak ada route, langsung ke HomeScreen
    );
  }
}