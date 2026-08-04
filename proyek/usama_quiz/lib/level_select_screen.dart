import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'character_list_screen.dart';
import 'gradient_scaffold_background.dart';
import 'level_tile.dart';
import 'progress_service.dart';
import 'quiz_category.dart';
import 'quiz_screen.dart';
import 'section_header.dart';

/// Menampilkan grid 50 level untuk kategori yang dipilih. Semua level
/// terbuka bebas; tile menunjukkan skor terbaik lewat bintang.
class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key, required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    final progressService = context.watch<ProgressService>();
    final completed = progressService.completedLevels(category);
    final stars = progressService.totalStars(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.displayName),
        actions: [
          IconButton(
            tooltip: 'Daftar Aksara',
            icon: const Icon(Icons.menu_book_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CharacterListScreen(category: category)),
              );
            },
          ),
        ],
      ),
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Pilih Level',
                  subtitle: '$completed/${kLevelsPerCategory} level selesai • $stars bintang',
                ),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: GridView.builder(
                    itemCount: kLevelsPerCategory,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final level = index + 1;
                      final progress = progressService.progressFor(category, level);
                      return LevelTile(
                        level: level,
                        progress: progress,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => QuizScreen(category: category, level: level),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Dipakai jika ingin memberi warna latar berbeda per kategori di masa
/// depan tanpa mengubah struktur widget di atas.
extension CategoryAccent on QuizCategory {
  Color get accentColor => AppColors.sage;
}