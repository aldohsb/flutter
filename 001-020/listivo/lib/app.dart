// lib/app.dart
// Root widget aplikasi: mengatur MaterialApp, tema global, dan halaman awal

import 'package:flutter/material.dart'; // MaterialApp
import 'theme/app_theme.dart'; // tema terang kustom
import 'screens/home_screen.dart'; // halaman pertama yang dilihat pengguna
import 'constants/app_constants.dart'; // nama aplikasi

class ListivoApp extends StatelessWidget {
  const ListivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName, // dipakai OS untuk task switcher/tab browser
      debugShowCheckedModeBanner: false, // sembunyikan banner debug merah
      theme: AppTheme.light(), // tema kustom yang sudah didefinisikan
      home: const HomeScreen(), // layar pertama aplikasi
    );
  }
}