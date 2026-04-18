import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';

class TabPlaceholder extends StatelessWidget {
  // Widget reusable yang dipakai oleh keempat tab
  // Setiap tab menampilkan ikon, judul, dan deskripsi yang berbeda
  // Ini mensimulasikan konten tab sebelum diisi dengan UI sungguhan

  final IconData icon;
  final String title;
  final String description;
  final Color? accentColor;
  // accentColor opsional — jika tidak diisi, pakai AppColors.primary

  const TabPlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = accentColor ?? AppColors.primary;
    // Tentukan warna aksen yang dipakai: parameter atau fallback ke primary

    return Center(
      // Center: posisikan seluruh konten di tengah layar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // center secara vertikal dalam Column
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.1),
              // Background lingkaran sangat transparan (10%) — hint warna aksen
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(icon, size: 44, color: color),
          ),

          const SizedBox(height: 28),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          // Judul tab — nama tab yang sedang aktif

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            // Padding horizontal agar teks deskripsi tidak terlalu lebar
            child: Text(
              description,
              textAlign: TextAlign.center,
              // TextAlign.center — teks multi-baris rata tengah
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // min: Row hanya selebar kontennya, tidak melebar penuh
              children: [
                Icon(Icons.construction_rounded, size: 14, color: color),
                const SizedBox(width: 8),
                Text(
                  'Under Construction',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}