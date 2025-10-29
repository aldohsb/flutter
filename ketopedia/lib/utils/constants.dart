import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Ketopedia';
  static const String appVersion = '1.0.0';
  
  // Colors - Red Yellow Black Theme
  static const Color primaryRed = Color(0xFFE63946);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color darkBg = Color(0xFF1A1A1A);
  static const Color cardBg = Color(0xFF2A2A2A);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  
  // Rating Colors
  static const Color ratingExcellent = Color(0xFF4CAF50);
  static const Color ratingModerate = Color(0xFFFFC107);
  static const Color ratingCareful = Color(0xFFFF9800);
  static const Color ratingAvoid = Color(0xFFE63946);
  
  // Food Rating Categories
  static const int ratingExcellentValue = 4;
  static const int ratingModerateValue = 3;
  static const int ratingCarefulValue = 2;
  static const int ratingAvoidValue = 1;
  
  // Carbs Limits (per 100g)
  static const double carbsExcellentMax = 5.0;
  static const double carbsModerateMax = 15.0;
  static const double carbsCarefulMax = 25.0;
  
  // Database
  static const String dbName = 'ketopedia.db';
  static const int dbVersion = 1;
  
  // Tables
  static const String tableUsers = 'users';
  static const String tableFoods = 'foods';
  static const String tableWeightEntries = 'weight_entries';
  static const String tableFavorites = 'favorites';
  static const String tableNotificationSettings = 'notification_settings';
  
  // Notification Channels
  static const String notificationChannelId = 'ketopedia_motivation';
  static const String notificationChannelName = 'Motivasi Keto';
  static const String notificationChannelDesc = 'Notifikasi motivasi diet keto';
  
  // Default Notification Times
  static const List<String> defaultNotificationTimes = [
    '07:00',
    '10:00',
    '13:00',
    '16:00',
    '19:00',
    '22:00',
  ];
  
  // Preferences Keys
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyFirstTime = 'first_time';
  
  // BMI Categories
  static const double bmiUnderweight = 18.5;
  static const double bmiNormal = 24.9;
  static const double bmiOverweight = 29.9;
  
  // Keto Macros (percentage)
  static const int ketoFatPercent = 70;
  static const int ketoProteinPercent = 25;
  static const int ketoCarbsPercent = 5;
  
  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // Animation Duration
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}

// Food Categories
enum FoodCategory {
  daging,
  ikan,
  telur,
  sayuran,
  buah,
  kacang,
  susu,
  minyak,
  bumbu,
  minuman,
  cemilan,
  lainnya,
}

// Gender
enum Gender {
  pria,
  wanita,
}

extension FoodCategoryExtension on FoodCategory {
  String get displayName {
    switch (this) {
      case FoodCategory.daging:
        return 'Daging & Unggas';
      case FoodCategory.ikan:
        return 'Ikan & Seafood';
      case FoodCategory.telur:
        return 'Telur';
      case FoodCategory.sayuran:
        return 'Sayuran';
      case FoodCategory.buah:
        return 'Buah';
      case FoodCategory.kacang:
        return 'Kacang & Biji';
      case FoodCategory.susu:
        return 'Susu & Produk';
      case FoodCategory.minyak:
        return 'Minyak & Lemak';
      case FoodCategory.bumbu:
        return 'Bumbu & Rempah';
      case FoodCategory.minuman:
        return 'Minuman';
      case FoodCategory.cemilan:
        return 'Cemilan';
      case FoodCategory.lainnya:
        return 'Lainnya';
    }
  }
  
  IconData get icon {
    switch (this) {
      case FoodCategory.daging:
        return Icons.set_meal;
      case FoodCategory.ikan:
        return Icons.phishing;
      case FoodCategory.telur:
        return Icons.egg;
      case FoodCategory.sayuran:
        return Icons.eco;
      case FoodCategory.buah:
        return Icons.apple;
      case FoodCategory.kacang:
        return Icons.grain;
      case FoodCategory.susu:
        return Icons.local_drink;
      case FoodCategory.minyak:
        return Icons.water_drop;
      case FoodCategory.bumbu:
        return Icons.spa;
      case FoodCategory.minuman:
        return Icons.coffee;
      case FoodCategory.cemilan:
        return Icons.cookie;
      case FoodCategory.lainnya:
        return Icons.more_horiz;
    }
  }
}

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.pria:
        return 'Pria';
      case Gender.wanita:
        return 'Wanita';
    }
  }
}