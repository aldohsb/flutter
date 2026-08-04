// main.dart
// Ini adalah titik masuk (entry point) aplikasi Quotegen.
// Di Tahap 1, file ini sengaja masih sangat sederhana —
// tujuannya cuma memastikan project sudah bisa di-build & dijalankan.
// Nanti di Tahap 2, isi file ini akan dipecah ke app.dart + theme system.

import 'package:flutter/material.dart'; // import widget-widget Material Design bawaan Flutter

void main() {
  // fungsi main() adalah fungsi pertama yang dieksekusi Dart runtime
  runApp(const QuotegenApp()); // menjalankan widget root, membungkus seluruh tree UI
}

class QuotegenApp extends StatelessWidget {
  // StatelessWidget dipakai karena widget ini belum butuh menyimpan state apapun
  const QuotegenApp({super.key}); // constructor const, best practice untuk performa rebuild

  @override
  Widget build(BuildContext context) {
    // method build() dipanggil Flutter setiap kali widget ini perlu digambar ulang
    return MaterialApp(
      // MaterialApp adalah wrapper wajib untuk app berbasis Material Design
      title: 'Quotegen', // judul app, muncul di task switcher OS
      debugShowCheckedModeBanner: false, // menyembunyikan pita "DEBUG" merah di pojok kanan atas
      home: Scaffold(
        // Scaffold menyediakan struktur halaman dasar (body, appbar, dll)
        body: Center(
          // Center menengahkan child-nya secara horizontal & vertikal
          child: Text(
            'Quotegen - Tahap 1: Setup Berhasil ✅', // teks placeholder konfirmasi setup
            style: TextStyle(fontSize: 18), // ukuran font sedikit lebih besar biar terbaca jelas
          ),
        ),
      ),
    );
  }
}