import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final bool isCompleted;
  final bool isStarted;

  const LevelCard({
    super.key,
    required this.level,
    required this.isCompleted,
    required this.isStarted,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCompleted
        ? AppColors.secondary
        : isStarted
            ? AppColors.accent
            : AppColors.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push('/drill/$level'),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text('$level',
                style: AppTextStyles.heading.copyWith(color: Colors.white)),
            if (isCompleted)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.star_rounded, color: Colors.white, size: 16),
              ),
            if (isStarted && !isCompleted)
              const Positioned(
                bottom: 4,
                right: 4,
                child: Icon(Icons.play_circle_fill_rounded,
                    color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }
}