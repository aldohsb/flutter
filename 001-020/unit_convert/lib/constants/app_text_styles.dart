// File ini berisi style text yang konsisten di seluruh aplikasi
// Seperti menentukan font size, weight, color untuk berbagai keperluan

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Constructor private
  AppTextStyles._();

  // Heading - untuk judul besar
  static const TextStyle heading1 = TextStyle(
    fontSize: 32, // Ukuran font besar
    fontWeight: FontWeight.bold, // Tebal
    color: AppColors.textPrimary, // Warna dari AppColors
    letterSpacing: -0.5, // Jarak antar huruf sedikit rapat
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, // Semi-bold
    color: AppColors.textPrimary,
  );

  // Body text - untuk text normal
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5, // Line height - jarak antar baris
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Display - untuk angka di calculator/converter
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w300, // Light weight untuk angka besar
    color: AppColors.textPrimary,
    letterSpacing: -1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  // Number pad - untuk tombol angka di calculator
  static const TextStyle numberPad = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Caption - untuk text kecil/keterangan
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Label - untuk label input/button
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );
}