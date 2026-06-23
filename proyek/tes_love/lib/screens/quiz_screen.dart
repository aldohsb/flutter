import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/option_tile.dart';
import '../widgets/progress_bar.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final confirmed = await _confirmExit(context);
        if (confirmed && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () async {
              final confirmed = await _confirmExit(context);
              if (confirmed && context.mounted) Navigator.of(context).pop();
            },
            tooltip: 'Keluar dari quiz',
          ),
          title: Consumer<UserProvider>(
            builder: (context, up, _) => Text(
              up.activeUser?.name ?? 'Quiz',
              style: AppTextStyles.headingMedium.copyWith(fontSize: 16),
            ),
          ),
        ),
        body: Consumer<QuizProvider>(
          builder: (context, quiz, _) {
            return SafeArea(
              child: Column(
                children: [
                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                    child: QuizProgressBar(
                      current: quiz.currentIndex + 1,
                      total: quiz.totalQuestions,
                    ),
                  ),

                  // Question card — scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: _QuestionCard(key: ValueKey(quiz.currentIndex)),
                    ),
                  ),

                  // Navigation buttons
                  _BottomNavBar(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Keluar dari Quiz?', style: AppTextStyles.headingMedium),
        content: Text(
          'Jawabanmu akan hilang jika keluar sekarang.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Lanjutkan Quiz', style: AppTextStyles.bodyMedium),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nomor soal
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Soal ${quiz.currentIndex + 1}',
            style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 16),

        // Pertanyaan
        Text(
          question.text,
          style: AppTextStyles.question,
        )
            .animate(key: ValueKey('q_${question.id}'))
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.05, end: 0, duration: 300.ms),

        const SizedBox(height: 28),

        // Pilihan jawaban
        Text(
          'Pilih satu yang paling mewakili kamu:',
          style: AppTextStyles.bodySmall.copyWith(
            letterSpacing: 0.3,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),

        ...List.generate(question.options.length, (i) {
          final option = question.options[i];
          final isSelected = quiz.currentAnswer == option.language;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OptionTile(
              key: ValueKey('opt_${question.id}_$i'),
              text: option.text,
              language: option.language,
              isSelected: isSelected,
              index: i,
              onTap: () => context.read<QuizProvider>().answer(option.language),
            ),
          );
        }),

        const SizedBox(height: 16),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
      child: Consumer<QuizProvider>(
        builder: (context, quiz, _) {
          return Row(
            children: [
              // Tombol Kembali
              if (quiz.currentIndex > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: quiz.previousQuestion,
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text('Kembali'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                )
              else
                const Expanded(child: SizedBox()),

              const SizedBox(width: 12),

              // Tombol Lanjut / Selesai
              Expanded(
                flex: 2,
                child: AnimatedOpacity(
                  opacity: quiz.hasAnswered ? 1.0 : 0.45,
                  duration: const Duration(milliseconds: 200),
                  child: ElevatedButton.icon(
                    onPressed: quiz.hasAnswered
                        ? () => _onNext(context, quiz)
                        : null,
                    icon: Icon(
                      quiz.isLastQuestion
                          ? Icons.check_rounded
                          : Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                    label: Text(quiz.isLastQuestion ? 'Lihat Hasil' : 'Lanjut'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      disabledBackgroundColor: AppColors.primary.withAlpha(120),
                      disabledForegroundColor: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onNext(BuildContext context, QuizProvider quiz) {
    if (quiz.isLastQuestion) {
      quiz.nextQuestion(); // triggers _finishQuiz internally
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ResultScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } else {
      quiz.nextQuestion();
    }
  }
}