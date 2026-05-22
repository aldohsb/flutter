// lib/features/reading/widgets/syllable_display.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/page_model.dart';

class SyllableDisplay extends StatelessWidget {
  final ReadingPage page;
  final bool isAnimating;

  const SyllableDisplay({
    super.key,
    required this.page,
    this.isAnimating = true,
  });

  @override
  Widget build(BuildContext context) {
    final syllables = page.syllables;
    final count = syllables.length;

    // Font size berdasarkan jumlah suku kata & panjang teks gabungan
    final totalChars = syllables.fold<int>(0, (sum, s) => sum + s.text.length);
    final double fontSize = switch (count) {
      1 => 100,
      2 => totalChars <= 4 ? 86 : 72,
      _ => totalChars <= 6 ? 68 : 54,
    };

    // Bangun RichText spans — suku kata berjejer tanpa spasi
    final spans = syllables.asMap().entries.map((entry) {
      final i = entry.key;
      final syllable = entry.value;
      final color = AppColors.syllableColor(syllable.colorIndex);

      return WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: _AnimatedSyllable(
          text: syllable.text,
          color: color,
          fontSize: fontSize,
          index: i,
          animate: isAnimating,
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label halaman
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Halaman ${page.pageNumber}',
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Kata utuh: suku kata berjejer tanpa spasi, tiap suku beda warna
          Center(
            child: Text.rich(
              TextSpan(children: spans),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 28),

          // Colour strip bawah — satu kotak per suku kata
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: syllables.asMap().entries.map((entry) {
              final syllable = entry.value;
              final color = AppColors.syllableColor(syllable.colorIndex);
              return Container(
                width: 44,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Suku kata tunggal dengan animasi ─────────────────────────
class _AnimatedSyllable extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final int index;
  final bool animate;

  const _AnimatedSyllable({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.index,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    Widget w = Text(
      text,
      style: GoogleFonts.nunito(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: color,
        height: 1.0,
        shadows: [
          Shadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    if (animate) {
      w = w
          .animate(delay: Duration(milliseconds: 80 * index))
          .scale(
            begin: const Offset(0.4, 0.4),
            end: const Offset(1.0, 1.0),
            duration: 380.ms,
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 180.ms);
    }

    return w;
  }
}