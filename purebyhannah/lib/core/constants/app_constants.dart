class AppConstants {
  // App Info
  static const String appName = 'PureByHannah';
  static const String appTagline = 'Fresh. Pure. Healthy.';
  static const String appVersion = '1.0.0';
  
  // API & Backend (akan digunakan nanti)
  static const String baseUrl = 'https://api.purebyhannah.com';
  static const String apiVersion = 'v1';
  
  // Durations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
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
  static const double radiusRound = 999.0;
  
  // Icon Sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Image Sizes
  static const double avatarS = 40.0;
  static const double avatarM = 60.0;
  static const double avatarL = 80.0;
  static const double productImageS = 80.0;
  static const double productImageM = 120.0;
  static const double productImageL = 200.0;
  
  // Max Widths
  static const double maxContentWidth = 600.0;
  static const double maxDialogWidth = 400.0;
  
  // Assets Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String logoWhitePath = 'assets/images/logo_white.png';
  static const String splashBgPath = 'assets/images/splash_bg.png';
  
  // Membership Tiers
  static const String membershipSilver = 'Silver';
  static const String membershipGold = 'Gold';
  static const String membershipPlatinum = 'Platinum';
  
  // Product Categories
  static const List<String> productCategories = [
    'All',
    'Detox',
    'Energy',
    'Immunity',
    'Beauty',
    'Weight Loss',
    'Kids',
  ];
  
  // Currency
  static const String currency = 'Rp';
  static const String currencySymbol = 'Rp';
  
  // Social Media
  static const String instagramUrl = 'https://instagram.com/purebyhannah';
  static const String facebookUrl = 'https://facebook.com/purebyhannah';
  static const String whatsappNumber = '+6281234567890';
  
  // Contact
  static const String email = 'hello@purebyhannah.com';
  static const String phone = '+62 812-3456-7890';
  static const String address = 'Jl. Sehat No. 123, Jakarta';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  
  // Pagination
  static const int itemsPerPage = 10;
  static const int maxSearchResults = 50;
}