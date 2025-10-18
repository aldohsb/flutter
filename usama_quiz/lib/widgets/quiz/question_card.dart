import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/models.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryLight,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Category badge
            Container(
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryMain,
                borderRadius: BorderRadius.circular(AppRadius.circle),
              ),
              child: Text(
                question.categoryType.toUpperCase(),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppFontSizes.sm,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxl),

            // Question type
            Text(
              question.type == 'romaji_to_aksara'
                  ? 'Romaji → Aksara'
                  : 'Aksara → Romaji',
              style: TextStyle(
                fontSize: AppFontSizes.md,
                color: AppColors.textMid,
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            // Question text
            Text(
              question.question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.textDark,
                  ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Large display of the aksara/romaji being asked
            Container(
              padding: EdgeInsets.all(AppSpacing.xxl),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.primaryMain,
                  width: 2,
                ),
              ),
              child: Text(
                question.type == 'romaji_to_aksara'
                    ? question.question
                        .split(': ')
                        .last
                    : question.question
                        .split(': ')
                        .last,
                style: TextStyle(
                  fontSize: AppFontSizes.huge,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                  fontFamily: question.categoryType == 'hiragana' ||
                          question.categoryType == 'katakana'
                      ? 'Noto Sans JP'
                      : 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}