import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/quiz_result_model.dart';
import '../utils/love_language_info.dart';
import '../theme/app_text_styles.dart';

class LoveLanguageCard extends StatelessWidget {
  final LoveLanguage language;
  final int score;
  final int totalQuestions;
  final int rank; // 1 = primary
  final bool isExpanded;
  final VoidCallback onToggle;

  const LoveLanguageCard({
    super.key,
    required this.language,
    required this.score,
    required this.totalQuestions,
    required this.rank,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final info = LoveLanguageInfo.of(language);
    final isPrimary = rank == 1;
    final percentage = (score / totalQuestions * 100).round();

    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isPrimary
              ? info.color.withAlpha(18)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPrimary ? info.color : const Color(0xFFEADDD8),
            width: isPrimary ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ──────────────────────────────
              Row(
                children: [
                  // Rank badge
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isPrimary ? info.color : info.color.withAlpha(40),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      rank == 1 ? '★' : '$rank',
                      style: TextStyle(
                        fontSize: isPrimary ? 14 : 12,
                        fontWeight: FontWeight.w700,
                        color: isPrimary ? Colors.white : info.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Emoji + title
                  Text(info.language.emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      info.title,
                      style: AppTextStyles.headingMedium.copyWith(
                        fontSize: isPrimary ? 17 : 15,
                        color: isPrimary ? info.color : null,
                      ),
                    ),
                  ),
                  // Score
                  Text(
                    '$score / $totalQuestions',
                    style: AppTextStyles.numberMedium.copyWith(
                      fontSize: 18,
                      color: info.color,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: info.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ── Progress bar ─────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: score / totalQuestions),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    backgroundColor: info.color.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(info.color),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$percentage% dari total jawaban',
                style: AppTextStyles.caption.copyWith(color: info.color),
              ),

              // ── Expanded detail ───────────────────────────
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: _buildDetail(info),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(key: ValueKey('ll_card_$rank'))
        .fadeIn(duration: 400.ms, delay: (rank * 60).ms)
        .slideY(begin: 0.05, end: 0, duration: 400.ms, delay: (rank * 60).ms);
  }

  Widget _buildDetail(LoveLanguageInfo info) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: info.color.withAlpha(40), height: 1),
          const SizedBox(height: 12),
          Text(
            '"${info.tagline}"',
            style: AppTextStyles.headingMedium.copyWith(
              fontStyle: FontStyle.italic,
              color: info.color,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            info.description,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
          ),
          const SizedBox(height: 12),
          _infoBlock(
            icon: Icons.favorite_border_rounded,
            title: 'Cara mencintaimu',
            body: info.howToLove,
            color: info.color,
          ),
          const SizedBox(height: 10),
          _infoBlock(
            icon: Icons.warning_amber_rounded,
            title: 'Yang perlu diperhatikan',
            body: info.warning,
            color: info.color,
          ),
        ],
      ),
    );
  }

  Widget _infoBlock({
    required IconData icon,
    required String title,
    required String body,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(color: color),
              ),
              const SizedBox(height: 4),
              Text(body, style: AppTextStyles.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}