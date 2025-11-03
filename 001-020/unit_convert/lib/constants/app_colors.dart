// File ini berisi definisi warna yang digunakan di seluruh aplikasi
// Dengan menaruh warna di satu tempat, kita mudah mengubah tema nanti

import 'package:flutter/material.dart';

class AppColors {
  // Constructor private - artinya class ini tidak bisa di-instantiate
  // Kita hanya pakai sebagai tempat menyimpan konstanta
  AppColors._();

  // Warna utama aplikasi - digunakan untuk elemen penting
  static const Color primary = Color(0xFF6C5CE7); // Ungu modern
  static const Color primaryDark = Color(0xFF5848C2); // Ungu lebih gelap
  static const Color primaryLight = Color(0xFF8B7FF4); // Ungu lebih terang

  // Warna accent - untuk highlight dan button penting
  static const Color accent = Color(0xFFFF6B9D); // Pink cerah

  // Warna background
  static const Color background = Color(0xFFF8F9FA); // Abu-abu sangat terang
  static const Color surface = Color(0xFFFFFFFF); // Putih untuk card
  static const Color surfaceDark = Color(0xFF2D3436); // Gelap untuk dark mode

  // Warna teks
  static const Color textPrimary = Color(0xFF2D3436); // Hitam keabuan
  static const Color textSecondary = Color(0xFF636E72); // Abu-abu
  static const Color textLight = Color(0xFFB2BEC3); // Abu-abu terang

  // Warna untuk number pad button
  static const Color numberButton = Color(0xFFFFFFFF); // Putih
  static const Color operatorButton = Color(0xFFF1F3F5); // Abu sangat terang

  // Warna status
  static const Color success = Color(0xFF00B894); // Hijau
  static const Color error = Color(0xFFFF7675); // Merah
  static const Color warning = Color(0xFFFDCB6E); // Kuning

  // Warna untuk kategori converter (optional - bisa dipakai untuk icon)
  static const Color lengthColor = Color(0xFF74B9FF); // Biru
  static const Color weightColor = Color(0xFFA29BFE); // Ungu muda
  static const Color temperatureColor = Color(0xFFFF7675); // Merah
  static const Color currencyColor = Color(0xFF55EFC4); // Hijau mint

  // Gradients - untuk efek visual yang lebih menarik
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, Color(0xFFFF8FB9)],
  );
}