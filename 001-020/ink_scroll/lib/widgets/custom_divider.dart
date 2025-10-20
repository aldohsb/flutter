// File: lib/widgets/custom_divider.dart
// Penjelasan: Custom divider untuk pemisah antar quote
// Ini akan digunakan bersama ListView.separated
// Divider adalah garis pemisah antar item dalam list

import 'package:flutter/material.dart';
import '../utils/theme_utils.dart';

/// Widget CustomDivider adalah pemisah custom antara item di ListView
/// StatelessWidget berarti widget ini tidak punya state yang berubah-ubah
class CustomDivider extends StatelessWidget {
  /// Constructor
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Untuk custom divider, kita gunakan Column untuk stacking vertikal
    return Column(
      children: [
        // Padding vertikal untuk spacing di atas
        SizedBox(height: AppTheme.spacingMedium),

        // === GARIS DIVIDER UTAMA ===
        // Horizontal divider dengan custom style
        Container(
          // Width mengisi parent horizontally
          width: double.infinity,
          // Tinggi garis divider
          height: 1.0,
          // Warna divider dengan opacity untuk subtle effect
          color: AppTheme.dividerColor.withOpacity(AppTheme.dividerOpacity),
        ),

        // === AKSEN BRUSH STROKE DI BAWAH GARIS ===
        // Ini untuk menambah efek Japanese minimalism
        Padding(
          // Padding dari kiri untuk positioning artistik
          padding: const EdgeInsets.only(left: AppTheme.spacingLarge),
          child: Container(
            // Lebar aksen stroke (lebih pendek dari garis utama)
            width: 40.0,
            // Tinggi aksen stroke
            height: 0.8,
            // Margin atas untuk spacing dari garis utama
            margin: const EdgeInsets.only(top: 6.0),
            // Warna aksen (dari AppTheme)
            color: AppTheme.accentColor.withOpacity(0.3),
          ),
        ),

        // Padding vertikal untuk spacing di bawah
        SizedBox(height: AppTheme.spacingMedium),
      ],
    );
  }

  /// Static method untuk membuat divider dengan custom height
  /// Berguna jika kita ingin membuat beberapa varian divider
  static Widget createWithHeight({required double height}) {
    return Column(
      children: [
        SizedBox(height: height / 2),
        Container(
          width: double.infinity,
          height: 1.0,
          color: AppTheme.dividerColor.withOpacity(AppTheme.dividerOpacity),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppTheme.spacingLarge),
          child: Container(
            width: 40.0,
            height: 0.8,
            margin: const EdgeInsets.only(top: 6.0),
            color: AppTheme.accentColor.withOpacity(0.3),
          ),
        ),
        SizedBox(height: height / 2),
      ],
    );
  }
}