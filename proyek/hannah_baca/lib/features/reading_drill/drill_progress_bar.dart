import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DrillProgressBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const DrillProgressBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentPage + 1) / totalPages;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: AppColors.locked.withValues(alpha: 0.3),
        valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
      ),
    );
  }
}