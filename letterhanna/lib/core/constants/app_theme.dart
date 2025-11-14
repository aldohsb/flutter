import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// AppTheme menyimpan konfigurasi theme aplikasi
// Kita pisahkan dari main.dart supaya lebih clean dan mudah maintenance
class AppTheme {
  AppTheme._(); // Private constructor

  // ========================================
  // LIGHT THEME (Theme Terang)
  // ========================================
  static ThemeData lightTheme = ThemeData(
    // === BRIGHTNESS ===
    // brightness menentukan apakah theme terang atau gelap
    brightness: Brightness.light,
    
    // === PRIMARY COLOR ===
    primaryColor: AppColors.primary,
    
    // === COLOR SCHEME ===
    // ColorScheme adalah sistem warna lengkap Material Design 3
    colorScheme: ColorScheme.light(
      // Primary: Warna utama aplikasi (untuk button, AppBar, dll)
      primary: AppColors.primary,
      // onPrimary: Warna teks/icon di atas primary color
      onPrimary: AppColors.textOnDark,
      
      // Secondary: Warna aksen/highlight
      secondary: AppColors.accent,
      onSecondary: AppColors.textOnDark,
      
      // Surface: Background untuk card, sheet, menu
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      
      // Background: Background halaman
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      
      // Error: Warna untuk error state
      error: AppColors.error,
      onError: AppColors.textOnDark,
      
      // Outline: Warna untuk border
      outline: AppColors.border,
    ),
    
    // === SCAFFOLD BACKGROUND ===
    scaffoldBackgroundColor: AppColors.background,
    
    // === APP BAR THEME ===
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnDark,
      elevation: 0, // Flat design, no shadow
      centerTitle: true,
      
      // Title text style menggunakan Google Fonts
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnDark,
        letterSpacing: 0.5,
      ),
      
      // Icon theme untuk icon di AppBar
      iconTheme: IconThemeData(
        color: AppColors.textOnDark,
        size: 24,
      ),
    ),
    
    // === TEXT THEME ===
    // TextTheme mengatur style untuk semua text di aplikasi
    textTheme: TextTheme(
      // displayLarge: Teks paling besar (untuk hero text)
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -0.25,
      ),
      
      // displayMedium: Hero text sedang
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      
      // displaySmall: Hero text kecil
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      
      // headlineLarge: Heading besar
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      
      // headlineMedium: Heading sedang (untuk page title)
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      
      // headlineSmall: Heading kecil
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      
      // titleLarge: Title untuk card, dialog
      titleLarge: GoogleFonts.lora(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      
      // titleMedium: Subtitle
      titleMedium: GoogleFonts.lora(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      
      // titleSmall: Small title
      titleSmall: GoogleFonts.lora(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      
      // bodyLarge: Body text besar
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
      
      // bodyMedium: Body text normal (paling sering dipakai)
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        letterSpacing: 0.25,
      ),
      
      // bodySmall: Body text kecil
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        letterSpacing: 0.4,
      ),
      
      // labelLarge: Label untuk button
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.25,
      ),
      
      // labelMedium: Label sedang
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.0,
      ),
      
      // labelSmall: Label kecil (untuk caption)
      labelSmall: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textHint,
        letterSpacing: 0.5,
      ),
    ),
    
    // === ELEVATED BUTTON THEME ===
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnDark,
        
        // Padding dalam button
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        
        // Shape dengan rounded corner
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        
        // Elevation (shadow)
        elevation: 2,
        
        // Text style
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    ),
    
    // === OUTLINED BUTTON THEME ===
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        
        // Border style
        side: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
        
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    ),
    
    // === TEXT BUTTON THEME ===
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        
        textStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    // === INPUT DECORATION THEME ===
    inputDecorationTheme: InputDecorationTheme(
      // Border saat tidak focus
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.border,
          width: 1.5,
        ),
      ),
      
      // Border saat focus
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      
      // Border saat error
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
      
      // Padding content dalam input
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      
      // Fill color
      filled: true,
      fillColor: AppColors.surface,
      
      // Hint text style
      hintStyle: GoogleFonts.nunito(
        color: AppColors.textHint,
        fontSize: 14,
      ),
      
      // Label text style
      labelStyle: GoogleFonts.nunito(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
    ),
    
    // === CARD THEME ===
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.cardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
    ),
    
    // === DIVIDER THEME ===
    dividerTheme: DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 16,
    ),
    
    // === ICON THEME ===
    iconTheme: IconThemeData(
      color: AppColors.textPrimary,
      size: 24,
    ),
    
    // === ENABLE MATERIAL 3 ===
    useMaterial3: true,
  );

  // ========================================
  // DARK THEME (Theme Gelap) - BONUS
  // ========================================
  // Struktur saja untuk persiapan, implementasi lengkap nanti
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryLight,
    
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.accentLight,
      surface: const Color(0xFF2C2C2C),
      background: const Color(0xFF1A1A1A),
      error: AppColors.error,
    ),
    
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    
    useMaterial3: true,
  );
}