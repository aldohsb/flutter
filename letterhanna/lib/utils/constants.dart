// ============================================================================
// CONSTANTS - Nilai-nilai yang tidak berubah (static) di seluruh aplikasi
// ============================================================================
// Penjelasan: Constants adalah nilai yang sama digunakan di banyak file
// Dengan memusatkan di satu file, perubahan menjadi mudah (DRY principle)
// Don't Repeat Yourself = tulis sekali, gunakan di mana-mana

import 'package:flutter/material.dart';

// ============================================================================
// SECTION: WARNA (Colors)
// ============================================================================
// Format color di Flutter: 0xFFRRGGBB
// FF = opacity penuh (255), RR/GG/BB = Red/Green/Blue value (0-255 dalam hex)
// Contoh: 0xFF2C2C2C = coklat tua yang elegant

class AppColors {
  // Class untuk mengelompokkan semua color constants
  // Menggunakan class static lebih organized daripada variable biasa
  
  // ===== PRIMARY COLORS =====
  // Warna utama yang merepresentasikan brand Letterhanna
  
  static const Color primaryDark = Color(0xFF2C2C2C);
  // primaryDark: warna coklat tua (brand color utama)
  // Digunakan untuk: text utama, button, icon penting
  
  static const Color primaryBrown = Color(0xFF8B7355);
  // primaryBrown: warna coklat medium (accent)
  // Digunakan untuk: highlight, border accent
  
  static const Color primaryCream = Color(0xFFFAF9F7);
  // primaryCream: warna cream/beige (background utama)
  // Digunakan untuk: background halaman, card background
  
  static const Color accentBeige = Color(0xFFE8D5C4);
  // accentBeige: warna beige (untuk hero banner, accent elements)
  
  // ===== SECONDARY COLORS =====
  // Warna pendukung untuk UI elements
  
  static const Color successGreen = Color(0xFF27AE60);
  // successGreen: warna hijau (untuk status sukses, valid)
  
  static const Color errorRed = Color(0xFFE74C3C);
  // errorRed: warna merah (untuk error, warning)
  
  static const Color warningOrange = Color(0xFFF39C12);
  // warningOrange: warna orange (untuk warning message)
  
  static const Color infoBlue = Color(0xFF3498DB);
  // infoBlue: warna biru (untuk info message)
  
  // ===== NEUTRAL COLORS =====
  // Warna abu-abu untuk text, borders, backgrounds
  
  static const Color textDark = Color(0xFF333333);
  // textDark: untuk body text / main text
  
  static const Color textMedium = Color(0xFF666666);
  // textMedium: untuk secondary text, helper text
  
  static const Color textLight = Color(0xFF999999);
  // textLight: untuk disabled text, muted text
  
  static const Color borderGray = Color(0xFFEEEEEE);
  // borderGray: untuk border lines, dividers
  
  static const Color backgroundGray = Color(0xFFF5F5F5);
  // backgroundGray: untuk light background, input field background
}

// ============================================================================
// SECTION: PADDING & SPACING
// ============================================================================
// Penjelasan: Define common spacing values
// Material Design recommend menggunakan 4-point grid system
// 4, 8, 12, 16, 24, 32, 48, 64... dst

class AppSpacing {
  // Class untuk mengelompokkan spacing constants
  
  // ===== BASIC SPACING =====
  static const double xs = 4.0;
  // xs (extra small): 4 points
  
  static const double sm = 8.0;
  // sm (small): 8 points
  
  static const double md = 12.0;
  // md (medium): 12 points
  
  static const double lg = 16.0;
  // lg (large): 16 points - MOST COMMON
  
  static const double xl = 24.0;
  // xl (extra large): 24 points
  
  static const double xxl = 32.0;
  // xxl (extra extra large): 32 points
  
  static const double xxxl = 48.0;
  // xxxl: 48 points
}

// ============================================================================
// SECTION: BORDER RADIUS
// ============================================================================
// Penjelasan: Define common border radius values
// Cocok untuk Container, Card, Button, TextField, dll

class AppBorderRadius {
  // Class untuk mengelompokkan border radius constants
  
  static const double sm = 4.0;
  // sm: 4 - untuk small elements (chips, small buttons)
  
  static const double md = 8.0;
  // md: 8 - untuk medium elements (card minimal)
  
  static const double lg = 12.0;
  // lg: 12 - untuk large elements (card standard, dialog)
  
  static const double xl = 16.0;
  // xl: 16 - untuk extra large elements (banner)
  
  static const double circle = 999.0;
  // circle: 999 - membuat lingkaran (untuk avatar)
}

// ============================================================================
// SECTION: FONT SIZES
// ============================================================================
// Penjelasan: Typography hierarchy untuk consistent text sizing
// Small: 12, Body: 14, Subheading: 16, Heading: 20, 24, 28, 32

class AppFontSizes {
  // Class untuk mengelompokkan font size constants
  
  static const double caption = 12.0;
  // caption: 12 - untuk very small text (image caption, hint)
  
  static const double body = 14.0;
  // body: 14 - untuk main paragraph text (paling sering digunakan)
  
  static const double subheading = 16.0;
  // subheading: 16 - untuk section title, list item title
  
  static const double heading3 = 20.0;
  // heading3: 20 - untuk medium heading
  
  static const double heading2 = 24.0;
  // heading2: 24 - untuk large heading
  
  static const double heading1 = 28.0;
  // heading1: 28 - untuk page title / display
  
  static const double display = 32.0;
  // display: 32 - untuk very large title / hero text
}

// ============================================================================
// SECTION: SHADOWS
// ============================================================================
// Penjelasan: Define common shadow styles
// Shadow memberikan kedalaman dan hierarchy visual

class AppShadows {
  // Class untuk mengelompokkan shadow constants
  
  static const List<BoxShadow> sm = [
    // sm: shadow minimal (subtle)
    BoxShadow(
      color: Color(0x0D000000),
      // color: hitam dengan opacity 5% (very subtle)
      
      blurRadius: 2,
      // blurRadius: 2 - blur kecil
      
      offset: Offset(0, 1),
      // offset: posisi shadow 1 point ke bawah
    ),
  ];
  
  static const List<BoxShadow> md = [
    // md: shadow medium (noticeable)
    BoxShadow(
      color: Color(0x14000000),
      // color: hitam dengan opacity 8%
      
      blurRadius: 8,
      // blurRadius: 8 - blur medium
      
      offset: Offset(0, 2),
      // offset: 2 points ke bawah
    ),
  ];
  
  static const List<BoxShadow> lg = [
    // lg: shadow besar (prominent)
    BoxShadow(
      color: Color(0x19000000),
      // color: hitam dengan opacity 10%
      
      blurRadius: 16,
      // blurRadius: 16 - blur besar
      
      offset: Offset(0, 4),
      // offset: 4 points ke bawah
    ),
  ];
}

// ============================================================================
// SECTION: DURASI ANIMASI
// ============================================================================
// Penjelasan: Define animation duration yang konsisten
// Untuk: transition, fade, scale, slide animations

class AppDurations {
  // Class untuk mengelompokkan duration constants
  
  static const Duration quick = Duration(milliseconds: 150);
  // quick: 150ms - untuk quick feedback (hover, tap)
  
  static const Duration short = Duration(milliseconds: 250);
  // short: 250ms - untuk transition default
  
  static const Duration medium = Duration(milliseconds: 500);
  // medium: 500ms - untuk medium animation
  
  static const Duration long = Duration(milliseconds: 800);
  // long: 800ms - untuk longer, noticeable animation
}

// ============================================================================
// SECTION: URLS & API ENDPOINTS
// ============================================================================
// Penjelasan: Define API base URLs dan endpoints
// Akan digunakan di hari-hari mendatang untuk HTTP requests
// CATATAN: Ini adalah dummy untuk sekarang, akan di-update saat ada real backend

class AppUrls {
  // Base URL untuk API (akan diubah sesuai environment)
  static const String baseUrl = 'https://api.letterhanna.com';
  // CATATAN HARI 1: Ini hanya placeholder, nantinya akan di-update
  
  // Endpoints
  static const String productsEndpoint = '/api/products';
  static const String categoriesEndpoint = '/api/categories';
  static const String userEndpoint = '/api/user';
  static const String ordersEndpoint = '/api/orders';
  static const String cartEndpoint = '/api/cart';
  static const String paymentEndpoint = '/api/payment';
}

// ============================================================================
// SECTION: ASSET PATHS
// ============================================================================
// Penjelasan: Define paths untuk images, icons, fonts yang disimpan di assets
// Will be used di: Image.asset(), Icon(), custom fonts
// CATATAN: Assets belum ada di Hari 1, placeholder untuk future

class AppAssets {
  // Base path untuk semua assets
  static const String baseImagePath = 'assets/images';
  // Paths untuk images
  
  static const String baseIconPath = 'assets/icons';
  // Paths untuk custom icons (jika ada SVG/PNG custom)
  
  // Contoh image paths (akan ditambah saat assets tersedia)
  static const String logoImage = '$baseImagePath/logo.png';
  static const String emptyStateImage = '$baseImagePath/empty_state.png';
}

// ============================================================================
// SECTION: APP CONFIG
// ============================================================================
// Penjelasan: General app configuration constants

class AppConfig {
  // App metadata
  static const String appName = 'Letterhanna';
  static const String appVersion = '1.0.0';
  static const String appAuthor = 'Letterhanna Team';
  
  // Default page size untuk pagination
  static const int defaultPageSize = 20;
  // Biasanya untuk API responses, load 20 items per page
  
  // Timeout untuk API requests
  static const Duration apiTimeout = Duration(seconds: 30);
  // Jika request > 30 detik, dianggap timeout
  
  // Max retry untuk failed requests
  static const int maxRetries = 3;
  // Coba ulang maksimal 3 kali jika request gagal
}

// ============================================================================
// CATATAN UNTUK HARI SELANJUTNYA:
// ============================================================================
// ✅ Struktur constants sudah comprehensive
// ❌ Yang perlu ditambahkan kemudian:
// 1. Hari 2: Custom TextStyle definitions
// 2. Hari 3: Theme mode constants (light/dark)
// 3. Hari 5: Firebase constants
// 4. Hari 8: Payment gateway constants
// 5. Hari 10: Payment & shipping methods
//
// BEST PRACTICE:
// - Selalu gunakan constants, jangan hardcode nilai di widget
// - Jika nilai diubah, hanya perlu ubah di satu tempat
// - Memudahkan rebranding atau theming di masa depan
// ============================================================================