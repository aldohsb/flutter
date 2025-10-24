import 'package:flutter/material.dart';

class AppConstants {
  // Zen Garden Theme - Soft & Calming Colors
  static const Color primaryColor = Color(0xFF7D9D6F); // Soft Sage Green
  static const Color primaryDark = Color(0xFF5A7A4F); // Deep Sage
  static const Color primaryLight = Color(0xFFA8C99E); // Light Sage
  static const Color accentColor = Color(0xFF9BB88D); // Soft Green
  static const Color backgroundColor = Color(0xFFF7F9F5); // Very Light Green Tint
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE07A5F); // Soft Coral Red
  static const Color textPrimary = Color(0xFF2D3B2D); // Dark Forest
  static const Color textSecondary = Color(0xFF5F6F5F); // Medium Green Gray
  static const Color dividerColor = Color(0xFFDDE5DD); // Soft Green Gray
  
  // Timer Settings
  static const int alarmIntervalMinutes = 15;
  static const String alarmSoundAsset = 'assets/sounds/bell.mp3';
  
  // Hive Box Names
  static const String projectsBox = 'projects_box';
  static const String sessionsBox = 'sessions_box';
  static const String settingsBox = 'settings_box';
  
  // Notification
  static const String notificationChannelId = 'zentime_channel';
  static const String notificationChannelName = 'ZenTime Notifications';
  static const String notificationChannelDescription = 'Timer and reminder notifications';
  
  // Time Format
  static const String dateFormat = 'dd MMM yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd MMM yyyy, HH:mm';
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      colorScheme: ColorScheme.light(
        primary: AppConstants.primaryColor,
        secondary: AppConstants.accentColor,
        surface: AppConstants.surfaceColor,
        error: AppConstants.errorColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppConstants.surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
      ),
    );
  }
}