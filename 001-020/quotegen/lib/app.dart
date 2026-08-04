// app.dart
// File ini bertanggung jawab merakit MaterialApp dengan tema yang sudah kita buat.
// Memisahkan ini dari main.dart adalah praktik standar agar main.dart tetap "bersih"
// dan hanya berfungsi sebagai pemicu (trigger) aplikasi.

import 'package:flutter/material.dart'; // widget dasar Material Design
import 'theme/app_theme.dart'; // import tema kustom yang baru kita bangun

class QuotegenApp extends StatelessWidget {
  // StatelessWidget karena root app tidak menyimpan state apapun secara langsung
  const QuotegenApp({super.key}); // constructor const untuk optimisasi rebuild

  @override
  Widget build(BuildContext context) {
    // method build dipanggil sekali saat app pertama kali dirender
    return MaterialApp(
      title: 'Quotegen', // judul aplikasi, tampil di task switcher OS/browser tab
      debugShowCheckedModeBanner: false, // menyembunyikan banner "DEBUG" di pojok layar
      theme: AppTheme.dark, // menerapkan tema gelap kustom kita ke seluruh app
      home: const Scaffold(
        // Scaffold sementara sebagai placeholder, akan diganti HomeScreen di Tahap 10
        body: Center(
          child: Text(
            'Quotegen - Tahap 2: Tema Aktif 🎨', // teks konfirmasi tema sudah jalan
          ),
        ),
      ),
    );
  }
}