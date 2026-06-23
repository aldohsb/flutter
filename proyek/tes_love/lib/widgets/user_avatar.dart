import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const UserAvatar({
    super.key,
    required this.name,
    this.size = 44,
    this.backgroundColor,
    this.textColor,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor ?? AppColors.primary,
            (backgroundColor ?? AppColors.primary).withAlpha(200),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? AppColors.primary).withAlpha(60),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: AppTextStyles.labelLarge.copyWith(
          fontSize: size * 0.36,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}