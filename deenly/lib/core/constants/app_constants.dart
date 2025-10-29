/// Konstanta aplikasi Deenly
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Deenly';
  static const String appTagline = 'Belajar Islam, Setiap Hari';
  static const String appVersion = '1.0.0';

  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 100.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Animation Duration
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // API & Storage Keys (akan digunakan nanti)
  static const String storageThemeKey = 'theme_mode';
  static const String storageLanguageKey = 'language';
  static const String storageUserKey = 'user_data';
  static const String storageProgressKey = 'course_progress';

  // Dummy Assets (untuk saat ini)
  static const String dummyAvatar = 'https://ui-avatars.com/api/?name=User&background=B8C2A0&color=fff';
  static const String dummyThumbnail = 'https://via.placeholder.com/400x200/B8C2A0/FFFFFF?text=Deenly';
}