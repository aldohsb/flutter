import 'package:flutter/material.dart';

import '../models/ocean_trait.dart';
import '../theme/app_colors.dart';
import '../utils/score_interpreter.dart';

/// Kartu yang menampilkan satu trait OCEAN beserta skor, label level
/// (Rendah/Sedang/Tinggi), dan bar visual proporsional terhadap skor.
class TraitScoreCard extends StatelessWidget {
  const TraitScoreCard({
    super.key,
    required this.trait,
    required this.score,
    this.onTap,
  });

  final OceanTrait trait;
  final double score;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final level = ScoreInterpreter.levelOf(score);
    final levelLabel = ScoreInterpreter.levelLabel(level);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: trait.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(trait.icon, color: trait.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trait.labelId,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          trait.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        score.round().toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: trait.color,
                        ),
                      ),
                      Text(
                        levelLabel,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: (score / 100).clamp(0, 1),
                  minHeight: 7,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation(trait.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
