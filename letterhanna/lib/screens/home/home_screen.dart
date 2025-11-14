import 'package:flutter/material.dart';
// Import constants yang sudah kita buat
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
// Import custom widget
import '../../widgets/common/custom_button.dart';

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
              // Menggunakan headlineMedium dari theme
              Text(
                AppStrings.welcomeMessage,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // === TAGLINE ===
              // Menggunakan titleLarge dari theme
              Text(
                AppStrings.appTagline,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              // === DESCRIPTION ===
              // Menggunakan bodyMedium dari theme
              Text(
                AppStrings.appDescription,
                style: Theme.of(context).textTheme.bodyMedium,
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
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textOnDark,
                      letterSpacing: 1.2,
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
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
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