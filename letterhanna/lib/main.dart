// File: lib/main.dart
// File utama aplikasi Flutter untuk LetterHanna.
// Hari 3: Tidak ada perubahan dari Hari 2. Hanya setup MaterialApp dan panggil HomeScreen.
// Nanti di Hari 6+, kita tambah routing untuk navigasi.

import 'package:flutter/material.dart';
import 'package:letterhanna/screens/home_screen.dart'; // Import HomeScreen.

void main() {
  runApp(const MyApp()); // Jalankan widget root MyApp.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetterHanna', // Title app.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber), // Warna sementara.
        useMaterial3: true, // Material Design 3.
      ),
      home: const HomeScreen(), // Panggil HomeScreen.
    );
  }
}