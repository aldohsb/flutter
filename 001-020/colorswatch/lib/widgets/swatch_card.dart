import 'package:flutter/material.dart';
import '../models/color_swatch_model.dart';
import '../utils/color_utils.dart';

class SwatchCard extends StatelessWidget {
  final ColorSwatchModel swatch;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const SwatchCard({
    super.key,
    required this.swatch,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 64,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: swatch.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24, width: 2),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          colorToHex(swatch.color),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: contrastColor(swatch.color),
          ),
        ),
      ),
    );
  }
}