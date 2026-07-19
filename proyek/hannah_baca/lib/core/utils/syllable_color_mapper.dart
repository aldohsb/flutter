import 'package:flutter/material.dart';
import '../constants/color_mode.dart';
import '../theme/app_colors.dart';

class SyllableColorMapper {
  SyllableColorMapper._();

  static Color colorFor(int syllableIndex, SyllableColorMode mode) {
    if (mode == SyllableColorMode.single) return AppColors.primary;
    final palette = AppColors.syllablePalette;
    return palette[syllableIndex % palette.length];
  }
}