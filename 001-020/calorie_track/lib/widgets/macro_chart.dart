import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/constants.dart';

class MacroChart extends StatelessWidget {
  final double carbs;
  final double protein;
  final double fat;
  final double carbGoal;
  final double proteinGoal;
  final double fatGoal;

  const MacroChart({
    super.key,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.carbGoal,
    required this.proteinGoal,
    required this.fatGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nutrisi Makro',
            style: AppConstants.subheadingStyle,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 45,
                      sections: [
                        PieChartSectionData(
                          value: carbs > 0 ? carbs : 0.1,
                          color: AppConstants.carbColor,
                          title: '',
                          radius: 35,
                        ),
                        PieChartSectionData(
                          value: protein > 0 ? protein : 0.1,
                          color: AppConstants.proteinColor,
                          title: '',
                          radius: 35,
                        ),
                        PieChartSectionData(
                          value: fat > 0 ? fat : 0.1,
                          color: AppConstants.fatColor,
                          title: '',
                          radius: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildMacroItem(
                      'Karbohidrat',
                      carbs,
                      carbGoal,
                      AppConstants.carbColor,
                    ),
                    const SizedBox(height: 16),
                    _buildMacroItem(
                      'Protein',
                      protein,
                      proteinGoal,
                      AppConstants.proteinColor,
                    ),
                    const SizedBox(height: 16),
                    _buildMacroItem(
                      'Lemak',
                      fat,
                      fatGoal,
                      AppConstants.fatColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, double current, double goal, Color color) {
    final percentage = (current / goal * 100).clamp(0, 100);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${current.toStringAsFixed(0)}g / ${goal.toStringAsFixed(0)}g',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}