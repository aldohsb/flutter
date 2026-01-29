import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/statistics_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/statistics_chart.dart';
import '../widgets/editable_stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          _buildDateRangeSelector(context),
        ],
      ),
      body: Consumer2<StatisticsProvider, CategoryProvider>(
        builder: (context, statsProvider, categoryProvider, _) {
          final stats = statsProvider.statistics;
          final categoryMap = {
            for (var cat in categoryProvider.categories) cat.id: cat
          };
          
          if (stats.isEmpty) {
            return const Center(
              child: Text('No statistics available'),
            );
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(context, statsProvider),
                const SizedBox(height: 24),
                StatisticsChart(
                  statistics: stats,
                  categoryMap: categoryMap,
                  startDate: statsProvider.selectedStartDate,
                  endDate: statsProvider.selectedEndDate,
                ),
                const SizedBox(height: 24),
                Text(
                  'Detailed Statistics',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ...stats.map((stat) {
                  final category = categoryMap[stat.categoryId];
                  if (category == null) return const SizedBox();
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EditableStatCard(
                      statistics: stat,
                      category: category,
                      onUpdate: (updated) {
                        statsProvider.updateStatistics(updated);
                      },
                      onDelete: () {
                        statsProvider.deleteStatistics(stat.categoryId, stat.date);
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildDateRangeSelector(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.date_range),
      onSelected: (value) async {
        final provider = context.read<StatisticsProvider>();
        switch (value) {
          case 'today':
            await provider.setToday();
            break;
          case 'week':
            await provider.setThisWeek();
            break;
          case 'month':
            await provider.setThisMonth();
            break;
          case 'last7':
            await provider.setLast7Days();
            break;
          case 'last30':
            await provider.setLast30Days();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'today', child: Text('Today')),
        const PopupMenuItem(value: 'week', child: Text('This Week')),
        const PopupMenuItem(value: 'month', child: Text('This Month')),
        const PopupMenuItem(value: 'last7', child: Text('Last 7 Days')),
        const PopupMenuItem(value: 'last30', child: Text('Last 30 Days')),
      ],
    );
  }
  
  Widget _buildSummaryCards(BuildContext context, StatisticsProvider provider) {
    final totalSeconds = provider.getTotalTimeSeconds();
    final avgDaily = provider.getAverageDailyTime();
    
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Time', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    '${(totalSeconds / 3600).toStringAsFixed(1)}h',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Avg Daily', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    '${(avgDaily / 3600).toStringAsFixed(1)}h',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
