// lib/shared/widgets/star_rating.dart

import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';

class StarRating extends StatelessWidget {
  final int stars;         // 0-3
  final double starSize;
  final double spacing;

  const StarRating({
    super.key,
    required this.stars,
    this.starSize = 24,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final filled = i < stars;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: filled ? AppColors.starFilled : AppColors.starEmpty,
            size: starSize,
          ),
        );
      }),
    );
  }
}