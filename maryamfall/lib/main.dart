import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

// Fungsi main adalah entry point aplikasi Flutter
// Fungsi ini yang pertama kali dijalankan saat app dibuka
void main() {
  // runApp() adalah fungsi Flutter untuk menjalankan aplikasi
  // Parameter yang diberikan adalah widget root (widget paling atas)
  runApp(const MaryamFallApp());
}

// StatelessWidget adalah widget yang tidak berubah (immutable)
// Cocok untuk tampilan yang statis seperti app wrapper ini
class MaryamFallApp extends StatelessWidget {
  // Constructor dengan const berarti widget ini compile-time constant
  // Ini membuat performa lebih baik karena Flutter bisa cache widget ini
  const MaryamFallApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget root untuk aplikasi Material Design
    // Material Design adalah design system dari Google
    return MaterialApp(
      // Judul aplikasi (muncul di task switcher)
      title: 'MaryamFall Game',
      
      // debugShowCheckedModeBanner: false menghilangkan banner "DEBUG" 
      // di pojok kanan atas saat development
      debugShowCheckedModeBanner: false,
      
      // Theme mengatur tampilan global aplikasi
      theme: ThemeData(
        // primarySwatch adalah color palette utama
        // Colors.blue akan generate berbagai shade biru otomatis
        primarySwatch: Colors.blue,
        
        // useMaterial3 mengaktifkan Material Design 3 (design terbaru)
        useMaterial3: true,
      ),
      
      // home adalah screen pertama yang ditampilkan
      // Kita langsung masuk ke GameScreen
      home: const GameScreen(),
    );
  }
}