import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'gradient_scaffold_background.dart';
import 'level_progress.dart';
import 'quiz_category.dart';
import 'quiz_screen.dart';
import 'star_rating.dart';

/// Layar ringkasan hasil setelah menyelesaikan 10 soal pada satu level.
class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.category,
    required this.level,
    required this.correctCount,
    required this.totalQuestions,
  });

  final QuizCategory category;
  final int level;
  final int correctCount;
  final int totalQuestions;

  bool get _isPassed => correctCount >= kPassThreshold;
  int get _stars => LevelProgress.starsForScore(correctCount);
  bool get _hasNextLevel => level < kLevelsPerCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isPassed
                        ? AppColors.sage.withValues(alpha: 0.16)
                        : AppColors.clay.withValues(alpha: 0.14),
                    border: Border.all(
                      color: _isPassed ? AppColors.sage : AppColors.clay,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _isPassed ? Icons.check_rounded : Icons.refresh_rounded,
                    size: 56,
                    color: _isPassed ? AppColors.sageDeep : AppColors.clayDark,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  _isPassed ? 'Level Selesai!' : 'Belum Lulus',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink),
                ),
                const SizedBox(height: AppSpacing.sm),
                StarRating(stars: _stars, size: 32, spacing: 6),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '$correctCount dari $totalQuestions jawaban benar',
                  style: const TextStyle(fontSize: 15, color: AppColors.inkSoft, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _isPassed
                      ? '${category.displayName} • Level $level berhasil dilewati.'
                      : 'Minimal $kPassThreshold jawaban benar untuk lulus. Tetap tenang, coba lagi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: AppColors.inkFaint),
                ),
                const Spacer(flex: 3),
                if (_isPassed && _hasNextLevel)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(category: category, level: level + 1),
                          ),
                        );
                      },
                      child: const Text('Level Berikutnya'),
                    ),
                  ),
                if (_isPassed && _hasNextLevel) const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(category: category, level: level),
                        ),
                      );
                    },
                    child: const Text('Ulangi Level'),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Kembali ke Daftar Level'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
