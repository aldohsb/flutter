import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';
import '../results/results_screen.dart';
import '../../widgets/quiz/question_card.dart';
import '../../widgets/quiz/answer_option.dart';

class QuizScreen extends StatefulWidget {
  final int level;

  const QuizScreen({Key? key, required this.level}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() {
    context.read<QuizProvider>().initializeQuiz(widget.level);
  }

  void _handleAnswerSelected(String answer) {
    context.read<QuizProvider>().selectAnswer(answer);
    context.read<AudioProvider>().playTapSound();

    // Play correct/wrong sound
    Future.delayed(Duration(milliseconds: 300), () {
      final isCorrect = context.read<QuizProvider>().isCorrect;
      if (isCorrect == true) {
        context.read<AudioProvider>().playCorrectSound();
      } else if (isCorrect == false) {
        context.read<AudioProvider>().playWrongSound();
      }
    });
  }

  void _handleNextQuestion() {
    final quizProvider = context.read<QuizProvider>();
    if (quizProvider.currentQuestionIndex < quizProvider.questions.length - 1) {
      quizProvider.nextQuestion();
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    final quizProvider = context.read<QuizProvider>();
    final userProvider = context.read<UserProvider>();
    final progressProvider = context.read<ProgressProvider>();
    final audioProvider = context.read<AudioProvider>();

    // Get correct count from tracked answers
    final correctCount = quizProvider.getCorrectCount();
    final starsEarned = quizProvider.getStarsEarned();
    final isPassed = quizProvider.isPassed();

    if (isPassed) {
      audioProvider.playLevelCompleteSound();
    }

    // Save progress
    progressProvider.saveLevelProgress(
      userProvider.currentUsername!,
      widget.level,
      correctCount,
      AppConstants.questionsPerLevel,
      starsEarned,
    );

    // Navigate to results
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultsScreen(
          level: widget.level,
          correctCount: correctCount,
          totalQuestions: AppConstants.questionsPerLevel,
          isPassed: isPassed,
          starsEarned: starsEarned,
        ),
      ),
    );
  }

  void _handleQuit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quit Quiz'),
        content: Text('Your progress will not be saved. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              context.read<QuizProvider>().reset();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Quit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleQuit();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<QuizProvider>(
            builder: (context, quizProvider, _) => Text(
              'Level ${quizProvider.currentSession?.levelNumber}',
            ),
          ),
          leading: IconButton(
            onPressed: _handleQuit,
            icon: Icon(Icons.close),
          ),
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Consumer<QuizProvider>(
                  builder: (context, quizProvider, _) => Text(
                    '${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
                    style: TextStyle(
                      fontSize: AppFontSizes.lg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Consumer<QuizProvider>(
          builder: (context, quizProvider, _) {
            final question = quizProvider.currentQuestion;
            if (question == null) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // Progress bar
                Container(
                  height: 4,
                  color: AppColors.greyLight,
                  child: ClipRect(
                    child: Container(
                      color: AppColors.primaryMain,
                      width: MediaQuery.of(context).size.width *
                          (quizProvider.progress / 100),
                    ),
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: AppSpacing.lg),

                        // Question Card
                        QuestionCard(question: question),

                        SizedBox(height: AppSpacing.xxxl),

                        // Answer Options
                        ...question.options.asMap().entries.map((entry) {
                          final option = entry.value;
                          final isSelected =
                              quizProvider.selectedAnswer == option;
                          final isCorrect =
                              option == question.correctAnswer;

                          return Padding(
                            padding: EdgeInsets.only(bottom: AppSpacing.lg),
                            child: AnswerOption(
                              text: option,
                              isSelected: isSelected,
                              isCorrect: isCorrect &&
                                  quizProvider.isAnswered,
                              isWrong: isSelected &&
                                  !isCorrect &&
                                  quizProvider.isAnswered,
                              onTap: quizProvider.isAnswered
                                  ? null
                                  : () => _handleAnswerSelected(option),
                            ),
                          );
                        }).toList(),

                        SizedBox(height: AppSpacing.xxxl),

                        // Show explanation if answered
                        if (quizProvider.isAnswered) ...[
                          Container(
                            padding: EdgeInsets.all(AppSpacing.lg),
                            decoration: BoxDecoration(
                              color: quizProvider.isCorrect == true
                                  ? AppColors.success.withOpacity(0.1)
                                  : AppColors.error.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppRadius.lg),
                              border: Border.all(
                                color: quizProvider.isCorrect == true
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quizProvider.isCorrect == true
                                      ? '✓ Correct!'
                                      : '✗ Wrong!',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.lg,
                                    fontWeight: FontWeight.w700,
                                    color: quizProvider.isCorrect == true
                                        ? AppColors.success
                                        : AppColors.error,
                                  ),
                                ),
                                SizedBox(height: AppSpacing.md),
                                Text(
                                  question.explanation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                if (quizProvider.isCorrect == false) ...[
                                  SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Correct answer: ${question.correctAnswer}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: AppSpacing.xxl),
                        ],
                      ],
                    ),
                  ),
                ),

                // Next/Finish Button
                if (quizProvider.isAnswered)
                  Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: ElevatedButton(
                      onPressed: _handleNextQuestion,
                      child: Text(
                        quizProvider.currentQuestionIndex ==
                                quizProvider.questions.length - 1
                            ? 'Finish'
                            : 'Next',
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}