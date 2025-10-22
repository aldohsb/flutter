// File: lib/main.dart
// File utama aplikasi Flutter untuk LetterHanna.
// Hari 2: Kita simplify main.dart, hanya setup MaterialApp dan panggil HomeScreen.
// Nanti di hari berikutnya (Hari 6+), kita tambah routing di MaterialApp untuk navigasi.

import 'package:flutter/material.dart';
import 'package:letterhanna/screens/home_screen.dart'; // Import HomeScreen dari file baru.

// Fungsi main(): Entry point aplikasi.
void main() {
  runApp(const MyApp()); // Jalankan widget root MyApp.
}

// MyApp: Widget root aplikasi, StatelessWidget karena tidak punya state.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetterHanna', // Title app: Muncul di taskbar/app switcher.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber), // Warna sementara, nanti custom (Hari 16).
        useMaterial3: true, // Material Design 3 untuk UI modern.
      ),
      home: const HomeScreen(), // Home screen baru, gantikan MyHomePage dari Hari 1.
    );
  }
}