import 'package:flutter/material.dart';

class AppConstants {
  // Hive Box Names
  static const String notesBox = 'notes_box';
  static const String foldersBox = 'folders_box';
  static const String tagsBox = 'tags_box';
  
  // App Info
  static const String appName = 'NotePadPro';
  static const String appVersion = '1.0.0';
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  
  // Text Styles
  static const double fontSizeSmall = 12.0;
  static const double fontSizeBody = 16.0;
  static const double fontSizeTitle = 20.0;
  static const double fontSizeHeading = 24.0;
  
  // Rich Text Formats
  static const String boldMarker = '**';
  static const String italicMarker = '*';
  static const String underlineMarker = '_';
  
  // Default Values
  static const String defaultFolderId = 'default_folder';
  static const String defaultFolderName = 'All Notes';
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Predefined Tag Colors
  static const List<Color> tagColors = [
    Color(0xFFE57373), // Red
    Color(0xFF81C784), // Green
    Color(0xFF64B5F6), // Blue
    Color(0xFFFFD54F), // Yellow
    Color(0xFFBA68C8), // Purple
    Color(0xFFFF8A65), // Orange
    Color(0xFF4DB6AC), // Teal
    Color(0xFFA1887F), // Brown
  ];
}