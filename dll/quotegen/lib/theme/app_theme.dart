// app_theme.dart
// File ini merakit ThemeData lengkap dari warna-warna di app_colors.dart.
// Kenapa perlu ThemeData terpusat? Supaya semua widget di app otomatis
// konsisten (font, warna, radius) tanpa perlu di-set manual di setiap widget.

import 'package:flutter/material.dart'; // untuk ThemeData, TextTheme, dll
import 'app_colors.dart'; // import palet warna yang sudah kita buat

class AppTheme {
  AppTheme._(); // constructor private, class ini hanya dipakai sebagai namespace statis

  // getter statis yang mengembalikan ThemeData siap pakai untuk MaterialApp
  static ThemeData get dark {
    return ThemeData(
      // useMaterial3 mengaktifkan sistem desain Material 3 (standar terbaru per 2026)
      useMaterial3: true,

      // brightness dark memberitahu Flutter bahwa ini adalah tema gelap
      brightness: Brightness.dark,

      // warna background utama Scaffold di seluruh app
      scaffoldBackgroundColor: AppColors.background,

      // colorScheme adalah cara modern Flutter mengatur warna secara semantik
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface, // warna permukaan komponen seperti Card, Dialog
        primary: AppColors.accent, // warna utama untuk tombol & elemen interaktif
        secondary: AppColors.accentSoft, // warna sekunder untuk aksen tambahan
        onSurface: AppColors.textPrimary, // warna teks di atas permukaan surface
      ),

      // konfigurasi default untuk semua widget Card di app (dipakai di Tahap 6)
      cardTheme: CardThemeData(
        color: AppColors.surface, // warna dasar card
        elevation: 0, // tanpa shadow default, kita akan pakai border custom sebagai gantinya
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // sudut membulat 20px, kesan modern & lembut
          side: const BorderSide(color: AppColors.cardBorder), // border tipis sesuai warna kita
        ),
      ),

      // konfigurasi default typography, memakai font sistem tapi dengan spacing custom
      textTheme: const TextTheme(
        // style untuk teks kutipan besar (dipakai nanti di QuoteDisplay)
        headlineSmall: TextStyle(
          fontSize: 26, // ukuran cukup besar agar kutipan mudah dibaca dari jarak layar
          fontWeight: FontWeight.w600, // semi-bold, memberi kesan tegas tapi tidak kaku
          color: AppColors.textPrimary, // pakai warna teks utama
          height: 1.4, // jarak antar baris lebih lega untuk keterbacaan kutipan panjang
        ),
        // style untuk teks nama author di bawah kutipan
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400, // regular weight, kontras dengan judul yang bold
          color: AppColors.textSecondary, // warna lebih redup karena ini info sekunder
        ),
      ),

      // konfigurasi default tombol elevated (dipakai di NewQuoteButton nanti)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent, // warna dasar tombol pakai warna aksen
          foregroundColor: AppColors.background, // warna teks/ikon di atas tombol (kontras gelap)
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16), // ruang dalam tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // bentuk pill/kapsul, kesan modern
          ),
        ),
      ),
    );
  }
}