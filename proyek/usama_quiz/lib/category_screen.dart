import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';
import 'gradient_scaffold_background.dart';
import 'level_select_screen.dart';
import 'progress_service.dart';
import 'quiz_category.dart';
import 'section_header.dart';

/// Layar untuk memilih kategori aksara yang ingin dipelajari. Menampilkan
/// ringkasan progres (level selesai & bintang) untuk masing-masing kategori.
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Kategori')),
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const SectionHeader(
                title: 'Kategori Belajar',
                subtitle: 'Setiap kategori memiliki 50 level dengan kesulitan meningkat bertahap.',
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final category in QuizCategory.values) ...[
                _CategoryCard(category: category),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    final progressService = context.watch<ProgressService>();
    final completed = progressService.completedLevels(category);
    final stars = progressService.totalStars(category);
    final ratio = progressService.categoryCompletionRatio(category).clamp(0.0, 1.0);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => LevelSelectScreen(category: category)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.sagePale,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  category.sampleGlyph,
                  style: AppTheme.jpTextStyle(fontSize: 30, color: AppColors.sageDeep),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.displayName,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.ink),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.subtitle,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: ratio,
                        minHeight: 6,
                        backgroundColor: AppColors.stone,
                        valueColor: const AlwaysStoppedAnimation(AppColors.sage),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '$completed/$kLevelsPerCategory level',
                          style: const TextStyle(fontSize: 11.5, color: AppColors.inkFaint, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.starFilled),
                        const SizedBox(width: 2),
                        Text(
                          '$stars',
                          style: const TextStyle(fontSize: 11.5, color: AppColors.inkFaint, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
            ],
          ),
        ),
      ),
    );
  }
}
