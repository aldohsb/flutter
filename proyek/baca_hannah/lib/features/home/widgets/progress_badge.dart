// lib/features/home/widgets/progress_badge.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';

class ProgressBadge extends StatelessWidget {
  final int completedChapters;
  final int totalChapters;

  const ProgressBadge({
    super.key,
    required this.completedChapters,
    required this.totalChapters,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        totalChapters > 0 ? completedChapters / totalChapters : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text('🏆', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 14),
          // Teks & progress bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progres Belajar',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$completedChapters dari $totalChapters bab selesai',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.starEmpty,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '${(progress * 100).round()}%',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}