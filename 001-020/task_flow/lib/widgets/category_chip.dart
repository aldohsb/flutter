// Widget untuk menampilkan chip kategori task
// Chip = widget kecil berbentuk pill/kapsul untuk menampilkan info singkat

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CategoryChip extends StatelessWidget {
  final String category;     // Nama kategori
  final bool isSelected;     // Apakah chip ini sedang dipilih/aktif
  final VoidCallback? onTap; // Callback saat chip diklik
  // VoidCallback = fungsi yang tidak return apa-apa

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil warna kategori
    final color = AppConstants.categoryColors[category] ?? Colors.grey;

    return GestureDetector(
      // GestureDetector = widget untuk mendeteksi gesture (tap, swipe, dll)
      onTap: onTap, // Panggil callback saat diklik
      child: Container(
        // Padding dalam chip
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          // Warna background tergantung status selected
          color: isSelected
              ? color                    // Jika selected: warna solid
              : color.withOpacity(0.1),  // Jika tidak: warna pudar
          borderRadius: BorderRadius.circular(20), // Sudut sangat membulat (pill shape)
          // Border hanya tampil jika tidak selected
          border: isSelected
              ? null                     // Tidak ada border
              : Border.all(
                  color: color.withOpacity(0.5),
                  width: 1.5,
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon kategori
            Icon(
              _getCategoryIcon(category), // Fungsi helper untuk ambil icon
              size: 16,
              // Warna icon tergantung status selected
              color: isSelected
                  ? Colors.white       // Jika selected: putih
                  : color,             // Jika tidak: warna kategori
            ),
            const SizedBox(width: 6),
            // Text kategori
            Text(
              category,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                // Warna text sama seperti icon
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function untuk mendapatkan icon sesuai kategori
  IconData _getCategoryIcon(String category) {
    // Switch statement = pemilihan berdasarkan value
    switch (category) {
      case 'Work':
        return Icons.work_outline;       // Icon tas kerja
      case 'Personal':
        return Icons.person_outline;     // Icon orang
      case 'Shopping':
        return Icons.shopping_cart_outlined; // Icon keranjang
      case 'Health':
        return Icons.favorite_outline;   // Icon hati
      case 'Study':
        return Icons.school_outlined;    // Icon sekolah
      case 'Other':
        return Icons.more_horiz;         // Icon titik-titik
      case 'All':
        return Icons.apps;               // Icon grid (untuk "All")
      default:
        return Icons.label_outline;      // Icon label default
    }
  }
}