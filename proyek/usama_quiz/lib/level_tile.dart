import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'level_progress.dart';
import 'star_rating.dart';

/// Kartu satu level di dalam grid pemilihan level. Semua level terbuka
/// bebas, sehingga tile ini hanya membedakan status "belum pernah
/// dikerjakan" vs "sudah pernah dikerjakan" lewat warna & bintang.
class LevelTile extends StatelessWidget {
  const LevelTile({
    super.key,
    required this.level,
    required this.progress,
    required this.onTap,
  });

  final int level;
  final LevelProgress progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress.isCompleted;

    return Material(
      color: isCompleted ? AppColors.sage.withValues(alpha: 0.14) : AppColors.sandSurface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: isCompleted
                  ? AppColors.sage.withValues(alpha: 0.55)
                  : AppColors.stone.withValues(alpha: 0.6),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$level',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isCompleted ? AppColors.sageDeep : AppColors.inkSoft,
                ),
              ),
              const SizedBox(height: 6),
              StarRating(stars: progress.stars, size: 11, spacing: 1),
            ],
          ),
        ),
      ),
    );
  }
}
