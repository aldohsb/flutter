class AppConstants {
  // App Info
  static const String appName = 'Al Timer';
  static const String appVersion = '1.0.0';
  
  // Timer Settings
  static const int defaultIdleTimeoutSeconds = 300; // 5 minutes
  static const int activityCheckIntervalMs = 1000; // 1 second
  static const int autoSaveIntervalSeconds = 60; // 1 minute
  
  // Window Settings
  static const double defaultWindowWidth = 300.0;
  static const double defaultWindowHeight = 120.0;
  static const double minWindowWidth = 200.0;
  static const double minWindowHeight = 80.0;
  
  // Storage Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyIsTransparent = 'is_transparent';
  static const String keyAlwaysOnTop = 'always_on_top';
  static const String keyIdleTimeout = 'idle_timeout';
  static const String keyCurrentCategory = 'current_category';
  static const String keyHotkeyModifiers = 'hotkey_modifiers';
  static const String keyHotkeyKey = 'hotkey_key';
  static const String keyCategories = 'categories';
  
  // Database
  static const String dbName = 'al_timer.db';
  static const int dbVersion = 1;
  
  // Tables
  static const String tableSessions = 'sessions';
  static const String tableCategories = 'categories';
  
  // Default Categories
  static const List<String> defaultCategories = [
    'Work',
    'Study',
    'Break',
    'Meeting',
    'Personal',
  ];
  
  // Hotkeys
  static const String defaultHotkeyModifiers = 'control,shift';
  static const String defaultHotkeyKey = 'p';
  
  // Colors (for categories)
  static const List<int> categoryColors = [
    0xFF2196F3, // Blue
    0xFF4CAF50, // Green
    0xFFFFC107, // Amber
    0xFFFF5722, // Deep Orange
    0xFF9C27B0, // Purple
    0xFF00BCD4, // Cyan
    0xFFFF9800, // Orange
    0xFF795548, // Brown
    0xFF607D8B, // Blue Grey
    0xFFE91E63, // Pink
  ];
  
  // Time Formats
  static const String timeFormatHMS = 'HH:mm:ss';
  static const String timeFormatHM = 'HH:mm';
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // Statistics
  static const int statisticsDaysDefault = 7;
  static const int statisticsDaysMax = 365;
  
  // System Tray
  static const String trayIconPath = 'assets/icons/tray_icon.ico';
  static const String trayTooltip = 'Al Timer';
}