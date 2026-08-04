import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_stories_rounded,
                    size: 90, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(AppConstants.appName, style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(
                  'Belajar membaca jadi menyenangkan',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.push('/levels'),
                  child: const Text('Belajar Membaca'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => context.push('/hijaiyah-levels'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    textStyle: AppTextStyles.heading,
                  ),
                  child: const Text('Belajar Huruf Hijaiyah'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}