// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/quote_provider.dart';
import 'screens/home_screen.dart';

// main() adalah function pertama yang dijalankan
// Seperti pintu masuk aplikasi
void main() {
  // Pastikan Flutter sudah initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set orientasi portrait only (tidak bisa rotate landscape)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set status bar style (bar di atas HP untuk battery, waktu, dll)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparan
      statusBarIconBrightness: Brightness.light, // Icon putih
      systemNavigationBarColor: Colors.black, // Navigation bar di bawah
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Jalankan aplikasi
  runApp(MyApp());
}

// MyApp = root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider = widget untuk provide (kasih) data ke seluruh app
    // Seperti "sumber air" yang bisa diambil dari mana saja di app
    return ChangeNotifierProvider(
      // create = fungsi untuk bikin instance Provider
      // context => artinya: terima parameter context, return QuoteProvider baru
      create: (context) => QuoteProvider(),
      
      // child = app yang akan pakai Provider ini
      child: MaterialApp(
        // Pengaturan app
        title: 'QuoteDaily',
        
        // debugShowCheckedModeBanner = banner "DEBUG" di pojok kanan atas
        debugShowCheckedModeBanner: false,
        
        // Theme = tema warna dan style app
        theme: ThemeData(
          // primarySwatch = warna utama app
          primarySwatch: Colors.grey,
          
          // Warna scaffold (background default)
          scaffoldBackgroundColor: Colors.white,
          
          // AppBar theme
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black87,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          // FloatingActionButton theme
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 4,
          ),
          
          // Card theme
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          
          // Dialog theme
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          
          // Default text theme
          textTheme: TextTheme(
            // Ganti default font family kalau mau
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          
          // Color scheme
          colorScheme: ColorScheme.light(
            primary: Colors.black87,
            secondary: Colors.grey[800]!,
            surface: Colors.white,
            background: Colors.white,
          ),
        ),
        
        // home = halaman pertama yang ditampilkan
        home: HomeScreen(),
      ),
    );
  }
}