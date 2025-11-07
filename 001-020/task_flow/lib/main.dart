// Main entry point aplikasi TaskFlow
// File ini adalah yang pertama kali dijalankan saat aplikasi dibuka

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'services/hive_service.dart';
import 'services/notification_service.dart';
import 'screens/home_screen.dart';

// Fungsi main = entry point aplikasi
void main() async {
  // Memastikan binding Flutter sudah terinisialisasi
  // Wajib dipanggil jika ada async operation sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi services
  // await = tunggu sampai selesai sebelum lanjut
  await HiveService().init();           // Inisialisasi database Hive
  await NotificationService().init();   // Inisialisasi notification service

  // Request notification permissions (untuk iOS)
  await NotificationService().requestPermissions();

  // Jalankan aplikasi
  runApp(const TaskFlowApp());
}

// Root widget aplikasi
class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider = wrapper untuk menyediakan multiple providers
    // Provider membuat data tersedia untuk semua child widgets
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider = provider untuk class yang extends ChangeNotifier
        // create = fungsi untuk membuat instance provider
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
        // Bisa tambah provider lain di sini jika perlu
        // Contoh: ThemeProvider, UserProvider, dll
      ],
      // MaterialApp = root widget untuk Material Design app
      child: MaterialApp(
        // Judul aplikasi (muncul di task switcher)
        title: 'TaskFlow',
        
        // debugShowCheckedModeBanner = banner "DEBUG" di pojok kanan atas
        // Set false untuk production
        debugShowCheckedModeBanner: false,
        
        // Theme = tema warna dan style aplikasi
        theme: ThemeData(
          // Color scheme utama aplikasi
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1), // Indigo sebagai warna utama
            brightness: Brightness.light,        // Light mode
          ),
          
          // useMaterial3 = gunakan Material Design 3 (versi terbaru)
          useMaterial3: true,
          
          // Font family default
          fontFamily: 'Roboto',
          
          // AppBar theme
          appBarTheme: const AppBarTheme(
            centerTitle: true,           // Title di tengah
            elevation: 0,                // Tidak ada bayangan
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // Card theme
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          
          // Input decoration theme untuk TextField
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          
          // Elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Floating action button theme
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          
          // Checkbox theme
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          
          // Snackbar theme
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentTextStyle: const TextStyle(fontSize: 14),
          ),
          
          // Dialog theme
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
          ),
        ),
        
        // Home screen = halaman pertama yang ditampilkan
        home: const HomeScreen(),
      ),
    );
  }
}