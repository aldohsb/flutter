import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/syllable_color_mapper.dart';
import '../../data/models/word_entry.dart';
import '../../state/font_scale_provider.dart';
import '../../state/settings_provider.dart';

class SyllableWord extends ConsumerWidget {
  final WordEntry entry;

  const SyllableWord({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(colorModeProvider);
    final scale = ref.watch(fontScaleProvider);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          for (var i = 0; i < entry.syllables.length; i++)
            TextSpan(
              text: entry.syllables[i],
              style: AppTextStyles.syllableScaled(scale)
                  .copyWith(color: SyllableColorMapper.colorFor(i, mode)),
            ),
        ],
      ),
    );
  }
}