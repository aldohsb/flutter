import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/lesson_card.dart';

class SyllableCardWidget extends StatelessWidget {
  final LessonCard card;
  final List<Color> gradientColors;

  const SyllableCardWidget({
    super.key,
    required this.card,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (card.syllables.length == 1) {
      return _SingleSyllable(text: card.syllables[0]);
    } else if (card.syllables.length == 2) {
      return _DoubleSyllable(
        first: card.syllables[0],
        second: card.syllables[1],
      );
    } else {
      return _TripleSyllable(
        first: card.syllables[0],
        second: card.syllables[1],
        third: card.syllables[2],
      );
    }
  }
}

// ─── Single Suku Kata ───────────────────────────────────────────────
class _SingleSyllable extends StatelessWidget {
  final String text;
  const _SingleSyllable({required this.text});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          text,
          style: AppTextStyles.syllableMain(Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ─── Dua Suku Kata ──────────────────────────────────────────────────
class _DoubleSyllable extends StatelessWidget {
  final String first;
  final String second;
  const _DoubleSyllable({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 400 ? 110.0 : 90.0;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSyllableText(first, AppColors.syllableColors[0], fontSize),
            const SizedBox(width: 8),
            _buildSyllableText(second, AppColors.syllableColors[1], fontSize),
          ],
        ),
      ),
    );
  }

  Widget _buildSyllableText(String text, Color color, double fontSize) {
    return Text(
      text,
      style: GoogleFontsHelper.baloo2(fontSize, color),
    );
  }
}

// ─── Tiga Suku Kata ─────────────────────────────────────────────────
class _TripleSyllable extends StatelessWidget {
  final String first;
  final String second;
  final String third;
  const _TripleSyllable({
    required this.first,
    required this.second,
    required this.third,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth > 400 ? 76.0 : 60.0;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSyllableText(first, AppColors.syllableColors[0], fontSize),
            const SizedBox(width: 4),
            _buildSyllableText(second, AppColors.syllableColors[1], fontSize),
            const SizedBox(width: 4),
            _buildSyllableText(third, AppColors.syllableColors[0], fontSize),
          ],
        ),
      ),
    );
  }

  Widget _buildSyllableText(String text, Color color, double fontSize) {
    return Text(
      text,
      style: GoogleFontsHelper.baloo2(fontSize, color),
    );
  }
}

// ─── Helper ─────────────────────────────────────────────────────────
class GoogleFontsHelper {
  static TextStyle baloo2(double fontSize, Color color) {
    return TextStyle(
      fontFamily: 'Baloo2',
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.0,
      shadows: [
        Shadow(
          color: Colors.black.withAlpha(60),
          offset: Offset(fontSize * 0.025, fontSize * 0.035),
          blurRadius: 0,
        ),
      ],
    );
  }
}
