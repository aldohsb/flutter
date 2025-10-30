// File ini berisi konstanta-konstanta yang digunakan di seluruh aplikasi
// Tujuannya agar nilai-nilai penting disimpan di satu tempat dan mudah diubah

import 'package:flutter/material.dart';

// Kelas untuk menyimpan semua konstanta aplikasi
class AppConstants {
  // Private constructor - mencegah class ini dibuat instancenya
  // Karena kita hanya butuh nilai statisnya saja
  AppConstants._();

  // === KONSTANTA UNTUK AIR ===
  
  // Target minum air per hari dalam mililiter (2000ml = 2 liter)
  static const int defaultDailyGoalMl = 2000;
  
  // Ukuran satu gelas standar dalam mililiter
  static const int defaultGlassSize = 200;
  
  // Berbagai pilihan ukuran gelas yang bisa dipilih user
  static const List<int> glassSizes = [150, 200, 250, 300, 500];

  // === KONSTANTA UNTUK NOTIFIKASI ===
  
  // ID untuk channel notifikasi Android
  // Channel adalah kategori notifikasi di Android
  static const String notificationChannelId = 'water_reminder_channel';
  
  // Nama channel yang muncul di settings Android
  static const String notificationChannelName = 'Water Reminders';
  
  // Deskripsi channel
  static const String notificationChannelDescription = 
      'Notifications to remind you to drink water';

  // === KONSTANTA UNTUK PENYIMPANAN DATA ===
  
  // Nama box Hive untuk menyimpan data intake air
  // Box seperti tabel dalam database
  static const String intakeBoxName = 'water_intakes';
  
  // Nama box untuk menyimpan settings/preferensi
  static const String settingsBoxName = 'settings';
  
  // Nama box untuk menyimpan data goals/target
  static const String goalsBoxName = 'hydration_goals';

  // === KEY UNTUK SHARED PREFERENCES ===
  
  // Key untuk menyimpan target harian
  static const String keyDailyGoal = 'daily_goal';
  
  // Key untuk menyimpan ukuran gelas favorit
  static const String keyGlassSize = 'glass_size';
  
  // Key untuk menyimpan status notifikasi (aktif/tidak)
  static const String keyNotificationEnabled = 'notification_enabled';
  
  // Key untuk menyimpan nama user
  static const String keyUserName = 'user_name';

  // === KONSTANTA WAKTU ===
  
  // Interval pengingat default (dalam menit)
  static const int defaultReminderInterval = 120; // 2 jam
  
  // Jam mulai pengingat (pagi)
  static const int reminderStartHour = 7; // 7 AM
  
  // Jam selesai pengingat (malam)
  static const int reminderEndHour = 22; // 10 PM

  // === PESAN-PESAN NOTIFIKASI ===
  
  // List pesan motivasi yang muncul di notifikasi
  // Setiap kali notifikasi muncul, akan dipilih secara random
  static const List<String> reminderMessages = [
    'Time to hydrate! 💧',
    'Don\'t forget to drink water!',
    'Stay hydrated, stay healthy! 🥤',
    'Your body needs water now!',
    'Drink up! Keep that streak going! 💪',
    'Hydration time! Your body will thank you!',
    'Water break! Let\'s reach that goal! 🎯',
  ];

  // === KONSTANTA UNTUK GOALS/ACHIEVEMENTS ===
  
  // Definisi berbagai achievement yang bisa dicapai user
  // Setiap achievement punya nama, deskripsi, target, dan poin
  static const List<Map<String, dynamic>> availableGoals = [
    {
      'id': 'daily_goal',
      'title': 'Reach your 1 day goal',
      'description': 'Complete your daily hydration target',
      'icon': '🎯',
      'points': 50,
      'target': 1, // 1 hari
    },
    {
      'id': 'limit_caffeine',
      'title': 'Limit caffeine consumption',
      'description': 'Drink water instead of coffee',
      'icon': '☕',
      'points': 80,
      'target': 7, // 7 hari
    },
    {
      'id': 'no_alcohol',
      'title': 'Don\'t drink alcohol',
      'description': 'Stay away from alcoholic drinks',
      'icon': '🍺',
      'points': 95,
      'target': 30, // 30 hari
    },
    {
      'id': 'proper_diet',
      'title': 'Maintaining proper diet',
      'description': 'Balance your nutrition with water',
      'icon': '🥗',
      'points': 80,
      'target': 14, // 14 hari
    },
    {
      'id': 'thirty_day',
      'title': 'Reach your 30 day goal',
      'description': 'Complete 30 days of hydration',
      'icon': '🏆',
      'points': 93,
      'target': 30, // 30 hari
    },
  ];

  // === KONSTANTA WARNA (akan digunakan di theme) ===
  
  // Warna utama aplikasi - biru muda seperti air
  static const Color primaryColor = Color(0xFF4DD0E1);
  
  // Warna sekunder - biru lebih gelap
  static const Color secondaryColor = Color(0xFF0097A7);
  
  // Warna background - biru sangat muda
  static const Color backgroundColor = Color(0xFFB2EBF2);
  
  // Warna untuk card/kartu
  static const Color cardColor = Color(0xFFE0F7FA);
  
  // Warna accent - oranye untuk kontras
  static const Color accentColor = Color(0xFFFF9800);
  
  // Warna sukses - hijau
  static const Color successColor = Color(0xFF4CAF50);
  
  // Warna warning - kuning
  static const Color warningColor = Color(0xFFFFC107);

  // === KONSTANTA TEXT STYLES ===
  
  // Ukuran font untuk berbagai keperluan
  static const double fontSizeSmall = 12.0;
  static const double fontSizeNormal = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeXXLarge = 32.0;

  // === KONSTANTA SPACING/JARAK ===
  
  // Padding standar untuk consistency
  static const double paddingSmall = 8.0;
  static const double paddingNormal = 16.0;
  static const double paddingLarge = 24.0;
  
  // Border radius untuk card dan button
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusNormal = 16.0;
  static const double borderRadiusLarge = 24.0;

  // === KONSTANTA ANIMASI ===
  
  // Durasi animasi standar
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
}