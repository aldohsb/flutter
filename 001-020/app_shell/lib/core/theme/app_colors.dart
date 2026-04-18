import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary       = Color(0xFF7C4DFF);
  // Ungu-violet cerah — warna yang kuat dan mudah dikenali sebagai aksen navigasi

  static const Color primaryDark   = Color(0xFF6200EA);
  // Varian lebih gelap — untuk pressed state dan gradient

  static const Color primaryLight  = Color(0xFFB388FF);
  // Varian lebih terang — untuk indikator aktif yang lebih lembut

  static const Color secondary     = Color(0xFF00BCD4);
  // Cyan — warna FAB, kontras kuat dengan ungu

  static const Color backgroundDark    = Color(0xFF0D0D1A);
  // Background halaman gelap — navy sangat dalam

  static const Color backgroundCard    = Color(0xFF1A1A2E);
  // Background card dan container

  static const Color backgroundSurface = Color(0xFF16213E);
  // Surface untuk elemen yang sedikit terangkat

  static const Color navBackground  = Color(0xFF12122A);
  // Background khusus NavigationBar — sedikit lebih gelap dari card

  static const Color textPrimary   = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0D0);
  static const Color textMuted     = Color(0xFF6B6B9A);

  static const Color divider       = Color(0xFF2A2A4A);
  static const Color border        = Color(0xFF333360);

  static Color primaryGlow  = primary.withValues(alpha: 0.35);
  static Color shadowDark   = Colors.black.withValues(alpha: 0.4);
  static Color secondaryGlow = secondary.withValues(alpha: 0.4);
}