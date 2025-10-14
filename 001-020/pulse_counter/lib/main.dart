import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';
import 'theme/app_theme.dart';

/// Main function - Entry point aplikasi Flutter
/// void main(): function yang dijalankan pertama kali
void main() {
  // runApp: function Flutter untuk menjalankan aplikasi
  // Menerima Widget sebagai root aplikasi
  runApp(const PulseCounterApp());
}

/// PulseCounterApp - Root widget aplikasi
/// 
/// StatelessWidget: widget yang tidak memiliki state internal
/// Cocok untuk root app karena tidak perlu rebuild
class PulseCounterApp extends StatelessWidget {
  // const constructor untuk optimization
  const PulseCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: root widget untuk Material Design app
    return MaterialApp(
      // title: nama aplikasi (muncul di task switcher)
      title: 'Pulse Counter',

      // theme: konfigurasi tema aplikasi dari AppTheme
      theme: AppTheme.theme,

      // debugShowCheckedModeBanner: false untuk hide banner debug
      debugShowCheckedModeBanner: false,

      // home: widget pertama yang ditampilkan
      home: const CounterScreen(),
    );
  }
}