import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../widgets/edit_stats_dialog.dart';

class StatisticsScreen extends StatelessWidget {
  final String habitId;

  const StatisticsScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditStatsDialog(habitId: habitId),
              );
            },
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, provider, _) {
          final habit = provider.getHabitById(habitId);
          
          if (habit == null) {
            return const Center(child: Text('Habit not found'));
          }

          final now = DateTime.now();
          final monthlyPercentage = habit.getMonthlyPercentage(now.year, now.month);
          final currentMonth = DateFormat('MMMM yyyy').format(now);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          habit.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              context,
                              'Current Streak',
                              '${habit.streak}',
                              'days',
                              Icons.local_fire_department,
                            ),
                            Container(
                              width: 1,
                              height: 60,
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            ),
                            _buildStatItem(
                              context,
                              currentMonth,
                              '${monthlyPercentage.toStringAsFixed(1)}%',
                              'completed',
                              Icons.calendar_month,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Completion History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                if (habit.completionHistory.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'No completion history yet',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: habit.completionHistory.length > 30 
                          ? 30 
                          : habit.completionHistory.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                      itemBuilder: (context, index) {
                        final sortedHistory = List<DateTime>.from(habit.completionHistory)
                          ..sort((a, b) => b.compareTo(a));
                        final date = sortedHistory[index];
                        final dateStr = DateFormat('EEEE, d MMMM yyyy').format(date);
                        
                        return ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(dateStr),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    String unit,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}