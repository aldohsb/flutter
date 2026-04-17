import 'package:flutter/material.dart';

abstract class AppColors {
  // abstract class sebagai namespace konstanta warna
  // Tidak bisa di-instantiate — hanya diakses statik: AppColors.primary

  static const Color primary      = Color(0xFFFF6B35);
  // Oranye-merah hangat — khas warna app makanan (menggugah selera)

  static const Color primaryDark  = Color(0xFFE55A25);
  // Varian lebih gelap dari primary — untuk pressed state

  static const Color primaryLight = Color(0xFFFF8C5A);
  // Varian lebih terang — untuk badge, highlight

  static const Color secondary    = Color(0xFF2EC4B6);
  // Teal — kontras dengan oranye, untuk elemen aksen

  static const Color backgroundLight = Color(0xFFF8F6F3);
  // Background utama: krem sangat pucat — lebih hangat dari putih murni

  static const Color backgroundCard  = Color(0xFFFFFFFF);
  // Background card: putih bersih

  static const Color backgroundChip  = Color(0xFFF0EDE8);
  // Background chip kategori: lebih gelap sedikit dari background

  static const Color textPrimary   = Color(0xFF1A1A1A);
  // Teks utama: hampir hitam, lebih lembut dari hitam murni (0xFF000000)

  static const Color textSecondary = Color(0xFF6B6B6B);
  // Teks sekunder: abu-abu medium

  static const Color textMuted     = Color(0xFFAAAAAA);
  // Teks redup: abu-abu terang

  static const Color ratingYellow  = Color(0xFFFFB800);
  // Kuning bintang rating — warna standar rating di seluruh industri

  static const Color unavailable   = Color(0xFFDDDDDD);
  // Warna abu-abu untuk item yang tidak tersedia (habis)

  static const Color divider       = Color(0xFFEEECE8);
  // Garis pemisah: sangat tipis dan terang

  static Color shadowCard = Colors.black.withValues(alpha: 0.08);
  // Shadow card: hitam sangat transparan — efek bayangan lembut
  // Tidak bisa const karena withValues() adalah method runtime

  static Color primaryGlow = primary.withValues(alpha: 0.2);
  // Efek cahaya oranye untuk shadow tombol/badge
}