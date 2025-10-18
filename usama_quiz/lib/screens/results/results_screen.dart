import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';
import '../../widgets/common/star_widget.dart';
import '../home/home_screen.dart';

class ResultsScreen extends StatefulWidget {
  final int level;
  final int correctCount;
  final int totalQuestions;
  final bool isPassed;
  final int starsEarned;

  const ResultsScreen({
    Key? key,
    required this.level,
    required this.correctCount,
    required this.totalQuestions,
    required this.isPassed,
    required this.starsEarned,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    _slideController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _handleRetry() {
    context.read<QuizProvider>().reset();
    Navigator.of(context).pop();
  }

  void _handleContinue() {
    context.read<QuizProvider>().reset();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accuracy = (widget.correctCount / widget.totalQuestions * 100).toInt();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Top banner
              Container(
                color: widget.isPassed
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.warning.withOpacity(0.1),
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Icon(
                      widget.isPassed ? Icons.celebration : Icons.info,
                      color: widget.isPassed ? AppColors.success : AppColors.warning,
                      size: 28,
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Text(
                        widget.isPassed
                            ? 'Level Completed!'
                            : 'Level Not Passed',
                        style: TextStyle(
                          fontSize: AppFontSizes.lg,
                          fontWeight: FontWeight.w600,
                          color: widget.isPassed
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSpacing.xxxl),

                      // Level number
                      Text(
                        'Level ${widget.level}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),

                      SizedBox(height: AppSpacing.xl),

                      // Stars animation
                      ScaleTransition(
                        scale: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _scaleController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: AnimatedStarWidget(
                          starCount: widget.starsEarned,
                          size: 64,
                        ),
                      ),

                      SizedBox(height: AppSpacing.xxxl),

                      // Score card
                      Card(
                        color: AppColors.greyLight,
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.xxl),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildScoreStat(
                                    label: 'Correct',
                                    value: widget.correctCount.toString(),
                                    total: '/${widget.totalQuestions}',
                                    color: AppColors.success,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 2,
                                    color: AppColors.greyMid,
                                  ),
                                  _buildScoreStat(
                                    label: 'Accuracy',
                                    value: '$accuracy%',
                                    color: AppColors.accentCyan,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: AppSpacing.xxxl),

                      // Star thresholds explanation
                      Container(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Star Thresholds:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppFontSizes.md,
                              ),
                            ),
                            SizedBox(height: AppSpacing.md),
                            _buildThresholdRow('8/10 correct', 1),
                            _buildThresholdRow('9/10 correct', 2),
                            _buildThresholdRow('10/10 correct', 3),
                          ],
                        ),
                      ),

                      SizedBox(height: AppSpacing.xxxl),

                      // Pass/Fail message
                      if (!widget.isPassed)
                        Container(
                          padding: EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                            border: Border.all(
                              color: AppColors.warning,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Minimum 7 correct answers needed to pass',
                                style: TextStyle(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: AppSpacing.md),
                              Text(
                                'You got ${widget.correctCount}/10. Try again!',
                                style: TextStyle(
                                  color: AppColors.textMid,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom buttons
              Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!widget.isPassed)
                      ElevatedButton(
                        onPressed: _handleRetry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.warning,
                        ),
                        child: Text('Retry Level'),
                      ),
                    if (!widget.isPassed) SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: _handleContinue,
                      child: Text(
                        widget.isPassed ? 'Next Level' : 'Back to Home',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreStat({
    required String label,
    required String value,
    String? total,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMid,
            fontSize: AppFontSizes.md,
          ),
        ),
        SizedBox(height: AppSpacing.md),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: AppFontSizes.xxxl,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              if (total != null)
                TextSpan(
                  text: total,
                  style: TextStyle(
                    fontSize: AppFontSizes.lg,
                    color: AppColors.textMid,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThresholdRow(String label, int stars) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          StarWidget(starCount: stars, size: 20),
        ],
      ),
    );
  }
}