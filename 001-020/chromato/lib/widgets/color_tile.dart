import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/color_item.dart';

class ColorTile extends StatelessWidget {
  final ColorItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: item.value,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.textPrimary : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: item.value.withValues(alpha: 0.6),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}