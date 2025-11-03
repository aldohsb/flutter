// Entry point aplikasi Flutter
// File ini yang pertama kali dijalankan

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/converter_provider.dart';
import 'providers/currency_provider.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';
import 'constants/app_colors.dart';

// Fungsi main adalah entry point
void main() async {
  // WidgetsFlutterBinding diperlukan untuk async operations sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage service
  // await artinya tunggu sampai selesai baru lanjut
  await StorageService().init();

  // Jalankan aplikasi
  runApp(const MyApp());
}

// Root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider untuk provide multiple providers ke seluruh app
    return MultiProvider(
      // List providers yang akan di-provide
      providers: [
        // ChangeNotifierProvider untuk ConverterProvider
        // create adalah factory function untuk create instance provider
        ChangeNotifierProvider(
          create: (context) => ConverterProvider()..init(),
          // ..init() artinya setelah create, langsung panggil init()
          // Ini disebut cascade notation
        ),

        // Provider untuk CurrencyProvider
        ChangeNotifierProvider(
          create: (context) => CurrencyProvider()..init(),
        ),
      ],
      // MaterialApp adalah root widget untuk Material Design app
      child: MaterialApp(
        // Title yang muncul di task manager
        title: 'Unit Convert',

        // Debug banner di pojok kanan atas (set false untuk production)
        debugShowCheckedModeBanner: false,

        // Theme configuration
        theme: ThemeData(
          // Color scheme
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.accent,
            surface: AppColors.surface,
            background: AppColors.background,
          ),

          // Use Material 3 design
          useMaterial3: true,

          // Scaffold background color
          scaffoldBackgroundColor: AppColors.background,

          // AppBar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            centerTitle: false,
          ),

          // Card theme
          cardTheme: CardThemeData(
            color: AppColors.surface,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          // Button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
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

          // Text button theme
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          ),

          // Input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.textLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.textLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),

          // Divider theme
          dividerTheme: DividerThemeData(
            color: AppColors.textLight.withOpacity(0.3),
            thickness: 1,
            space: 1,
          ),
        ),

        // Home adalah screen pertama yang ditampilkan
        home: const HomeScreen(),
      ),
    );
  }
}