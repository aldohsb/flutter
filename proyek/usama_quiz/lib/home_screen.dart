import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';
import 'category_screen.dart';
import 'gradient_scaffold_background.dart';
import 'progress_service.dart';
import 'quiz_category.dart';

/// Layar pertama yang dilihat pengguna: sambutan bergaya taman zen
/// dengan ringkasan progres singkat dan tombol untuk mulai belajar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressService = context.watch<ProgressService>();

    final totalStars = QuizCategory.values.fold<int>(
      0,
      (sum, category) => sum + progressService.totalStars(category),
    );
    const maxStars = kLevelsPerCategory * 3 * 3;

    return Scaffold(
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Container(
                  width: 108,
                  height: 108,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.sage.withValues(alpha: 0.14),
                    border: Border.all(color: AppColors.sage.withValues(alpha: 0.4), width: 2),
                  ),
                  child: Text('学', style: AppTheme.jpTextStyle(fontSize: 52, color: AppColors.sageDeep)),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Usama Quiz',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Belajar Hiragana, Katakana, dan Kanji\ndengan tenang, selangkah demi selangkah.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.inkSoft, height: 1.5),
                ),
                const SizedBox(height: AppSpacing.xxl),
                if (progressService.isLoaded && totalStars > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.starFilled, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '$totalStars dari $maxStars bintang terkumpul',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.inkFaint,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CategoryScreen()),
                      );
                    },
                    child: const Text('Mulai Belajar'),
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
