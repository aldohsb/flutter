import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/level_config.dart';
import '../../state/page_progress_provider.dart';

class LevelCard extends ConsumerWidget {
  final int level;
  final bool isCompleted;
  final bool isUnlocked;

  const LevelCard({
    super.key,
    required this.level,
    required this.isCompleted,
    required this.isUnlocked,
  });

  int get _maxTier => LevelConfig.fromLevel(level).maxTier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageProgress = ref.watch(pageProgressProvider);
    final inProgress = isUnlocked && !isCompleted && (pageProgress[level] ?? 0) > 0;
    final color =
        isUnlocked ? AppColors.tierColors[_maxTier - 1] : AppColors.locked;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: isUnlocked ? () => context.push('/drill/$level') : null,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: inProgress
              ? Border.all(color: Colors.white, width: 3)
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            isUnlocked
                ? Text('$level',
                    style: AppTextStyles.heading.copyWith(color: Colors.white))
                : const Icon(Icons.lock_rounded, color: Colors.white),
            if (isCompleted)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.star_rounded, color: Colors.white, size: 16),
              ),
            if (inProgress)
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