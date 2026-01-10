import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class ChartWidget extends StatelessWidget {
  final Map<String, double> expensesByCategory;
  
  const ChartWidget({
    super.key,
    required this.expensesByCategory,
  });

  @override
  Widget build(BuildContext context) {
    final total = expensesByCategory.values.fold(0.0, (sum, value) => sum + value);
    
    if (total == 0) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: _buildPieChartSections(total),
                centerSpaceRadius: 60,
                sectionsSpace: 2,
                borderData: FlBorderData(show: false),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLegend(),
        ],
      ),
    );
  }
  
  List<PieChartSectionData> _buildPieChartSections(double total) {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.cyan,
      Colors.indigo,
      Colors.lime,
    ];
    
    int colorIndex = 0;
    
    return expensesByCategory.entries.map((entry) {
      final percentage = (entry.value / total * 100);
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      
      return PieChartSectionData(
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        color: color,
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: null,
      );
    }).toList();
  }
  
  Widget _buildLegend() {
    final colors = [
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.cyan,
      Colors.indigo,
      Colors.lime,
    ];
    
    int colorIndex = 0;
    
    return Column(
      children: expensesByCategory.entries.map((entry) {
        final color = colors[colorIndex % colors.length];
        colorIndex++;
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.key,
                  style: AppTextStyles.body1,
                ),
              ),
              Text(
                Helpers.formatCurrency(entry.value),
                style: AppTextStyles.subtitle1,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}