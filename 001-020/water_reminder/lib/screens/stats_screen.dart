// Stats screen - halaman untuk menampilkan statistik dan chart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/water_provider.dart';
import '../utils/constants.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Selected time range untuk chart
  int _selectedDays = 7; // default 7 hari

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Consumer<WaterProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // === TIME RANGE SELECTOR ===
                _buildTimeRangeSelector(),
                
                // === CHART SECTION ===
                _buildChart(provider),
                
                const SizedBox(height: AppConstants.paddingLarge),
                
                // === STATISTICS CARDS ===
                _buildStatsCards(provider),
                
                const SizedBox(height: AppConstants.paddingLarge),
                
                // === WEEKLY SUMMARY ===
                _buildWeeklySummary(provider),
                
                const SizedBox(height: AppConstants.paddingLarge),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build time range selector
  Widget _buildTimeRangeSelector() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingNormal),
      child: Row(
        children: [
          const Text(
            'Show last:',
            style: TextStyle(
              fontSize: AppConstants.fontSizeMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          
          // Chips untuk pilihan time range
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTimeRangeChip('7 Days', 7),
                  _buildTimeRangeChip('14 Days', 14),
                  _buildTimeRangeChip('30 Days', 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build individual time range chip
  Widget _buildTimeRangeChip(String label, int days) {
    final isSelected = _selectedDays == days;
    
    return Padding(
      padding: const EdgeInsets.only(right: AppConstants.paddingSmall),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedDays = days;
            });
          }
        },
        selectedColor: AppConstants.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Build chart
  Widget _buildChart(WaterProvider provider) {
    // Get data untuk chart
    final stats = provider.getDailyStatistics(_selectedDays);
    
    // Convert ke format untuk FlChart
    final spots = <FlSpot>[];
    final sortedDates = stats.keys.toList()..sort();
    
    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final amount = stats[date] ?? 0;
      // Convert ml ke liter untuk display
      spots.add(FlSpot(i.toDouble(), amount / 1000));
    }
    
    return Container(
      height: 250,
      margin: const EdgeInsets.all(AppConstants.paddingNormal),
      padding: const EdgeInsets.all(AppConstants.paddingNormal),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Water Intake',
            style: TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingNormal),
          
          // Chart
          Expanded(
            child: LineChart(
              LineChartData(
                // Grid settings
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 0.5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                
                // Titles
                titlesData: FlTitlesData(
                  // Top title (hidden)
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Right title (hidden)
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // Bottom titles (dates)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // Show only every nth label untuk avoid crowding
                        final showEvery = _selectedDays > 14 ? 3 : 1;
                        if (value.toInt() % showEvery != 0) {
                          return const Text('');
                        }
                        
                        final index = value.toInt();
                        if (index >= 0 && index < sortedDates.length) {
                          final date = sortedDates[index];
                          // Format: DD/MM
                          return Text(
                            DateFormat('dd/MM').format(date),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  // Left titles (amount in liters)
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toStringAsFixed(1)}L',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Border
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
                
                // Line data
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true, // Smooth curve
                    color: AppConstants.primaryColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    // Gradient below line
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor.withOpacity(0.3),
                          AppConstants.primaryColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                
                // Min/Max Y
                minY: 0,
                maxY: (provider.dailyGoalMl / 1000 * 1.2), // 120% dari goal
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build statistics cards
  Widget _buildStatsCards(WaterProvider provider) {
    final stats = provider.getDailyStatistics(_selectedDays);
    final amounts = stats.values.toList();
    
    // Calculate statistics
    final total = amounts.fold<int>(0, (sum, amount) => sum + amount);
    final average = amounts.isEmpty ? 0 : total / amounts.length;
    final max = amounts.isEmpty ? 0 : amounts.reduce((a, b) => a > b ? a : b);
    final daysReached = amounts.where(
      (amount) => amount >= provider.dailyGoalMl,
    ).length;
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingNormal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingNormal),
          
          // Grid of stat cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppConstants.paddingNormal,
            crossAxisSpacing: AppConstants.paddingNormal,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard(
                'Total',
                '${(total / 1000).toStringAsFixed(1)}L',
                Icons.water_drop,
                Colors.blue,
              ),
              _buildStatCard(
                'Average',
                '${(average / 1000).toStringAsFixed(1)}L',
                Icons.analytics,
                Colors.green,
              ),
              _buildStatCard(
                'Best Day',
                '${(max / 1000).toStringAsFixed(1)}L',
                Icons.trending_up,
                Colors.orange,
              ),
              _buildStatCard(
                'Goals Met',
                '$daysReached/$_selectedDays',
                Icons.check_circle,
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build individual stat card
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingNormal),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: AppConstants.fontSizeSmall,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Build weekly summary
  Widget _buildWeeklySummary(WaterProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingNormal,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.primaryColor.withValues(alpha: 0.1),
              AppConstants.backgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keep It Up! 💪',
              style: TextStyle(
                fontSize: AppConstants.fontSizeXLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              'You\'re doing great! Continue your hydration journey and reach your goals.',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}