import 'package:flutter/material.dart'; // import binding utama Flutter untuk menjalankan aplikasi

import 'app.dart'; // import root widget TapzoApp

// Fungsi main, titik masuk (entry point) seluruh aplikasi Flutter
void main() {
  runApp(const TapzoApp()); // jalankan aplikasi dengan root widget TapzoApp, const demi efisiensi
}