import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Class untuk mendefinisikan semua text styles di aplikasi
/// Menggunakan typography yang sesuai dengan tema Synthwave/Retrowave
class AppTextStyles {
  // Private constructor
  const AppTextStyles._();

  // === NEON TEXT STYLES ===
  
  /// Style untuk text greeting utama dengan efek neon glow
  /// 
  /// Menggunakan multiple shadows untuk menciptakan efek neon yang realistis
  /// Layer 1: Glow besar dan soft (blur 40)
  /// Layer 2: Glow medium (blur 20)
  /// Layer 3: Glow kecil dan tajam (blur 10)
  static TextStyle neonHeading = TextStyle(
    // fontSize dalam logical pixels
    fontSize: 72,
    
    // fontWeight: ketebalan font (w100-w900)
    // FontWeight.bold = w700
    fontWeight: FontWeight.bold,
    
    // color: warna dasar text
    color: AppColors.textPrimary,
    
    // letterSpacing: jarak antar huruf
    // Nilai positif membuat huruf lebih renggang (cocok untuk judul besar)
    letterSpacing: 4.0,
    
    // height: line height multiplier
    // 1.2 = 120% dari fontSize
    height: 1.2,
    
    // shadows: array of Shadow objects untuk efek glow
    shadows: [
      // Shadow pertama: Outer glow yang besar dan soft
      Shadow(
        // color: warna shadow dengan opacity
        color: AppColors.neonPink.withOpacity(0.8),
        // blurRadius: seberapa blur/soft shadow-nya
        blurRadius: 40,
        // offset: posisi shadow relatif terhadap text (x, y)
        // Offset.zero = tepat di belakang text
        offset: Offset.zero,
      ),
      
      // Shadow kedua: Middle glow
      Shadow(
        color: AppColors.neonPurple.withOpacity(0.6),
        blurRadius: 20,
        offset: Offset.zero,
      ),
      
      // Shadow ketiga: Inner glow yang tajam
      Shadow(
        color: AppColors.neonCyan.withOpacity(0.4),
        blurRadius: 10,
        offset: Offset.zero,
      ),
    ],
  );

  /// Style untuk subheading dengan efek neon lebih subtle
  static TextStyle neonSubheading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
    height: 1.3,
    
    // Efek glow lebih subtle untuk hierarchy visual
    shadows: [
      Shadow(
        color: AppColors.neonPurple.withOpacity(0.6),
        blurRadius: 30,
        offset: Offset.zero,
      ),
      Shadow(
        color: AppColors.neonPink.withOpacity(0.4),
        blurRadius: 15,
        offset: Offset.zero,
      ),
    ],
  );

  /// Style untuk body text dengan sedikit glow
  static TextStyle neonBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 1.0,
    height: 1.5,
    
    // Glow minimal untuk readability
    shadows: [
      Shadow(
        color: AppColors.neonCyan.withOpacity(0.3),
        blurRadius: 8,
        offset: Offset.zero,
      ),
    ],
  );
}