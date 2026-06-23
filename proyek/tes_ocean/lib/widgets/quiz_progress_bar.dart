import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Menampilkan progres pengerjaan quiz berupa bar linear beserta teks
/// "soal ke-X dari Y" di atasnya.
class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.progress,
  });

  final int currentIndex;
  final int totalQuestions;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pertanyaan ${currentIndex + 1} dari $totalQuestions',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              );
            },
          ),
        ),
      ],
    );
  }
}
