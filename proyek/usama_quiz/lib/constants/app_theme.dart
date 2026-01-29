import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryMain,
        onPrimary: AppColors.white,
        secondary: AppColors.secondaryOlive,
        onSecondary: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.textDark,
        surfaceContainerHighest: AppColors.greyLight,
        outline: AppColors.greyMid,
      ),
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryMain,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppFontSizes.xl,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          fontFamily: 'Inter',
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.greyLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMain,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: const TextStyle(
            fontSize: AppFontSizes.lg,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryMain,
          side: const BorderSide(color: AppColors.primaryMain, width: 2),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: const TextStyle(
            fontSize: AppFontSizes.lg,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryMain,
          padding: const EdgeInsets.all(AppSpacing.md),
          textStyle: const TextStyle(
            fontSize: AppFontSizes.md,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.greyLight,
        contentPadding: const EdgeInsets.all(AppSpacing.lg),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.primaryMain,
            width: 2,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textLight,
          fontSize: AppFontSizes.md,
          fontFamily: 'Inter',
        ),
        labelStyle: const TextStyle(
          color: AppColors.textMid,
          fontSize: AppFontSizes.md,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppFontSizes.huge,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        displayMedium: TextStyle(
          fontSize: AppFontSizes.xxxl,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        displaySmall: TextStyle(
          fontSize: AppFontSizes.xxl,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        headlineMedium: TextStyle(
          fontSize: AppFontSizes.xl,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        headlineSmall: TextStyle(
          fontSize: AppFontSizes.lg,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          fontSize: AppFontSizes.lg,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          fontSize: AppFontSizes.lg,
          fontWeight: FontWeight.w400,
          color: AppColors.textMid,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          fontSize: AppFontSizes.md,
          fontWeight: FontWeight.w400,
          color: AppColors.textMid,
          fontFamily: 'Inter',
        ),
        bodySmall: TextStyle(
          fontSize: AppFontSizes.sm,
          fontWeight: FontWeight.w400,
          color: AppColors.textLight,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}