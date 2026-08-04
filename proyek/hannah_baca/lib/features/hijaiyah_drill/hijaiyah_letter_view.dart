import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/syllable_color_mapper.dart';
import '../../data/models/hijaiyah_letter.dart';
import '../../state/font_scale_provider.dart';
import '../../state/settings_provider.dart';

class HijaiyahLetterView extends ConsumerWidget {
  final HijaiyahLetter letter;
  final int colorIndex;
  final VoidCallback onTap;

  const HijaiyahLetterView({
    super.key,
    required this.letter,
    required this.colorIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(colorModeProvider);
    final scale = ref.watch(fontScaleProvider);
    final color = SyllableColorMapper.colorFor(colorIndex, mode);

    return GestureDetector(
      onTap: onTap,
      child: Text(
        letter.char,
        style: AppTextStyles.hijaiyahScaled(scale).copyWith(color: color),
      ),
    );
  }
}