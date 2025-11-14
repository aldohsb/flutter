import 'package:flutter/material.dart';
import 'package:notepad_pro/utils/constants.dart';

class AppTheme {
  // Paper-Inspired Colors
  static const Color paperWhite = Color(0xFFFFFBF5);
  static const Color paperYellow = Color(0xFFFFF9E6);
  static const Color inkBlack = Color(0xFF2C3E50);
  static const Color inkBlue = Color(0xFF34495E);
  static const Color lineGray = Color(0xFFE0E0E0);
  static const Color tabRed = Color(0xFFE74C3C);
  static const Color tabBlue = Color(0xFF3498DB);
  static const Color tabGreen = Color(0xFF2ECC71);
  
  // Shadow for paper effect
  static List<BoxShadow> paperShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: inkBlue,
        secondary: tabBlue,
        surface: paperWhite,
        onSurface: inkBlack,
        surfaceContainerHighest: paperYellow,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: paperWhite,
        foregroundColor: inkBlack,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: inkBlack,
          fontSize: AppConstants.fontSizeHeading,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Card
      cardTheme: CardThemeData(
        color: paperWhite,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
          borderSide: BorderSide(color: lineGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
          borderSide: BorderSide(color: lineGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusS),
          borderSide: BorderSide(color: tabBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingM,
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: tabBlue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: inkBlack,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeHeading,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
        titleLarge: TextStyle(
          fontSize: AppConstants.fontSizeTitle,
          fontWeight: FontWeight.w500,
          color: inkBlack,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeBody,
          color: inkBlack,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: inkBlack,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: inkBlack,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: inkBlue,
        size: 24,
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        color: lineGray,
        thickness: 1,
        space: AppConstants.spacingM,
      ),
    );
  }
  
  // Paper line decoration
  static BoxDecoration paperLineDecoration = BoxDecoration(
    color: paperWhite,
    image: DecorationImage(
      image: const AssetImage('assets/paper_lines.png'),
      repeat: ImageRepeat.repeat,
      opacity: 0.3,
    ),
  );
  
  // Notebook tab decoration
  static BoxDecoration tabDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 4,
          offset: const Offset(2, 0),
        ),
      ],
    );
  }
}