import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/quiz_result_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final LoveLanguage language;
  final bool isSelected;
  final VoidCallback onTap;
  final int index; // 0 = A, 1 = B

  const OptionTile({
    super.key,
    required this.text,
    required this.language,
    required this.isSelected,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final label = index == 0 ? 'A' : 'B';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withAlpha(20)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(30),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label A / B
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Teks opsi
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Checkmark
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 22,
              ),
          ],
        ),
      ),
    )
        .animate(key: ValueKey('option_$index'))
        .fadeIn(duration: 300.ms, delay: (index * 80).ms)
        .slideY(begin: 0.08, end: 0, duration: 300.ms, delay: (index * 80).ms);
  }
}