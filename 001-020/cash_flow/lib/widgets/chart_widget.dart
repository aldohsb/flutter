import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/app_theme.dart';
import '../utils/helpers.dart';

class ChartWidget extends StatelessWidget {
  final Map<String, double> data;
  final String type;

  const ChartWidget({
    super.key,
    required this.data,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('Belum ada data'),
        ),
      );
    }

    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = type == 'income'
        ? [
            AppTheme.incomeColor,
            AppTheme.successColor,
            AppTheme.secondaryColor,
          ]
        : [
            AppTheme.expenseColor,
            AppTheme.primaryColor,
            const Color(0xFFFF7675),
            const Color(0xFFFFBE76),
          ];

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 60,
          sections: _generateSections(sortedEntries, colors),
          borderData: FlBorderData(show: false),
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {},
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections(
    List<MapEntry<String, double>> entries,
    List<Color> colors,
  ) {
    final total = entries.fold<double>(0, (sum, entry) => sum + entry.value);

    return entries.asMap().entries.map((mapEntry) {
      final index = mapEntry.key;
      final entry = mapEntry.value;
      final percentage = Helpers.calculatePercentage(entry.value, total);
      final color = colors[index % colors.length];

      return PieChartSectionData(
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        color: color,
      );
    }).toList();
  }
}

class ChartLegend extends StatelessWidget {
  final Map<String, double> data;
  final String type;

  const ChartLegend({
    super.key,
    required this.data,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = type == 'income'
        ? [
            AppTheme.incomeColor,
            AppTheme.successColor,
            AppTheme.secondaryColor,
          ]
        : [
            AppTheme.expenseColor,
            AppTheme.primaryColor,
            const Color(0xFFFF7675),
            const Color(0xFFFFBE76),
          ];

    return Column(
      children: sortedEntries.asMap().entries.map((mapEntry) {
        final index = mapEntry.key;
        final entry = mapEntry.value;
        final color = colors[index % colors.length];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.key,
                  style: AppTheme.bodyMedium,
                ),
              ),
              Text(
                Helpers.formatCurrency(entry.value),
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}