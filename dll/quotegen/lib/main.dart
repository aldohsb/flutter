// main.dart
// Setelah Tahap 2, file ini menjadi sangat ramping —
// tugasnya hanya satu: memanggil runApp() dengan widget root dari app.dart.
// Ini pola standar industri: main.dart = entry point murni, app.dart = konfigurasi.

import 'package:flutter/material.dart'; // dibutuhkan untuk fungsi runApp()
import 'app.dart'; // import widget root QuotegenApp yang baru kita pisahkan

void main() {
  // fungsi main() dieksekusi pertama kali oleh Dart runtime saat app dijalankan
  runApp(const QuotegenApp()); // menjalankan aplikasi dengan widget root kita
}