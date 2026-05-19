import 'package:flutter/material.dart'; // import library utama Flutter
import 'screens/color_screen.dart'; // import ColorScreen dari file terpisah

void main() => runApp(const ColorBoxApp()); // titik masuk app

class ColorBoxApp extends StatelessWidget { // hanya setup app — tidak ada logic lain di sini
  const ColorBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // setup level app: tema, navigasi
      debugShowCheckedModeBanner: false, // hilangkan tulisan DEBUG
      home: const ColorScreen(), // ColorScreen sekarang datang dari file terpisah
    );
  }
}