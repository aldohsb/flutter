import 'package:flutter/material.dart'; // import widget dasar untuk MaterialApp

import 'core/theme/app_theme.dart'; // import konfigurasi tema aplikasi
import 'core/constants/app_strings.dart'; // import konstanta string aplikasi
import 'features/counter/presentation/screens/counter_screen.dart'; // import halaman utama counter

// Root widget aplikasi Tapzo, membungkus MaterialApp dan konfigurasi global
class TapzoApp extends StatelessWidget {
  const TapzoApp({super.key}); // constructor tanpa parameter tambahan

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName, // judul aplikasi, muncul di task switcher/tab browser
      debugShowCheckedModeBanner: false, // sembunyikan banner "debug" di pojok kanan atas layar
      theme: AppTheme.lightTheme, // gunakan tema terang yang sudah didefinisikan terpisah
      home: const CounterScreen(), // halaman pertama yang ditampilkan saat aplikasi dibuka
    );
  }
}