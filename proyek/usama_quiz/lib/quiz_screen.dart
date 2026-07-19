import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';
import 'gradient_scaffold_background.dart';
import 'progress_service.dart';
import 'quiz_category.dart';
import 'quiz_generator_service.dart';
import 'quiz_option_button.dart';
import 'quiz_question.dart';
import 'result_screen.dart';

/// Layar utama kuis: menampilkan 10 soal pilihan ganda satu per satu untuk
/// [category] pada [level], dengan arah soal (aksara<->latin) acak dan
/// feedback benar/salah langsung setelah menjawab.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.category, required this.level});

  final QuizCategory category;
  final int level;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizGeneratorService _generator = QuizGeneratorService();

  late final List<QuizQuestion> _questions;
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _showResult = false;
  int _correctCount = 0;
  Timer? _autoNextTimer;

  @override
  void initState() {
    super.initState();
    _questions = _generator.generateLevel(widget.category, widget.level);
  }

  @override
  void dispose() {
    _autoNextTimer?.cancel();
    super.dispose();
  }

  QuizQuestion get _currentQuestion => _questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex == _questions.length - 1;

  void _selectAnswer(String value) {
    if (_showResult) return;
    setState(() {
      _selectedAnswer = value;
      _showResult = true;
      if (value == _currentQuestion.correctAnswer) {
        _correctCount++;
      }
    });

    _autoNextTimer?.cancel();
    _autoNextTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      _goToNext();
    });
  }

  void _goToNext() {
    _autoNextTimer?.cancel();
    if (_isLastQuestion) {
      _finishQuiz();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedAnswer = null;
      _showResult = false;
    });
  }

  Future<void> _finishQuiz() async {
    final progressService = context.read<ProgressService>();
    await progressService.recordResult(
      category: widget.category,
      level: widget.level,
      correctCount: _correctCount,
    );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          category: widget.category,
          level: widget.level,
          correctCount: _correctCount,
          totalQuestions: _questions.length,
        ),
      ),
    );
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.sandSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres soal pada level ini belum tersimpan dan akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final isPromptJapanese = question.direction == QuestionDirection.scriptToRomaji;
    final instruction = isPromptJapanese
        ? 'Pilih bacaan latin yang tepat'
        : 'Pilih aksara yang tepat';

    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _confirmExit();
        if (shouldExit && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.category.displayName} • Level ${widget.level}'),
        ),
        body: GradientScaffoldBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: (_currentIndex + (_showResult ? 1 : 0)) / _questions.length,
                            minHeight: 8,
                            backgroundColor: AppColors.stone,
                            valueColor: const AlwaysStoppedAnimation(AppColors.sage),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${_currentIndex + 1}/${_questions.length}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.inkSoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    instruction,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: AppColors.inkFaint, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.sandSurface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.stone.withValues(alpha: 0.6)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      question.promptText,
                      style: isPromptJapanese
                          ? AppTheme.jpTextStyle(fontSize: 56, color: AppColors.sageDeep)
                          : const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: AppColors.sageDeep,
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Expanded(
                    child: ListView.separated(
                      itemCount: question.options.length,
                      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final optionValue = question.options[index];
                        return QuizOptionButton(
                          label: optionValue,
                          isJapaneseText: !isPromptJapanese,
                          isSelected: _selectedAnswer == optionValue,
                          isCorrectAnswer: optionValue == question.correctAnswer,
                          showResult: _showResult,
                          onTap: () => _selectAnswer(optionValue),
                        );
                      },
                    ),
                  ),
                  if (_showResult)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _goToNext,
                        child: Text(_isLastQuestion ? 'Lihat Hasil' : 'Lanjut'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}