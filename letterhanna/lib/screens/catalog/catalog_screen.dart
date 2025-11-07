import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

// CatalogScreen menampilkan daftar font (nanti hari ke-6 kita isi dengan grid)
// Untuk hari ini kita buat placeholder dulu
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.catalogTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnDark,
        elevation: 0,
        
        // leading adalah widget di kiri title (biasanya back button)
        // Flutter otomatis kasih back button jika ada route sebelumnya
        // Tapi kita customize warnanya supaya sesuai theme
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop() untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      
      backgroundColor: AppColors.background,
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon untuk placeholder
            Icon(
              Icons.grid_view,
              size: 80,
              color: AppColors.textHint,
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Font Catalog',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Padding untuk text supaya tidak terlalu lebar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Grid layout dengan daftar font akan muncul di sini pada Hari ke-6',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Tombol kembali (optional, karena sudah ada back button di AppBar)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              
              // style tombol menggunakan ElevatedButton.styleFrom
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}