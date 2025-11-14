import 'package:flutter/material.dart';
// Import constants
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'core/constants/app_theme.dart';
import 'core/routes/app_routes.dart';
// Import screens
import 'screens/home/home_screen.dart';
import 'screens/catalog/catalog_screen.dart';
import 'screens/profile/profile_screen.dart';

// Entry point aplikasi
void main() {
  runApp(const LetterhannaApp());
}


// Root widget aplikasi
class LetterhannaApp extends StatelessWidget {
  const LetterhannaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: AppStrings.appName,
      
      // Hilangkan banner DEBUG
      debugShowCheckedModeBanner: false,
      
      // Theme configuration menggunakan AppColors
      theme: ThemeData(
        // Primary color dari AppColors
        primaryColor: AppColors.primary,
        
        // Scaffold background color
        scaffoldBackgroundColor: AppColors.background,
        
        // AppBar theme global
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnDark,
          elevation: 0,
          centerTitle: true,
        ),
        
        // Color scheme untuk Material 3
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        
        // Enable Material 3
        useMaterial3: true,
      ),
      
      // Initial route (halaman pertama yang dibuka)
      initialRoute: AppRoutes.home,
      
      // Routes configuration
      // Map<String, WidgetBuilder> yang menghubungkan route name dengan screen
      routes: {
        // Route home (/)
        AppRoutes.home: (context) => const HomeScreen(),
        
        // Route catalog (/catalog)
        AppRoutes.catalog: (context) => const CatalogScreen(),
        
        // Route profile (/profile)
        AppRoutes.profile: (context) => const ProfileScreen(),
      },
      
      // onUnknownRoute dipanggil jika user navigasi ke route yang tidak terdaftar
      // Ini seperti 404 page di web
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '404 - Page Not Found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushReplacementNamed mengganti route saat ini
                      // dengan route baru (tidak bisa back)
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnDark,
                    ),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}