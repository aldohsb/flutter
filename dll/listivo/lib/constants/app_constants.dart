// lib/constants/app_constants.dart
// Kumpulan nilai konstan agar tidak ada "magic number" tersebar di banyak file

class AppConstants {
  // Nama aplikasi, dipakai di title bar OS dan di AppBar
  static const String appName = 'Listivo';

  // Skala padding standar agar jarak antar elemen konsisten di seluruh layar
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;

  // Radius sudut standar untuk card, sheet, dan tombol
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;

  // Durasi animasi standar, dipakai ulang di checkbox, teks coret, dan ring progres
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 450);
}