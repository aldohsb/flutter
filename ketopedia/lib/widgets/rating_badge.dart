import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class RatingBadge extends StatelessWidget {
  final int rating;
  final bool showIcon;
  final bool compact;

  const RatingBadge({
    super.key,
    required this.rating,
    this.showIcon = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final badgeData = Helpers.getRatingBadge(rating);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: badgeData['color'].withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: Border.all(
          color: badgeData['color'],
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              badgeData['icon'],
              size: compact ? 14 : 16,
              color: badgeData['color'],
            ),
            SizedBox(width: compact ? 4 : 6),
          ],
          Text(
            badgeData['label'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeData['color'],
              fontWeight: FontWeight.w700,
              fontSize: compact ? 11 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingLegend extends StatelessWidget {
  const RatingLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panduan Rating Makanan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildLegendItem(
              context,
              AppConstants.ratingExcellentValue,
              '0-5g net carbs/100g',
              'Konsumsi bebas, sangat cocok untuk keto',
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              context,
              AppConstants.ratingModerateValue,
              '5-15g net carbs/100g',
              'Boleh dikonsumsi dalam porsi sedang',
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              context,
              AppConstants.ratingCarefulValue,
              '15-25g net carbs/100g',
              'Batasi konsumsi, porsi sangat kecil',
            ),
            const SizedBox(height: 8),
            _buildLegendItem(
              context,
              AppConstants.ratingAvoidValue,
              '>25g net carbs/100g',
              'Hindari untuk menjaga ketosis',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    int rating,
    String range,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBadge(rating: rating, compact: true),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                range,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}