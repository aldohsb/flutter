import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../providers/food_provider.dart';
import '../utils/constants.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem food;

  const FoodDetailScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  double _servings = 1.0;

  @override
  Widget build(BuildContext context) {
    final totalCalories = widget.food.calories * _servings;
    final totalProtein = widget.food.protein * _servings;
    final totalCarbs = widget.food.carbs * _servings;
    final totalFat = widget.food.fat * _servings;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.primaryGreen,
        title: const Text(
          'Detail Makanan',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Food Icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppConstants.primaryGreen, AppConstants.lightGreen],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        widget.food.emoji,
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.food.category,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Serving Size Selector
                  Container(
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
                        const Text(
                          'Jumlah Porsi',
                          style: AppConstants.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_servings > 0.5) {
                                  setState(() {
                                    _servings -= 0.5;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                              color: AppConstants.primaryGreen,
                              iconSize: 36,
                            ),
                            Column(
                              children: [
                                Text(
                                  _servings.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.primaryGreen,
                                  ),
                                ),
                                Text(
                                  '${(_servings * widget.food.servingSize).toStringAsFixed(0)}g',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                if (_servings < 10) {
                                  setState(() {
                                    _servings += 0.5;
                                  });
                                }
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              color: AppConstants.primaryGreen,
                              iconSize: 36,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nutrition Info
                  Container(
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
                        const Text(
                          'Informasi Nutrisi',
                          style: AppConstants.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        _buildNutritionRow(
                          'Kalori',
                          totalCalories,
                          'kcal',
                          AppConstants.primaryGreen,
                        ),
                        const Divider(height: 24),
                        _buildNutritionRow(
                          'Karbohidrat',
                          totalCarbs,
                          'g',
                          AppConstants.carbColor,
                        ),
                        const Divider(height: 24),
                        _buildNutritionRow(
                          'Protein',
                          totalProtein,
                          'g',
                          AppConstants.proteinColor,
                        ),
                        const Divider(height: 24),
                        _buildNutritionRow(
                          'Lemak',
                          totalFat,
                          'g',
                          AppConstants.fatColor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        _addFood(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Tambahkan ke Diary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, double value, String unit, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          '${value.toStringAsFixed(1)} $unit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  void _addFood(BuildContext context) {
    final provider = Provider.of<FoodProvider>(context, listen: false);
    provider.addFoodEntry(widget.food, _servings);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.food.name} berhasil ditambahkan!'),
        backgroundColor: AppConstants.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    // Kembali ke home screen
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}