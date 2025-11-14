import 'package:flutter/material.dart';
import 'package:notepad_pro/utils/constants.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;
  final bool isSelected;
  final double fontSize;

  const TagChip({
    super.key,
    required this.label,
    this.color,
    this.onDeleted,
    this.onTap,
    this.isSelected = false,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? Theme.of(context).colorScheme.primary;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: onDeleted != null ? AppConstants.spacingS : AppConstants.spacingM,
            vertical: AppConstants.spacingXS,
          ),
          decoration: BoxDecoration(
            color: isSelected 
                ? chipColor.withOpacity(0.2)
                : chipColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected 
                  ? chipColor
                  : chipColor.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#$label',
                style: TextStyle(
                  color: chipColor,
                  fontSize: fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (onDeleted != null) ...[
                const SizedBox(width: AppConstants.spacingXS),
                GestureDetector(
                  onTap: onDeleted,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: chipColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}