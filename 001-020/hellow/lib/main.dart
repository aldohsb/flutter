// lib/main.dart
// ─────────────────────────────────────────────────────────
// Entry point aplikasi. Prinsip: seminimal mungkin.
// main.dart hanya bertanggung jawab "menyalakan" app,
// tidak mengatur UI secara langsung.
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_theme.dart';
import 'package:hellow/features/home/screens/home_screen.dart';

void main() {
  runApp(const HellowApp());
  // runApp: memasang widget pertama ke layar
  // Flutter akan terus menampilkan widget ini selama app berjalan
}

class HellowApp extends StatelessWidget {
  // StatelessWidget: widget yang tidak memiliki state (data yang berubah)
  // Cocok untuk root app karena konfigurasi app tidak berubah

  const HellowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hellow',
      // Nama app di task switcher OS

      debugShowCheckedModeBanner: false,
      // Sembunyikan banner "DEBUG" di pojok kanan atas

      theme: AppTheme.light,
      // Pasang tema yang sudah kita buat

      home: const HomeScreen(),
      // Halaman pertama yang ditampilkan saat app dibuka
    );
  }
}