import 'package:flutter/material.dart';

/// GridCalculator - Utility class untuk menghitung parameter grid dinamis
/// Class ini membantu menentukan jumlah kolom dan spacing berdasarkan lebar layar
/// Implementasi responsive design untuk berbagai ukuran device
class GridCalculator {
  // Private constructor untuk utility class
  GridCalculator._();

  // === BREAKPOINTS - Titik perubahan layout berdasarkan lebar layar ===
  
  /// Small device (phone portrait) - di bawah 600px
  static const double smallBreakpoint = 600;
  
  /// Medium device (tablet portrait, phone landscape) - 600-900px
  static const double mediumBreakpoint = 900;
  
  /// Large device (tablet landscape, desktop) - di atas 900px
  static const double largeBreakpoint = 1200;

  // === COLUMN COUNTS - Jumlah kolom per breakpoint ===
  
  /// Jumlah kolom untuk small devices (2 kolom)
  static const int smallColumns = 2;
  
  /// Jumlah kolom untuk medium devices (3 kolom)
  static const int mediumColumns = 3;
  
  /// Jumlah kolom untuk large devices (4 kolom)
  static const int largeColumns = 4;
  
  /// Jumlah kolom untuk extra large devices (5 kolom)
  static const int extraLargeColumns = 5;

  // === SPACING VALUES ===
  
  /// Spacing kecil untuk small devices (8px)
  static const double smallSpacing = 8.0;
  
  /// Spacing sedang untuk medium devices (12px)
  static const double mediumSpacing = 12.0;
  
  /// Spacing besar untuk large devices (16px)
  static const double largeSpacing = 16.0;

  // === PADDING VALUES ===
  
  /// Padding horizontal untuk container grid
  static const double horizontalPadding = 16.0;
  
  /// Padding vertical untuk container grid
  static const double verticalPadding = 16.0;

  /// Calculate crossAxisCount - Menghitung jumlah kolom berdasarkan lebar layar
  /// 
  /// Parameter:
  /// - [context]: BuildContext untuk mengakses MediaQuery
  /// 
  /// Returns: int - Jumlah kolom yang sesuai untuk lebar layar saat ini
  /// 
  /// Logika:
  /// - < 600px: 2 kolom (phone portrait)
  /// - 600-900px: 3 kolom (tablet portrait, phone landscape)
  /// - 900-1200px: 4 kolom (tablet landscape)
  /// - > 1200px: 5 kolom (desktop)
  static int calculateCrossAxisCount(BuildContext context) {
    // Dapatkan lebar layar menggunakan MediaQuery
    // MediaQuery.of(context).size.width memberikan lebar total layar dalam pixels
    final double screenWidth = MediaQuery.of(context).size.width;

    // Conditional logic berdasarkan breakpoints
    if (screenWidth < smallBreakpoint) {
      // Small device - phone portrait
      return smallColumns;
    } else if (screenWidth < mediumBreakpoint) {
      // Medium device - tablet portrait atau phone landscape
      return mediumColumns;
    } else if (screenWidth < largeBreakpoint) {
      // Large device - tablet landscape
      return largeColumns;
    } else {
      // Extra large device - desktop
      return extraLargeColumns;
    }
  }

  /// Calculate spacing - Menghitung spacing antar item berdasarkan lebar layar
  /// 
  /// Parameter:
  /// - [context]: BuildContext untuk mengakses MediaQuery
  /// 
  /// Returns: double - Nilai spacing yang sesuai
  /// 
  /// Spacing yang lebih besar untuk layar yang lebih lebar
  /// memberikan breathing room yang lebih baik
  static double calculateSpacing(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < smallBreakpoint) {
      return smallSpacing;
    } else if (screenWidth < mediumBreakpoint) {
      return mediumSpacing;
    } else {
      return largeSpacing;
    }
  }

  /// Calculate child aspect ratio - Menghitung aspect ratio untuk grid items
  /// 
  /// Parameter:
  /// - [context]: BuildContext untuk mengakses MediaQuery
  /// 
  /// Returns: double - Aspect ratio (width/height)
  /// 
  /// Untuk aplikasi ini, kita gunakan ratio 1.0 (square) untuk semua device
  /// Ini memberikan tampilan yang konsisten dan Memphis-style yang geometric
  static double calculateChildAspectRatio(BuildContext context) {
    // Square ratio untuk semua ukuran layar
    // Bisa dimodifikasi berdasarkan kebutuhan design
    return 1.0;
  }

  /// Calculate item width - Menghitung lebar setiap item dalam grid
  /// 
  /// Parameter:
  /// - [context]: BuildContext untuk mengakses MediaQuery
  /// 
  /// Returns: double - Lebar item dalam pixels
  /// 
  /// Formula: (screenWidth - totalPadding - totalSpacing) / columnCount
  /// Berguna untuk perhitungan manual jika diperlukan
  static double calculateItemWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int columnCount = calculateCrossAxisCount(context);
    final double spacing = calculateSpacing(context);
    
    // Total padding horizontal (kiri + kanan)
    const double totalHorizontalPadding = horizontalPadding * 2;
    
    // Total spacing horizontal (spacing antar kolom)
    // Jumlah spacing = columnCount - 1
    final double totalSpacing = spacing * (columnCount - 1);
    
    // Hitung available width untuk items
    final double availableWidth = 
        screenWidth - totalHorizontalPadding - totalSpacing;
    
    // Bagi dengan jumlah kolom untuk dapat lebar per item
    return availableWidth / columnCount;
  }

  /// Get responsive padding - Mendapatkan EdgeInsets padding yang responsive
  /// 
  /// Parameter:
  /// - [context]: BuildContext untuk mengakses MediaQuery
  /// 
  /// Returns: EdgeInsets - Padding yang sesuai untuk ukuran layar
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final double spacing = calculateSpacing(context);
    
    // Padding menggunakan nilai spacing untuk konsistensi
    return EdgeInsets.all(spacing * 2);
  }

  /// Is small device - Helper method untuk cek apakah device small
  static bool isSmallDevice(BuildContext context) {
    return MediaQuery.of(context).size.width < smallBreakpoint;
  }

  /// Is medium device - Helper method untuk cek apakah device medium
  static bool isMediumDevice(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= smallBreakpoint && width < mediumBreakpoint;
  }

  /// Is large device - Helper method untuk cek apakah device large
  static bool isLargeDevice(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumBreakpoint;
  }
}