import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../data/models/statistics.dart';
import '../../data/models/category.dart';

class StatisticsChart extends StatelessWidget {
  final List<Statistics> statistics;
  final Map<String, Category> categoryMap;
  final DateTime startDate;
  final DateTime endDate;
  
  const StatisticsChart({
    super.key,
    required this.statistics,
    required this.categoryMap,
    required this.startDate,
    required this.endDate,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Activity',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: _buildBarChart(context),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBarChart(BuildContext context) {
    final groupedByDate = <DateTime, Map<String, int>>{};
    
    // Group statistics by date and category
    for (final stat in statistics) {
      final date = stat.dateOnly;
      if (!groupedByDate.containsKey(date)) {
        groupedByDate[date] = {};
      }
      groupedByDate[date]![stat.categoryId] = stat.activeSeconds;
    }
    
    // Create bar groups
    final barGroups = <BarChartGroupData>[];
    final dates = groupedByDate.keys.toList()..sort();
    
    for (var i = 0; i < dates.length; i++) {
      final date = dates[i];
      final categoryData = groupedByDate[date]!;
      
      final rods = <BarChartRodData>[];
      var yOffset = 0.0;
      
      // Create stacked bars for each category
      for (final entry in categoryData.entries) {
        final category = categoryMap[entry.key];
        if (category != null) {
          final hours = entry.value / 3600;
          rods.add(
            BarChartRodData(
              fromY: yOffset,
              toY: yOffset + hours,
              color: category.color,
              width: 24,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          );
          yOffset += hours;
        }
      }
      
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: rods,
        ),
      );
    }
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY(groupedByDate),
        barGroups: barGroups,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= dates.length) return const Text('');
                final date = dates[value.toInt()];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('MM/dd').format(date),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}h',
                  style: const TextStyle(fontSize: 10),
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
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final date = dates[group.x.toInt()];
              final hours = (rod.toY - rod.fromY).toStringAsFixed(1);
              return BarTooltipItem(
                '${DateFormat('MMM dd').format(date)}\n$hours hours',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  double _getMaxY(Map<DateTime, Map<String, int>> groupedByDate) {
    var maxSeconds = 0;
    
    for (final categoryData in groupedByDate.values) {
      final totalSeconds = categoryData.values.fold(0, (a, b) => a + b);
      if (totalSeconds > maxSeconds) {
        maxSeconds = totalSeconds;
      }
    }
    
    final maxHours = (maxSeconds / 3600).ceil();
    return (maxHours + 1).toDouble();
  }
}
