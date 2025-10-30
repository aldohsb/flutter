// File ini mendefinisikan tema aplikasi
// Tema mengatur tampilan visual seperti warna, font, dan style di seluruh aplikasi

import 'package:flutter/material.dart';
import 'constants.dart';

// Class untuk membuat tema aplikasi
class AppTheme {
  // Private constructor - kita hanya butuh static method
  AppTheme._();

  // Method untuk membuat tema terang (light theme)
  static ThemeData lightTheme() {
    return ThemeData(
      // Menggunakan Material 3 design system (design terbaru dari Google)
      useMaterial3: true,
      
      // === SKEMA WARNA ===
      // ColorScheme menentukan warna-warna utama aplikasi
      colorScheme: ColorScheme.light(
        primary: AppConstants.primaryColor, // Warna utama (tombol, app bar, dll)
        secondary: AppConstants.secondaryColor, // Warna sekunder
        surface: Colors.white, // Warna permukaan (card, sheet, dll)
        error: Colors.red, // Warna untuk error
        onPrimary: Colors.white, // Warna text di atas warna primary
        onSecondary: Colors.white, // Warna text di atas warna secondary
        onSurface: Colors.black87, // Warna text di atas surface
      ),
      
      // === WARNA BACKGROUND ===
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      
      // === APP BAR THEME ===
      // Mengatur tampilan AppBar (header aplikasi)
      appBarTheme: const AppBarTheme(
        elevation: 0, // Hilangkan shadow
        centerTitle: false, // Title di kiri
        backgroundColor: Colors.transparent, // Background transparan
        foregroundColor: Colors.black87, // Warna text dan icon
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // === CARD THEME ===
      // Mengatur tampilan Card widget
      cardTheme: CardThemeData(
        elevation: 2, // Shadow ringan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        ),
        color: Colors.white,
      ),
      
      // === ELEVATED BUTTON THEME ===
      // Mengatur tampilan tombol elevated (tombol dengan shadow)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingNormal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // === TEXT BUTTON THEME ===
      // Mengatur tampilan tombol text (tombol tanpa background)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingNormal,
            vertical: AppConstants.paddingSmall,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // === ICON THEME ===
      // Mengatur tampilan icon secara global
      iconTheme: const IconThemeData(
        color: AppConstants.primaryColor,
        size: 24,
      ),
      
      // === INPUT DECORATION THEME ===
      // Mengatur tampilan TextField dan TextFormField
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingNormal,
          vertical: AppConstants.paddingNormal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          borderSide: const BorderSide(
            color: AppConstants.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: AppConstants.fontSizeMedium,
        ),
        hintStyle: const TextStyle(
          color: Colors.black38,
          fontSize: AppConstants.fontSizeMedium,
        ),
      ),
      
      // === TEXT THEME ===
      // Mengatur style text secara global
      textTheme: const TextTheme(
        // Display - untuk text sangat besar
        displayLarge: TextStyle(
          fontSize: AppConstants.fontSizeXXLarge,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displaySmall: TextStyle(
          fontSize: AppConstants.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        
        // Headline - untuk judul section
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        
        // Title - untuk title di card/list
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        titleMedium: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        titleSmall: TextStyle(
          fontSize: AppConstants.fontSizeNormal,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        
        // Body - untuk text biasa
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.fontSizeNormal,
          color: Colors.black87,
        ),
        bodySmall: TextStyle(
          fontSize: AppConstants.fontSizeSmall,
          color: Colors.black54,
        ),
        
        // Label - untuk label dan caption
        labelLarge: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        labelMedium: TextStyle(
          fontSize: AppConstants.fontSizeNormal,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        labelSmall: TextStyle(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
      
      // === FLOATING ACTION BUTTON THEME ===
      // Mengatur tampilan FAB (tombol bulat melayang)
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      
      // === BOTTOM NAVIGATION BAR THEME ===
      // Mengatur tampilan bottom navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(
          size: 28,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // === DIVIDER THEME ===
      // Mengatur tampilan garis pemisah
      dividerTheme: const DividerThemeData(
        color: Colors.black12,
        thickness: 1,
        space: 1,
      ),
      
      // === CHIP THEME ===
      // Mengatur tampilan Chip widget (badge/tag kecil)
      chipTheme: ChipThemeData(
        backgroundColor: AppConstants.cardColor,
        disabledColor: Colors.grey[300],
        selectedColor: AppConstants.primaryColor,
        secondarySelectedColor: AppConstants.secondaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingNormal,
          vertical: AppConstants.paddingSmall,
        ),
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontSize: AppConstants.fontSizeNormal,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        ),
      ),
    );
  }
}