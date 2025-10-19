import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/word_model.dart';
import '../models/level_model.dart';
import '../models/progress_model.dart';
import '../data/database_helper.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import '../widgets/quiz_option.dart';
import '../widgets/star_display.dart';

enum QuizType {
  arabicToIndonesian,
  indonesianToArabic,
}

class QuizQuestion {
  final WordModel correctWord;
  final List<String> options;
  final int correctIndex;
  final QuizType type;

  QuizQuestion({
    required this.correctWord,
    required this.options,
    required this.correctIndex,
    required this.type,
  });
}

class QuizScreen extends StatefulWidget {
  final UserModel user;
  final int levelNumber;

  const QuizScreen({
    super.key,
    required this.user,
    required this.levelNumber,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late LevelModel _level;
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  bool _isLoading = true;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: AppTheme.mediumAnimation,
      vsync: this,
    );
    _initializeQuiz();
  }

  Future<void> _initializeQuiz() async {
    _level = LevelModel.generate(widget.levelNumber);
    _questions = await _generateQuestions();
    setState(() {
      _isLoading = false;
    });
    _animController.forward();
  }

  Future<List<QuizQuestion>> _generateQuestions() async {
    final words = DatabaseHelper.instance.getWordsForLevel(widget.levelNumber);
    final allWords = DatabaseHelper.instance.getWordsByRankRange(_level.startRank, _level.endRank);
    final random = Random();
    final questions = <QuizQuestion>[];

    for (var word in words) {
      // Randomly choose quiz type
      final quizType = random.nextBool() ? QuizType.arabicToIndonesian : QuizType.indonesianToArabic;
      
      // Get wrong options
      final wrongWords = allWords.where((w) => w.id != word.id).toList();
      wrongWords.shuffle();
      final wrongOptions = wrongWords.take(3).toList();

      // Generate options with transliteration for Arabic
      List<String> options;
      if (quizType == QuizType.arabicToIndonesian) {
        options = [
          word.indonesian,
          ...wrongOptions.map((w) => w.indonesian),
        ];
      } else {
        // For Arabic answers, include transliteration
        options = [
          '${word.arabic}\n(${word.transliteration})',
          ...wrongOptions.map((w) => '${w.arabic}\n(${w.transliteration})'),
        ];
      }

      // Shuffle options and find correct index
      final correctOption = options[0];
      options.shuffle();
      final correctIndex = options.indexOf(correctOption);

      questions.add(QuizQuestion(
        correctWord: word,
        options: options,
        correctIndex: correctIndex,
        type: quizType,
      ));
    }

    return questions;
  }

  Future<void> _selectOption(int index) async {
    if (_isAnswered) return;

    setState(() {
      _selectedOptionIndex = index;
      _isAnswered = true;
    });

    final isCorrect = index == _questions[_currentQuestionIndex].correctIndex;

    if (isCorrect) {
      _correctAnswers++;
      await AudioService.instance.playCorrectSound();
    } else {
      await AudioService.instance.playWrongSound();
    }

    // Wait before moving to next question
    await Future.delayed(const Duration(milliseconds: 1500));

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      });
      _animController.reset();
      _animController.forward();
    } else {
      _showResultDialog();
    }
  }

  Future<void> _showResultDialog() async {
    final stars = _level.calculateStars(_correctAnswers);
    final isPassed = _level.isPassed(_correctAnswers);

    if (isPassed) {
      await AudioService.instance.playSuccessSound();
    } else {
      await AudioService.instance.playFailSound();
    }

    // Save progress
    final progress = ProgressModel(
      userId: widget.user.id,
      levelNumber: widget.levelNumber,
      correctAnswers: _correctAnswers,
      totalQuestions: _level.totalQuestions,
      stars: stars,
      isPassed: isPassed,
      completedAt: DateTime.now(),
    );
    await StorageService.instance.saveProgress(progress);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _ResultDialog(
        correctAnswers: _correctAnswers,
        totalQuestions: _level.totalQuestions,
        stars: stars,
        isPassed: isPassed,
        levelNumber: widget.levelNumber,
        onRetry: () {
          Navigator.pop(context);
          setState(() {
            _currentQuestionIndex = 0;
            _correctAnswers = 0;
            _selectedOptionIndex = null;
            _isAnswered = false;
          });
          _initializeQuiz();
        },
        onNext: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  OptionState _getOptionState(int index) {
    if (!_isAnswered) {
      return OptionState.normal;
    }

    final correctIndex = _questions[_currentQuestionIndex].correctIndex;
    
    if (index == correctIndex) {
      return OptionState.correct;
    }
    
    if (index == _selectedOptionIndex) {
      return OptionState.wrong;
    }

    return OptionState.normal;
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Level ${widget.levelNumber}')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar dari Kuis?'),
            content: const Text('Progress tidak akan disimpan jika keluar sekarang.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: AppTheme.wrongRed),
                child: const Text('Keluar'),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Level ${widget.levelNumber}'),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: AppTheme.gardenDecoration,
          child: Column(
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.paleGreen,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                minHeight: 6,
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: FadeTransition(
                    opacity: _animController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: AppTheme.arabianCardDecoration,
                          child: Column(
                            children: [
                              Text(
                                question.type == QuizType.arabicToIndonesian
                                    ? 'Apa arti dari:'
                                    : 'Bahasa Arab dari:',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.textLight,
                                    ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Question Text
                              Text(
                                question.type == QuizType.arabicToIndonesian
                                    ? question.correctWord.arabic
                                    : question.correctWord.indonesian,
                                style: question.type == QuizType.arabicToIndonesian
                                    ? AppTheme.arabicTextStyle.copyWith(fontSize: 40)
                                    : Theme.of(context).textTheme.displaySmall,
                                textAlign: TextAlign.center,
                              ),
                              
                              if (question.type == QuizType.arabicToIndonesian) ...[
                                const SizedBox(height: 8),
                                Text(
                                  question.correctWord.transliteration,
                                  style: AppTheme.transliterationStyle.copyWith(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Options
                        ...List.generate(
                          question.options.length,
                          (index) => QuizOption(
                            option: question.options[index],
                            label: String.fromCharCode(65 + index), // A, B, C, D
                            state: _getOptionState(index),
                            onTap: () => _selectOption(index),
                            isArabic: question.type == QuizType.indonesianToArabic,
                          ),
                        ),

                        // Score Display
                        const SizedBox(height: 24),
                        
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: AppTheme.cardShadow,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _ScoreItem(
                                icon: Icons.check_circle,
                                label: 'Benar',
                                value: _correctAnswers.toString(),
                                color: AppTheme.correctGreen,
                              ),
                              _ScoreItem(
                                icon: Icons.cancel,
                                label: 'Salah',
                                value: (_currentQuestionIndex - _correctAnswers + (_isAnswered ? 1 : 0)).toString(),
                                color: AppTheme.wrongRed,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ScoreItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textLight,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ResultDialog extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int stars;
  final bool isPassed;
  final int levelNumber;
  final VoidCallback onRetry;
  final VoidCallback onNext;

  const _ResultDialog({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.stars,
    required this.isPassed,
    required this.levelNumber,
    required this.onRetry,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions * 100).toInt();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: isPassed ? AppTheme.primaryGradient : null,
          color: isPassed ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPassed ? AppTheme.textWhite : AppTheme.wrongRed.withValues(alpha: 0.1),
              ),
              child: Icon(
                isPassed ? Icons.emoji_events : Icons.refresh,
                size: 40,
                color: isPassed ? AppTheme.accentGold : AppTheme.wrongRed,
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              isPassed ? 'مُبَارَكٌ!' : 'جَرِّبْ مَرَّةً أُخْرَى',
              style: AppTheme.arabicTextStyle.copyWith(
                fontSize: 28,
                color: isPassed ? AppTheme.textWhite : AppTheme.textDark,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              isPassed ? 'Level Selesai!' : 'Belum Lulus',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: isPassed ? AppTheme.textWhite : AppTheme.textDark,
                  ),
            ),

            const SizedBox(height: 24),

            // Stars
            if (isPassed)
              StarDisplay(
                stars: stars,
                size: 32,
                color: AppTheme.textWhite,
              ),

            const SizedBox(height: 24),

            // Stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isPassed ? AppTheme.textWhite.withValues(alpha: 0.2) : AppTheme.paleGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _ResultRow(
                    label: 'Skor',
                    value: '$correctAnswers/$totalQuestions',
                    isWhite: isPassed,
                  ),
                  const SizedBox(height: 8),
                  _ResultRow(
                    label: 'Persentase',
                    value: '$percentage%',
                    isWhite: isPassed,
                  ),
                  if (isPassed) ...[
                    const SizedBox(height: 8),
                    _ResultRow(
                      label: 'Bintang',
                      value: '$stars/3',
                      isWhite: isPassed,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            if (isPassed) ...[
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.textWhite,
                  foregroundColor: AppTheme.primaryGreen,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Lanjut'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textWhite,
                ),
                child: const Text('Ulangi Level'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Coba Lagi'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onNext,
                child: const Text('Kembali'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isWhite;

  const _ResultRow({
    required this.label,
    required this.value,
    required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isWhite ? AppTheme.textWhite : AppTheme.textDark,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isWhite ? AppTheme.textWhite : AppTheme.primaryGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}