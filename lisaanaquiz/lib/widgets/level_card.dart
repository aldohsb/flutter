import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'star_display.dart';

class LevelCard extends StatelessWidget {
  final int levelNumber;
  final bool isUnlocked;
  final int stars;
  final bool isPassed;
  final VoidCallback? onTap;

  const LevelCard({
    super.key,
    required this.levelNumber,
    required this.isUnlocked,
    required this.stars,
    required this.isPassed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isUnlocked ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: AppTheme.mediumAnimation,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: isUnlocked
                ? isPassed
                    ? AppTheme.goldGradient
                    : AppTheme.primaryGradient
                : null,
            color: isUnlocked ? null : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isUnlocked
                  ? isPassed
                      ? AppTheme.accentGold
                      : AppTheme.primaryGreen
                  : Colors.grey[400]!,
              width: 2,
            ),
            boxShadow: isUnlocked ? AppTheme.cardShadow : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lock/Check Icon
              if (!isUnlocked)
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 32,
                )
              else if (isPassed)
                const Icon(
                  Icons.check_circle,
                  color: AppTheme.textWhite,
                  size: 32,
                )
              else
                Icon(
                  Icons.play_circle_outline,
                  color: AppTheme.textWhite.withValues(alpha: 0.9),
                  size: 32,
                ),

              const SizedBox(height: 8),

              // Level Number
              Text(
                'Level',
                style: TextStyle(
                  fontSize: 12,
                  color: isUnlocked ? AppTheme.textWhite : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              Text(
                levelNumber.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? AppTheme.textWhite : Colors.grey[700],
                ),
              ),

              const SizedBox(height: 8),

              // Stars
              if (isUnlocked && isPassed)
                StarDisplay(
                  stars: stars,
                  size: 16,
                  color: AppTheme.textWhite,
                )
              else if (isUnlocked)
                Text(
                  '10 Soal',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textWhite.withValues(alpha: 0.8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}