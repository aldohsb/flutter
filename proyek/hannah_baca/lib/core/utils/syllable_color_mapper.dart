import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SyllableColorMapper {
  SyllableColorMapper._();

  static Color colorFor(int syllableIndex) {
    final palette = AppColors.syllablePalette;
    return palette[syllableIndex % palette.length];
  }
}