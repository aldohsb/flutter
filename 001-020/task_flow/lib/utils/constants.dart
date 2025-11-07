// File ini berisi nilai-nilai tetap yang dipakai di seluruh aplikasi
// Seperti daftar warna, ukuran, dan opsi-opsi pilihan

import 'package:flutter/material.dart';

// Kelas untuk menyimpan semua konstanta aplikasi
class AppConstants {
  // Nama box Hive untuk menyimpan data tasks
  // Box seperti "kotak" tempat penyimpanan data di Hive
  static const String tasksBoxName = 'tasks_box';

  // Daftar kategori task yang tersedia
  // User bisa memilih salah satu kategori ini untuk setiap task
  static const List<String> categories = [
    'Work',      // Pekerjaan
    'Personal',  // Pribadi
    'Shopping',  // Belanja
    'Health',    // Kesehatan
    'Study',     // Belajar
    'Other',     // Lainnya
  ];

  // Daftar level prioritas
  // Menentukan seberapa penting/mendesak suatu task
  static const List<String> priorities = [
    'Low',      // Prioritas rendah
    'Medium',   // Prioritas sedang
    'High',     // Prioritas tinggi
  ];

  // Warna untuk setiap level prioritas
  // Map = pasangan key-value, seperti kamus
  static const Map<String, Color> priorityColors = {
    'Low': Colors.green,       // Hijau untuk prioritas rendah
    'Medium': Colors.orange,   // Orange untuk prioritas sedang
    'High': Colors.red,        // Merah untuk prioritas tinggi
  };

  // Warna untuk setiap kategori
  // Membuat tampilan lebih colorful dan mudah dibedakan
  static const Map<String, Color> categoryColors = {
    'Work': Color(0xFF6366F1),      // Indigo
    'Personal': Color(0xFFEC4899),  // Pink
    'Shopping': Color(0xFF10B981),  // Green
    'Health': Color(0xFFEF4444),    // Red
    'Study': Color(0xFF8B5CF6),     // Purple
    'Other': Color(0xFF6B7280),     // Gray
  };

  // Ukuran padding/jarak standar
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border radius untuk sudut yang membulat
  static const double defaultBorderRadius = 12.0;

  // Waktu reminder default (jam 9 pagi)
  static const int defaultReminderHour = 9;
  static const int defaultReminderMinute = 0;
}