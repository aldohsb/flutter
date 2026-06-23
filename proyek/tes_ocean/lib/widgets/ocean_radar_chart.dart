import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/ocean_trait.dart';
import '../theme/app_colors.dart';

/// Menampilkan visualisasi radar chart dari skor lima trait OCEAN
/// menggunakan package fl_chart.
class OceanRadarChart extends StatelessWidget {
  const OceanRadarChart({
    super.key,
    required this.scores,
  });

  /// Peta trait ke skor (0-100), wajib berisi seluruh lima trait.
  final Map<OceanTrait, double> scores;

  @override
  Widget build(BuildContext context) {
    final orderedTraits = OceanTrait.values;

    return AspectRatio(
      aspectRatio: 1.1,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          tickCount: 4,
          ticksTextStyle: const TextStyle(
            color: Colors.transparent,
            fontSize: 0,
          ),
          radarBorderData: const BorderSide(
            color: AppColors.border,
            width: 1.2,
          ),
          gridBorderData: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
          titlePositionPercentageOffset: 0.18,
          getTitle: (index, angle) {
            final trait = orderedTraits[index];
            return RadarChartTitle(text: trait.code);
          },
          titleTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
          dataSets: [
            RadarDataSet(
              fillColor: AppColors.primary.withValues(alpha: 0.18),
              borderColor: AppColors.primary,
              borderWidth: 2.4,
              entryRadius: 3.5,
              dataEntries: orderedTraits
                  .map((trait) => RadarEntry(value: scores[trait] ?? 0))
                  .toList(),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
