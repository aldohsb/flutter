import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/food_provider.dart';
import '../utils/constants.dart';
import '../widgets/calorie_progress.dart';
import '../widgets/macro_chart.dart';
import '../widgets/food_card.dart';
import 'add_food_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.primaryGreen,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CalorieTrack',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<FoodProvider>(
        builder: (context, foodProvider, child) {
          final todayLog = foodProvider.todayLog;

          return RefreshIndicator(
            onRefresh: () async {
              // Refresh data if needed
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calorie Progress
                  CalorieProgress(
                    current: todayLog.totalCalories,
                    goal: AppConstants.dailyCalorieGoal,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Macro Chart
                  MacroChart(
                    carbs: todayLog.totalCarbs,
                    protein: todayLog.totalProtein,
                    fat: todayLog.totalFat,
                    carbGoal: AppConstants.dailyCarbGoal,
                    proteinGoal: AppConstants.dailyProteinGoal,
                    fatGoal: AppConstants.dailyFatGoal,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Today's Food List
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Makanan Hari Ini',
                        style: AppConstants.subheadingStyle,
                      ),
                      Text(
                        '${todayLog.entries.length} item',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  todayLog.entries.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todayLog.entries.length,
                          itemBuilder: (context, index) {
                            final entry = todayLog.entries[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: FoodCard(
                                food: entry.food,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${entry.totalCalories.toStringAsFixed(0)} kcal',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${entry.servings}x porsi',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      color: Colors.red[400],
                                      onPressed: () {
                                        _showDeleteDialog(
                                          context,
                                          foodProvider,
                                          entry.id,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFoodScreen(),
            ),
          );
        },
        backgroundColor: AppConstants.primaryGreen,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Makanan'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada makanan hari ini',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap tombol + untuk menambahkan',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, FoodProvider provider, String entryId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Makanan'),
        content: const Text('Yakin ingin menghapus makanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              provider.removeFoodEntry(entryId);
              Navigator.pop(context);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}