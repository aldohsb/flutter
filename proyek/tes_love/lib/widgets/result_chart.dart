import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/quiz_result_model.dart';
import '../utils/love_language_info.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class ResultChart extends StatelessWidget {
  final Map<LoveLanguage, int> scores;
  final int totalQuestions;

  const ResultChart({
    super.key,
    required this.scores,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final ranked = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Distribusi Skor', style: AppTextStyles.labelMedium),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: totalQuestions.toDouble(),
              minY: 0,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => AppColors.textPrimary,
                  tooltipRoundedRadius: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final ll = ranked[group.x].key;
                    final info = LoveLanguageInfo.of(ll);
                    return BarTooltipItem(
                      '${info.language.emoji} ${rod.toY.round()} poin',
                      AppTextStyles.bodySmall.copyWith(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= ranked.length) {
                        return const SizedBox.shrink();
                      }
                      final ll = ranked[idx].key;
                      final info = LoveLanguageInfo.of(ll);
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              info.language.emoji,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: 2,
                    getTitlesWidget: (value, meta) {
                      if (value % 2 != 0) return const SizedBox.shrink();
                      return Text(
                        value.toInt().toString(),
                        style: AppTextStyles.caption,
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 2,
                getDrawingHorizontalLine: (value) => const FlLine(
                  color: AppColors.divider,
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(ranked.length, (i) {
                final entry = ranked[i];
                final info = LoveLanguageInfo.of(entry.key);
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: info.color,
                      width: 28,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: totalQuestions.toDouble(),
                        color: info.color.withAlpha(20),
                      ),
                    ),
                  ],
                );
              }),
            ),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: ranked.map((entry) {
            final info = LoveLanguageInfo.of(entry.key);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: info.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  info.language.shortLabel,
                  style: AppTextStyles.caption,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}