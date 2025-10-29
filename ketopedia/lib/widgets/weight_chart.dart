import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/weight_entry_model.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class WeightChart extends StatelessWidget {
  final List<WeightEntryModel> entries;
  final double? targetWeight;

  const WeightChart({
    super.key,
    required this.entries,
    this.targetWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(
        child: Text('Belum ada data untuk ditampilkan'),
      );
    }

    final spots = _generateSpots();
    final minWeight = _getMinWeight();
    final maxWeight = _getMaxWeight();

    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Theme.of(context).dividerColor,
                strokeWidth: 0.5,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= entries.length) {
                    return const SizedBox();
                  }
                  final entry = entries[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      Helpers.formatDate(entry.date, format: 'dd/MM'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 2,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}kg',
                    style: Theme.of(context).textTheme.bodySmall,
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              left: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          minX: 0,
          maxX: (entries.length - 1).toDouble(),
          minY: minWeight - 2,
          maxY: maxWeight + 2,
          lineBarsData: [
            // Actual weight line
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: const LinearGradient(
                colors: [
                  AppConstants.primaryRed,
                  AppConstants.accentYellow,
                ],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: AppConstants.accentYellow,
                    strokeWidth: 2,
                    strokeColor: AppConstants.primaryRed,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryRed.withOpacity(0.3),
                    AppConstants.accentYellow.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Target weight line
            if (targetWeight != null)
              LineChartBarData(
                spots: [
                  FlSpot(0, targetWeight!),
                  FlSpot((entries.length - 1).toDouble(), targetWeight!),
                ],
                isCurved: false,
                color: AppConstants.ratingExcellent,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                dashArray: [5, 5],
              ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final entry = entries[spot.x.toInt()];
                  return LineTooltipItem(
                    '${Helpers.formatDate(entry.date, format: 'dd MMM')}\n${spot.y.toStringAsFixed(1)} kg',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    return entries
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.weight,
            ))
        .toList();
  }

  double _getMinWeight() {
    double min = entries.first.weight;
    for (final entry in entries) {
      if (entry.weight < min) min = entry.weight;
    }
    if (targetWeight != null && targetWeight! < min) {
      min = targetWeight!;
    }
    return min;
  }

  double _getMaxWeight() {
    double max = entries.first.weight;
    for (final entry in entries) {
      if (entry.weight > max) max = entry.weight;
    }
    return max;
  }
}