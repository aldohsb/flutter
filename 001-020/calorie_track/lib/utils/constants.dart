import 'package:flutter/material.dart';

class AppConstants {
  // Colors - Tema Nutrition Fresh
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  
  // Macro Colors
  static const Color carbColor = Color(0xFFFF9800);
  static const Color proteinColor = Color(0xFFE91E63);
  static const Color fatColor = Color(0xFF9C27B0);
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
  
  // Daily Goals
  static const double dailyCalorieGoal = 2000;
  static const double dailyCarbGoal = 250; // grams
  static const double dailyProteinGoal = 75; // grams
  static const double dailyFatGoal = 67; // grams
  
  // Spacing
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;
}