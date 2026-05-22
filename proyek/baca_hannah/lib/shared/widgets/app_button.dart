// lib/shared/widgets/app_button.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/color_constants.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final IconData? icon;
  final double? width;
  final double height;
  final double fontSize;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.width,
    this.height = 56,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = switch (variant) {
      AppButtonVariant.primary => AppColors.primary,
      AppButtonVariant.secondary => AppColors.secondary,
      AppButtonVariant.ghost => Colors.transparent,
    };

    final Color textColor = switch (variant) {
      AppButtonVariant.primary => Colors.white,
      AppButtonVariant.secondary => Colors.white,
      AppButtonVariant.ghost => AppColors.primary,
    };

    final BoxDecoration decoration = variant == AppButtonVariant.ghost
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 2),
          )
        : BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: bgColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: height,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: fontSize + 4),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}