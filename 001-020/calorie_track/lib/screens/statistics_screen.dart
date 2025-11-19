import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/food_provider.dart';
import '../utils/constants.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.primaryGreen,
        title: const Text(
          'Statistik',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<FoodProvider>(
        builder: (context, foodProvider, child) {
          final todayLog = foodProvider.todayLog;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards
                const Text(
                  'Ringkasan Hari Ini',
                  style: AppConstants.subheadingStyle,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'Total Kalori',
                        todayLog.totalCalories.toStringAsFixed(0),
                        'kcal',
                        AppConstants.primaryGreen,
                        Icons.local_fire_department,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        'Makanan',
                        todayLog.entries.length.toString(),
                        'item',
                        AppConstants.lightGreen,
                        Icons.restaurant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Macro Distribution Chart
                const Text(
                  'Distribusi Makronutrien',
                  style: AppConstants.subheadingStyle,
                ),
                const SizedBox(height: 12),
                _buildMacroDistributionChart(todayLog),

                const SizedBox(height: 24),

                // Daily Goals Progress
                const Text(
                  'Progress Target Harian',
                  style: AppConstants.subheadingStyle,
                ),
                const SizedBox(height: 12),
                _buildGoalProgressCard(
                  'Kalori',
                  todayLog.totalCalories,
                  AppConstants.dailyCalorieGoal,
                  AppConstants.primaryGreen,
                  'kcal',
                ),
                const SizedBox(height: 8),
                _buildGoalProgressCard(
                  'Karbohidrat',
                  todayLog.totalCarbs,
                  AppConstants.dailyCarbGoal,
                  AppConstants.carbColor,
                  'g',
                ),
                const SizedBox(height: 8),
                _buildGoalProgressCard(
                  'Protein',
                  todayLog.totalProtein,
                  AppConstants.dailyProteinGoal,
                  AppConstants.proteinColor,
                  'g',
                ),
                const SizedBox(height: 8),
                _buildGoalProgressCard(
                  'Lemak',
                  todayLog.totalFat,
                  AppConstants.dailyFatGoal,
                  AppConstants.fatColor,
                  'g',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    String unit,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroDistributionChart(dynamic todayLog) {
    final totalMacros = todayLog.totalCarbs + todayLog.totalProtein + todayLog.totalFat;
    
    if (totalMacros == 0) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Belum ada data',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 3,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: todayLog.totalCarbs,
                    color: AppConstants.carbColor,
                    title: '${(todayLog.totalCarbs / totalMacros * 100).toStringAsFixed(0)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: todayLog.totalProtein,
                    color: AppConstants.proteinColor,
                    title: '${(todayLog.totalProtein / totalMacros * 100).toStringAsFixed(0)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: todayLog.totalFat,
                    color: AppConstants.fatColor,
                    title: '${(todayLog.totalFat / totalMacros * 100).toStringAsFixed(0)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem('Karbohidrat', AppConstants.carbColor),
              const SizedBox(height: 8),
              _buildLegendItem('Protein', AppConstants.proteinColor),
              const SizedBox(height: 8),
              _buildLegendItem('Lemak', AppConstants.fatColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
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
    );
  }

  Widget _buildGoalProgressCard(
    String label,
    double current,
    double goal,
    Color color,
    String unit,
  ) {
    final percentage = (current / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${current.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} $unit',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(percentage * 100).toStringAsFixed(0)}% tercapai',
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}