import 'package:flutter/material.dart';
import 'screens/color_mixer_screen.dart';

/// Entry point aplikasi Flutter
/// main() adalah fungsi pertama yang dijalankan
void main() {
  // runApp() menjalankan aplikasi Flutter
  // Parameter: root widget aplikasi
  runApp(const ChromaLabApp());
}

/// Root widget aplikasi
/// StatelessWidget karena konfigurasi app tidak berubah
class ChromaLabApp extends StatelessWidget {
  const ChromaLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah wrapper untuk Material Design app
    return MaterialApp(
      // === APP CONFIGURATION ===
      
      // Judul aplikasi (muncul di task switcher)
      title: 'ChromaLab',
      
      // Hilangkan banner "DEBUG" di pojok kanan atas
      debugShowCheckedModeBanner: false,
      
      // === THEME CONFIGURATION ===
      theme: ThemeData(
        // Color scheme berbasis blue untuk konsistensi
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark, // Dark theme
        ),
        
        // Use Material 3 design system
        useMaterial3: true,
        
        // Font default untuk seluruh aplikasi
        fontFamily: 'Roboto',
        
        // Konfigurasi app bar theme
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        
        // Konfigurasi card theme
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        
        // Konfigurasi elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        // Konfigurasi icon button theme
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white70,
          ),
        ),
      ),
      
      // === HOME SCREEN ===
      // Screen pertama yang ditampilkan saat app dibuka
      home: const ColorMixerScreen(),
    );
  }
}