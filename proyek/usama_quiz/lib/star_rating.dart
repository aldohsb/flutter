import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Menampilkan 3 ikon bintang, sejumlah [stars] di antaranya terisi penuh.
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.stars,
    this.size = 16,
    this.spacing = 2,
  });

  final int stars;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final filled = index < stars;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: filled ? AppColors.starFilled : AppColors.starEmpty,
          ),
        );
      }),
    );
  }
}
