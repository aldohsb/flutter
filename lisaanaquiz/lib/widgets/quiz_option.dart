import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum OptionState {
  normal,
  selected,
  correct,
  wrong,
}

class QuizOption extends StatelessWidget {
  final String option;
  final String label;
  final OptionState state;
  final VoidCallback? onTap;
  final bool isArabic;

  const QuizOption({
    super.key,
    required this.option,
    required this.label,
    required this.state,
    this.onTap,
    this.isArabic = false,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor;
    IconData? icon;

    switch (state) {
      case OptionState.normal:
        borderColor = AppTheme.lightGreen;
        backgroundColor = Colors.white;
        icon = null;
        break;
      case OptionState.selected:
        borderColor = AppTheme.primaryGreen;
        backgroundColor = AppTheme.paleGreen;
        icon = null;
        break;
      case OptionState.correct:
        borderColor = AppTheme.correctGreen;
        backgroundColor = AppTheme.correctGreen.withValues(alpha: 0.1);
        icon = Icons.check_circle;
        break;
      case OptionState.wrong:
        borderColor = AppTheme.wrongRed;
        backgroundColor = AppTheme.wrongRed.withValues(alpha: 0.1);
        icon = Icons.cancel;
        break;
    }

    // Check if option has transliteration (2 lines)
    final hasTransliteration = isArabic && option.contains('\n');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: state == OptionState.normal ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: AppTheme.shortAnimation,
            padding: EdgeInsets.all(hasTransliteration ? 12 : 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: state == OptionState.normal ? 1.5 : 2.5,
              ),
              boxShadow: state != OptionState.normal
                  ? [
                      BoxShadow(
                        color: borderColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Option Label (A, B, C, D)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state == OptionState.normal
                        ? AppTheme.lightGreen
                        : borderColor,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: state == OptionState.normal
                            ? AppTheme.textDark
                            : AppTheme.textWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Option Text
                Expanded(
                  child: isArabic && option.contains('\n')
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.split('\n')[0], // Arabic text
                              style: AppTheme.arabicTextStyle.copyWith(
                                fontSize: 22,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              option.split('\n')[1], // Transliteration
                              style: AppTheme.transliterationStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          option,
                          style: isArabic
                              ? AppTheme.arabicTextStyle.copyWith(
                                  fontSize: 24,
                                  color: AppTheme.textDark,
                                )
                              : Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                ),

                // Status Icon
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    icon,
                    color: borderColor,
                    size: 28,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}