// lib/features/reading/widgets/navigation_controls.dart

import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class NavigationControls extends StatelessWidget {
  final bool canGoPrev;
  final bool canGoNext;
  final bool isLastPage;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onFinish;
  final Color accentColor;

  const NavigationControls({
    super.key,
    required this.canGoPrev,
    required this.canGoNext,
    required this.isLastPage,
    required this.onPrev,
    required this.onNext,
    required this.onFinish,
    this.accentColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Tombol kembali
          _NavButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: canGoPrev ? onPrev : null,
            color: accentColor,
            filled: false,
          ),
          const Spacer(),

          // Tombol lanjut / selesai
          isLastPage
              ? _FinishButton(onTap: onFinish, color: accentColor)
              : _NavButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: canGoNext ? onNext : null,
                  color: accentColor,
                  filled: true,
                  large: true,
                ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;
  final bool filled;
  final bool large;

  const _NavButton({
    required this.icon,
    required this.onTap,
    required this.color,
    this.filled = false,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = large ? 72.0 : 60.0;
    final disabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.starEmpty
              : filled
                  ? color
                  : color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          boxShadow: filled && !disabled
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: large ? 32 : 26,
          color: disabled
              ? AppColors.textLight
              : filled
                  ? Colors.white
                  : color,
        ),
      ),
    );
  }
}

class _FinishButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const _FinishButton({required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.celebration_rounded, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              'Selesai!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}