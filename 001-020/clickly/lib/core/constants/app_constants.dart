class AppConstants {
  const AppConstants._();
  // constructor privat agar class ini tidak bisa di-instantiate

  static const String appName = 'Clickly';
  static const String tagline = 'Tap. Track. Repeat.';

  static const int counterMin = -999;
  static const int counterMax = 999;
  // batas ini mencegah counter tumbuh/tersusut tanpa batas
}