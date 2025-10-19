import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// AppTheme - Konfigurasi tema aplikasi dengan Memphis design
/// Mengatur appearance global untuk konsistensi UI/UX
class AppTheme {
  // Private constructor - class ini hanya menyediakan static methods
  AppTheme._();

  /// Light theme - tema utama aplikasi
  /// Memphis design biasanya menggunakan light background dengan accent colors
  static ThemeData get lightTheme {
    return ThemeData(
      // === BRIGHTNESS & COLOR SCHEME ===
      
      // Brightness menentukan apakah tema light atau dark
      brightness: Brightness.light,
      
      // Primary color - warna utama aplikasi (cyan signature Memphis)
      primaryColor: AppColors.cyan,
      
      // Scaffold background - warna dasar seluruh aplikasi
      scaffoldBackgroundColor: AppColors.background,
      
      // Color scheme untuk Material 3 compatibility
      colorScheme: const ColorScheme.light(
        primary: AppColors.cyan,
        secondary: AppColors.pink,
        surface: AppColors.cardBackground,
        error: AppColors.coral,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),

      // === APP BAR THEME ===
      
      appBarTheme: const AppBarTheme(
        // Elevation 0 untuk flat design yang modern
        elevation: 0,
        
        // Background transparent untuk custom gradient
        backgroundColor: Colors.transparent,
        
        // System UI overlay - mengatur warna status bar
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        
        // Icon theme untuk app bar icons
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
        
        // Title text style - bold dan besar untuk Memphis feel
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),

      // === CARD THEME ===
      
      cardTheme: CardThemeData(
        // Background putih bersih
        color: AppColors.cardBackground,
        
        // Elevation sedang untuk depth
        elevation: 4,
        
        // Shadow dengan opacity rendah untuk soft effect
        shadowColor: Colors.black.withOpacity(0.1),
        
        // Border radius untuk rounded corners (Memphis style)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        
        // Margin default antar cards
        margin: const EdgeInsets.all(8),
      ),

      // === TEXT THEME ===
      
      textTheme: const TextTheme(
        // Display - untuk heading besar
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: 0.5,
        ),
        
        // Headline - untuk judul section
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        
        // Title - untuk card titles
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        
        // Body - untuk text content
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
          height: 1.5, // Line height untuk readability
        ),
        
        // Body small - untuk captions
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        ),
      ),

      // === ICON THEME ===
      
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),

      // === FLOATING ACTION BUTTON ===
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.pink,
        foregroundColor: Colors.white,
        elevation: 6,
        
        // Shape dengan rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // === DIVIDER THEME ===
      
      dividerTheme: DividerThemeData(
        color: AppColors.textSecondary.withOpacity(0.2),
        thickness: 1,
        space: 16,
      ),

      // === PAGE TRANSITIONS ===
      
      // Transisi halaman yang smooth
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          // Platform-specific transitions
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Use Material 3 untuk design system terbaru
      useMaterial3: true,
    );
  }

  /// Copy theme dengan modifikasi tertentu
  /// Berguna jika ingin membuat variasi theme
  static ThemeData copyWith({
    Color? primaryColor,
    Color? scaffoldBackgroundColor,
  }) {
    final base = lightTheme;
    return base.copyWith(
      primaryColor: primaryColor ?? base.primaryColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? base.scaffoldBackgroundColor,
    );
  }
}