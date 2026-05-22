// lib/features/reading/widgets/page_indicator.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex; // 0-based
  final int totalPages;
  final Color activeColor;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPages,
    this.activeColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalPages > 0 ? (currentIndex + 1) / totalPages : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.starEmpty,
              valueColor: AlwaysStoppedAnimation<Color>(activeColor),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Teks halaman
        Text(
          '${currentIndex + 1} / $totalPages',
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}