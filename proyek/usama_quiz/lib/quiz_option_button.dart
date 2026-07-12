import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';

/// Tombol satu opsi jawaban pilihan ganda.
///
/// Sebelum dijawab: tampil netral, bisa disorot saat dipilih.
/// Setelah dijawab ([showResult] = true): opsi yang benar selalu berwarna
/// hijau; jika pemain memilih opsi yang salah, opsi tersebut disorot merah.
class QuizOptionButton extends StatelessWidget {
  const QuizOptionButton({
    super.key,
    required this.label,
    required this.isJapaneseText,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.showResult,
    required this.onTap,
  });

  final String label;
  final bool isJapaneseText;
  final bool isSelected;
  final bool isCorrectAnswer;
  final bool showResult;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveColors();

    return AnimatedContainer(
      duration: AppDurations.fast,
      curve: Curves.easeOut,
      child: Material(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: showResult ? null : onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border, width: isSelected ? 2 : 1.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showResult && isCorrectAnswer)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                  ),
                if (showResult && isSelected && !isCorrectAnswer)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.cancel_rounded, color: AppColors.error, size: 20),
                  ),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: isJapaneseText
                        ? AppTheme.jpTextStyle(fontSize: 22, color: colors.text)
                        : TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colors.text,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _OptionColors _resolveColors() {
    if (showResult) {
      if (isCorrectAnswer) {
        return const _OptionColors(
          background: Color(0xFFE4EFDF),
          border: AppColors.success,
          text: AppColors.sageDeep,
        );
      }
      if (isSelected) {
        return const _OptionColors(
          background: Color(0xFFF6E1DC),
          border: AppColors.error,
          text: AppColors.clayDark,
        );
      }
      return const _OptionColors(
        background: AppColors.sandSurface,
        border: AppColors.stone,
        text: AppColors.inkFaint,
      );
    }

    if (isSelected) {
      return const _OptionColors(
        background: AppColors.sagePale,
        border: AppColors.sage,
        text: AppColors.sageDeep,
      );
    }

    return const _OptionColors(
      background: AppColors.sandSurface,
      border: AppColors.stone,
      text: AppColors.ink,
    );
  }
}

class _OptionColors {
  const _OptionColors({
    required this.background,
    required this.border,
    required this.text,
  });

  final Color background;
  final Color border;
  final Color text;
}
