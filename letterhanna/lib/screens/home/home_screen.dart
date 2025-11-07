import 'package:flutter/material.dart';
// Import constants yang sudah kita buat
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';

// HomeScreen adalah halaman utama aplikasi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan warna dari AppColors
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnDark,
        elevation: 0,
      ),
      
      // backgroundColor menggunakan warna dari AppColors
      backgroundColor: AppColors.background,
      
      body: Center(
        child: Padding(
          // Padding untuk memberi jarak dari tepi layar
          // EdgeInsets.all(24) = padding 24px di semua sisi
          padding: const EdgeInsets.all(24),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // === ICON SECTION ===
              Icon(
                Icons.font_download,
                size: 100,
                color: AppColors.primary,
              ),
              
              const SizedBox(height: 32),
              
              // === WELCOME MESSAGE ===
              Text(
                AppStrings.welcomeMessage,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // === TAGLINE ===
              Text(
                AppStrings.appTagline,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              // === DESCRIPTION ===
              Text(
                AppStrings.appDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textHint,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // === EXPLORE BUTTON ===
              // GestureDetector mendeteksi tap/click pada child-nya
              GestureDetector(
                // onTap dipanggil saat user tap tombol
                onTap: () {
                  // Navigator.pushNamed untuk pindah ke halaman lain
                  // context adalah BuildContext yang perlu untuk navigasi
                  // AppRoutes.catalog adalah route tujuan ('/catalog')
                  Navigator.pushNamed(context, AppRoutes.catalog);
                },
                
                child: Container(
                  // Padding dalam tombol
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 18,
                  ),
                  
                  decoration: BoxDecoration(
                    // Warna background tombol (gradient)
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primaryLight,
                      ],
                    ),
                    // Border radius untuk sudut melengkung
                    borderRadius: BorderRadius.circular(30),
                    // Box shadow untuk efek 3D
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  
                  child: Text(
                    AppStrings.exploreButton,
                    style: TextStyle(
                      color: AppColors.textOnDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2, // Jarak antar huruf
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // === BROWSE COLLECTION BUTTON (Secondary) ===
              GestureDetector(
                onTap: () {
                  // Sama seperti explore button, pindah ke catalog
                  Navigator.pushNamed(context, AppRoutes.catalog);
                },
                
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 18,
                  ),
                  
                  decoration: BoxDecoration(
                    // Border saja tanpa fill (outline button)
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  
                  child: Text(
                    AppStrings.browseCollection,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}