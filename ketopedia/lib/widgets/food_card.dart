import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../utils/constants.dart';
import 'rating_badge.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Category Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: food.ratingColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                    child: Icon(
                      food.category.icon,
                      color: food.ratingColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Food Name & Category
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          food.category.displayName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  
                  // Favorite Button
                  if (onFavoriteTap != null)
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppConstants.primaryRed : null,
                      ),
                      onPressed: onFavoriteTap,
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Rating Badge
              RatingBadge(rating: food.rating),
              
              const SizedBox(height: 12),
              
              // Macros
              Row(
                children: [
                  _buildMacroChip(
                    context,
                    'Karbo',
                    '${food.carbs.toStringAsFixed(1)}g',
                    Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  _buildMacroChip(
                    context,
                    'Protein',
                    '${food.protein.toStringAsFixed(1)}g',
                    Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _buildMacroChip(
                    context,
                    'Lemak',
                    '${food.fat.toStringAsFixed(1)}g',
                    Colors.green,
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Calories
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppConstants.accentYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                ),
                child: Text(
                  '${food.calories.toStringAsFixed(0)} kkal / 100g',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroChip(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}