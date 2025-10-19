import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

/// Entry point aplikasi Flutter
/// main() function adalah function pertama yang dijalankan
void main() {
  // Pastikan Flutter binding sudah terinisialisasi
  // Diperlukan jika kita set SystemChrome sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set orientasi hanya portrait (vertikal)
  // Mencegah aplikasi rotate ke landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar transparan
      statusBarIconBrightness: Brightness.light, // Icon putih
      systemNavigationBarColor: Color(0xFF1a1a2e), // Navigation bar color
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Jalankan aplikasi dengan root widget MyApp
  runApp(const MyApp());
}

/// Root widget aplikasi
/// StatelessWidget karena tidak ada state yang berubah di level ini
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp - Root widget untuk Material Design app
    return MaterialApp(
      // Konfigurasi aplikasi
      title: 'MoodSphere',
      
      // Hilangkan banner debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        // Color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF), // Purple primary color
          brightness: Brightness.dark, // Dark theme
        ),
        
        // Use Material 3 design system
        useMaterial3: true,
        
        // Font family (gunakan default system font)
        fontFamily: 'sans-serif',
        
        // App bar theme
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        
        // Scaffold background
        scaffoldBackgroundColor: const Color(0xFF1a1a2e),
      ),
      
      // Home screen sebagai layar pertama
      home: const HomeScreen(),
    );
  }
}