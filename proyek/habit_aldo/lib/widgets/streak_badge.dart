import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StreakBadge extends StatelessWidget {
  final int streak;
  final double fontSize;

  const StreakBadge({super.key, required this.streak, this.fontSize = 11});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.streakColor(streak);
    final label = streak == 0 ? '—' : '🔥 $streak';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class CompletionBadge extends StatelessWidget {
  final double percent;
  final double fontSize;

  const CompletionBadge(
      {super.key, required this.percent, this.fontSize = 11});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.completionColor(percent);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4), width: 1),
      ),
      child: Text(
        '${percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
