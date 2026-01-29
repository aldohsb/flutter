class AppConstants {
  // App Info
  static const String appName = 'Timer Aldo';
  static const String appVersion = '1.0.0';
  
  // Timer Settings
  static const int defaultIdleThresholdSeconds = 300; // 5 minutes
  static const int timerTickIntervalMs = 100;
  static const int idleCheckIntervalMs = 5000; // Check every 5 seconds
  
  // Window Settings
  static const double defaultOpacity = 0.95;
  static const double minOpacity = 0.3;
  static const double maxOpacity = 1.0;
  
  // Storage Keys
  static const String storageKeyCategories = 'categories';
  static const String storageKeyStatistics = 'statistics';
  static const String storageKeySettings = 'settings';
  static const String storageKeyActiveSessions = 'active_sessions';
  
  // Hotkey Settings
  static const String defaultPauseHotkey = 'ctrl+alt+p';
  static const String defaultResetHotkey = 'ctrl+alt+r';
  
  // UI Constants
  static const double timerFontSizeSmall = 48.0;
  static const double timerFontSizeMedium = 72.0;
  static const double timerFontSizeLarge = 96.0;
  
  // Colors
  static const int primaryColorValue = 0xFF6366F1; // Indigo
  static const int accentColorValue = 0xFF8B5CF6; // Purple
  static const int successColorValue = 0xFF10B981; // Green
  static const int warningColorValue = 0xFFF59E0B; // Amber
  static const int errorColorValue = 0xFFEF4444; // Red
  
  // Statistics
  static const int maxStatisticsHistory = 90; // days
  
  // Default Categories
  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Work', 'color': 0xFF3B82F6, 'icon': 'work'},
    {'name': 'Study', 'color': 0xFF8B5CF6, 'icon': 'school'},
    {'name': 'Break', 'color': 0xFF10B981, 'icon': 'coffee'},
    {'name': 'Meeting', 'color': 0xFFF59E0B, 'icon': 'people'},
    {'name': 'Other', 'color': 0xFF6B7280, 'icon': 'more'},
  ];
}
