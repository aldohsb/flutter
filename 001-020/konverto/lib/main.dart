import 'package:flutter/material.dart'; // import binding Flutter dasar untuk menjalankan aplikasi
import 'package:konverto/app.dart'; // import widget root aplikasi Konverto

// Titik masuk (entry point) aplikasi Flutter
void main() { // fungsi main wajib ada sebagai gerbang eksekusi program
  runApp(const KonvertoApp()); // jalankan aplikasi dengan widget root KonvertoApp
}