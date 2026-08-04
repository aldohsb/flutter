import 'package:flutter/material.dart'; // import widget dasar Material Design
import 'package:konverto/screens/home_screen.dart'; // import halaman utama aplikasi

// Widget root aplikasi, mengatur tema global & halaman awal
class KonvertoApp extends StatelessWidget { // stateless karena tidak ada state berubah di level root
  const KonvertoApp({super.key}); // constructor const standar

  @override
  Widget build(BuildContext context) { // render aplikasi
    return MaterialApp( // widget utama yang menyediakan navigasi & tema Material
      title: 'Konverto', // judul aplikasi (dipakai di title bar desktop/web)
      debugShowCheckedModeBanner: false, // sembunyikan banner debug agar tampilan bersih
      theme: ThemeData( // konfigurasi tema terang aplikasi
        colorScheme: ColorScheme.fromSeed( // buat skema warna otomatis dari satu warna dasar (Material 3)
          seedColor: const Color(0xFF2563EB), // warna dasar biru profesional sebagai identitas brand
          brightness: Brightness.light, // mode terang untuk tema ini
        ),
        useMaterial3: true, // aktifkan komponen visual Material 3 terbaru
        inputDecorationTheme: const InputDecorationTheme( // tema global untuk semua TextFormField/Dropdown
          filled: true, // aktifkan background terisi pada input
          fillColor: Color(0xFFF3F4F6), // warna latar input abu muda agar lembut di mata
        ),
      ),
      darkTheme: ThemeData( // konfigurasi tema gelap aplikasi
        colorScheme: ColorScheme.fromSeed( // skema warna otomatis untuk mode gelap
          seedColor: const Color(0xFF2563EB), // gunakan warna dasar brand yang sama
          brightness: Brightness.dark, // mode gelap untuk tema ini
        ),
        useMaterial3: true, // tetap gunakan Material 3 di mode gelap
      ),
      themeMode: ThemeMode.system, // ikuti pengaturan tema sistem perangkat user
      home: const HomeScreen(), // halaman pertama yang tampil saat aplikasi dibuka
    );
  }
}