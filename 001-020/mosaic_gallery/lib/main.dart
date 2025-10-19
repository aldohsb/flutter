import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/app_theme.dart';
import 'screens/gallery_screen.dart';

/// Entry point aplikasi Flutter
/// main() adalah fungsi pertama yang dijalankan
void main() {
  // Pastikan Flutter binding sudah terinisialisasi
  // Diperlukan sebelum menggunakan platform channels
  WidgetsFlutterBinding.ensureInitialized();
  
  // === SYSTEM UI CONFIGURATION ===
  // Konfigurasi tampilan system UI (status bar, navigation bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar (bagian atas) - dark icons untuk light background
      statusBarColor: Colors.transparent, // Transparent agar gradient terlihat
      statusBarIconBrightness: Brightness.dark, // Dark icons
      statusBarBrightness: Brightness.light, // Untuk iOS
      
      // Navigation bar (bagian bawah Android) - white background
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // === PREFERRED ORIENTATIONS ===
  // Lock orientasi ke portrait untuk UX yang lebih baik
  // Uncomment jika ingin lock orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  
  // Jalankan aplikasi
  runApp(const MosaicGalleryApp());
}

/// MosaicGalleryApp - Root widget aplikasi
/// StatelessWidget karena configuration tidak berubah
class MosaicGalleryApp extends StatelessWidget {
  const MosaicGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // === APP METADATA ===
      
      // Title aplikasi (muncul di task switcher)
      title: 'MosaicGallery',
      
      // === THEME CONFIGURATION ===
      
      // Light theme dari AppTheme
      theme: AppTheme.lightTheme,
      
      // Theme mode - bisa light, dark, atau system
      themeMode: ThemeMode.light,
      
      // === DEBUG CONFIGURATION ===
      
      // Hide debug banner di pojok kanan atas
      debugShowCheckedModeBanner: false,
      
      // === NAVIGATION ===
      
      // Home screen - GalleryScreen
      home: const GalleryScreen(),
      
      // === BUILDER ===
      
      // Builder untuk custom configuration pada seluruh app
      // Misalnya untuk MediaQuery text scale clamping
      builder: (context, child) {
        return MediaQuery(
          // Clamp text scale factor antara 0.8 - 1.2
          // Mencegah text terlalu kecil atau besar dari user settings
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(MediaQuery.of(context)
                .textScaleFactor
                .clamp(0.8, 1.2)),
          ),
          child: child!,
        );
      },
    );
  }
}