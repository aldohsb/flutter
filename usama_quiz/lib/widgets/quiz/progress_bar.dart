import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class QuizProgressBar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressBar({
    Key? key,
    required this.currentQuestion,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = (currentQuestion + 1) / totalQuestions;

    return Column(
      children: [
        // Progress bar
        Container(
          height: 8,
          color: AppColors.greyLight,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: AppColors.primaryMain,
                width: MediaQuery.of(context).size.width * progress,
              ),
            ),
          ),
        ),
        
        // Question counter
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${currentQuestion + 1}/$totalQuestions',
                style: TextStyle(
                  fontSize: AppFontSizes.md,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMid,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.circle),
                ),
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: AppFontSizes.sm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}