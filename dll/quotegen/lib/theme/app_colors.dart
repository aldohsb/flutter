// app_colors.dart
// File ini adalah "sumber kebenaran tunggal" (single source of truth) untuk semua warna di app.
// Kenapa dipisah? Supaya kalau nanti mau ganti brand color, cukup edit 1 file ini saja.

import 'package:flutter/material.dart'; // dibutuhkan untuk tipe data Color

class AppColors {
  // constructor private supaya class ini tidak bisa di-instantiate (hanya dipakai sebagai namespace statis)
  AppColors._();

  // warna dasar background gelap, memberi kesan "malam hening membaca kutipan"
  // sengaja pilih dark theme sebagai identitas unik Quotegen, bukan default putih standar
  static const Color background = Color(0xFF12121C); // ungu-hitam sangat gelap

  // warna permukaan Card, sedikit lebih terang dari background agar ada depth/layer
  static const Color surface = Color(0xFF1E1E2E);

  // warna aksen utama, dipakai untuk tombol & highlight — kuning keemasan kesan "quote berharga"
  static const Color accent = Color(0xFFF5C24C);

  // warna aksen sekunder untuk elemen pendukung seperti ikon info
  static const Color accentSoft = Color(0xFF8A7FFF); // ungu lembut sebagai kontras aksen utama

  // warna teks utama (kutipan), putih hampir penuh tapi tidak 100% agar tidak terlalu tajam di mata
  static const Color textPrimary = Color(0xFFF4F4F8);

  // warna teks sekunder (nama author), lebih redup dari teks utama
  static const Color textSecondary = Color(0xFFA0A0B8);

  // warna border tipis di sekitar Card, memberi kesan "kartu premium"
  static const Color cardBorder = Color(0xFF33334A);
}