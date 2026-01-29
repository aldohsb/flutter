import 'package:flutter/material.dart';

class AppConstants {
  // Storage Keys
  static const String storageCategories = 'categories';
  static const String storageSessions = 'sessions';
  static const String storageSettings = 'settings';
  static const String storageActiveSession = 'active_session';
  
  // Default Values
  static const int defaultIdleTimeoutSeconds = 60;
  static const int defaultWindowWidth = 280;
  static const int defaultWindowHeight = 120;
  static const double defaultOpacity = 0.85;
  
  // Timer Settings
  static const int tickIntervalMs = 100;
  static const int idleCheckIntervalMs = 1000;
  
  // Window Settings
  static const String windowTitle = 'Simple Timer';
  static const Size minWindowSize = Size(200, 80);
  static const Size maxWindowSize = Size(500, 200);
  
  // Shortcuts
  static const String defaultPauseShortcut = 'Ctrl+Shift+P';
  static const String defaultResumeShortcut = 'Ctrl+Shift+R';
  static const String defaultStopShortcut = 'Ctrl+Shift+S';
  
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF1976D2);
  static const Color accentColor = Color(0xFF64B5F6);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color errorColor = Color(0xFFCF6679);
  static const Color successColor = Color(0xFF4CAF50);
  
  // Typography
  static const double timerFontSize = 64.0;
  static const double labelFontSize = 14.0;
  static const double buttonFontSize = 16.0;
  
  // Animations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;
  
  // Default Categories
  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Work', 'color': 0xFF2196F3, 'icon': '💼'},
    {'name': 'Study', 'color': 0xFF4CAF50, 'icon': '📚'},
    {'name': 'Break', 'color': 0xFFFFC107, 'icon': '☕'},
    {'name': 'Meeting', 'color': 0xFF9C27B0, 'icon': '👥'},
  ];
}