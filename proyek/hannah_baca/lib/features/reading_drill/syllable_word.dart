import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/syllable_color_mapper.dart';
import '../../data/models/word_entry.dart';

class SyllableWord extends StatelessWidget {
  final WordEntry entry;

  const SyllableWord({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          for (var i = 0; i < entry.syllables.length; i++)
            TextSpan(
              text: entry.syllables[i],
              style: AppTextStyles.syllable
                  .copyWith(color: SyllableColorMapper.colorFor(i)),
            ),
        ],
      ),
    );
  }
}