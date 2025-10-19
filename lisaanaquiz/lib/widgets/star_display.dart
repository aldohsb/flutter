import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StarDisplay extends StatelessWidget {
  final int stars;
  final double size;
  final Color? color;

  const StarDisplay({
    super.key,
    required this.stars,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isFilled = index < stars;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.1),
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: color ?? AppTheme.starGold,
            size: size,
          ),
        );
      }),
    );
  }
}