import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const display = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    letterSpacing: -1,
  );

  static const expression = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const buttonNumber = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const buttonOperator = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const buttonFunction = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );
}