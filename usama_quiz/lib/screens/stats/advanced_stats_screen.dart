import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';
import '../../models/models.dart';


class AdvancedStatsScreen extends StatelessWidget {
  const AdvancedStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Statistics'),
      ),
      body: Consumer2<UserProvider, ProgressProvider>(
        builder: (context, userProvider, progressProvider, _) {
          final user = userProvider.currentUser;
          if (user == null) return const SizedBox();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall Stats Card
                _buildOverallStatsCard(context, user),
                const SizedBox(height: AppSpacing.xxl),

                // Category Progress
                _buildSectionTitle(context, 'Category Progress'),
                _buildCategoryProgress(context, progressProvider),
                const SizedBox(height: AppSpacing.xxl),

                // Level Breakdown
                _buildSectionTitle(context, 'Level Statistics'),
                _buildLevelBreakdown(context, progressProvider),
                const SizedBox(height: AppSpacing.xxl),

                // Performance Metrics
                _buildSectionTitle(context, 'Performance'),
                _buildPerformanceMetrics(context, user),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverallStatsCard(BuildContext context, UserProfile user) {
    return Card(
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            // 4-column stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(
                  context: context,
                  label: 'Levels Passed',
                  value: user.currentLevel.toString(),
                  icon: Icons.trending_up,
                ),
                _buildStatColumn(
                  context: context,
                  label: 'Total Stars',
                  value: user.totalStars.toString(),
                  icon: Icons.star,
                ),
                _buildStatColumn(
                  context: context,
                  label: 'Questions',
                  value: user.totalQuestions.toString(),
                  icon: Icons.help,
                ),
                _buildStatColumn(
                  context: context,
                  label: 'Accuracy',
                  value: '${user.accuracy.toStringAsFixed(1)}%',
                  icon: Icons.check_circle,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // Progress bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.circle),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.circle),
                child: LinearProgressIndicator(
                  value: (user.currentLevel / 200),
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Level ${user.currentLevel} of 200',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppFontSizes.sm,
                color: AppColors.textMid,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryDark, size: 24),
        const SizedBox(height: AppSpacing.sm),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppFontSizes.xl,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppFontSizes.sm,
            color: AppColors.textMid,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryProgress(
    BuildContext context,
    ProgressProvider progressProvider,
  ) {
    return Column(
      children: [
        _buildCategoryProgressItem(
          context: context,
          category: 'Hiragana',
          levelRange: '1-40',
          color: AppColors.primaryMain,
          progress: 0.35,
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildCategoryProgressItem(
          context: context,
          category: 'Katakana',
          levelRange: '41-80',
          color: AppColors.secondaryOlive,
          progress: 0.15,
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildCategoryProgressItem(
          context: context,
          category: 'Kanji',
          levelRange: '81-200',
          color: AppColors.accentCyan,
          progress: 0.05,
        ),
      ],
    );
  }

  Widget _buildCategoryProgressItem({
    required BuildContext context,
    required String category,
    required String levelRange,
    required Color color,
    required double progress,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      levelRange,
                      style: const TextStyle(
                        fontSize: AppFontSizes.sm,
                        color: AppColors.textMid,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: AppFontSizes.lg,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.circle),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.greyLight,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelBreakdown(
    BuildContext context,
    ProgressProvider progressProvider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLevelStatRow(
              label: 'Total Levels',
              value: '200',
            ),
            const Divider(height: AppSpacing.xl),
            _buildLevelStatRow(
              label: 'Levels Completed',
              value: progressProvider.highestLevel.toString(),
            ),
            const Divider(height: AppSpacing.xl),
            _buildLevelStatRow(
              label: 'Levels Remaining',
              value: (200 - progressProvider.highestLevel).toString(),
            ),
            const Divider(height: AppSpacing.xl),
            _buildLevelStatRow(
              label: 'Completion',
              value: '${((progressProvider.highestLevel / 200) * 100).toStringAsFixed(1)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelStatRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppFontSizes.md,
            color: AppColors.textMid,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppFontSizes.md,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(BuildContext context, UserProfile user) {
    final accuracy = user.accuracy;
    String performanceLevel;
    Color performanceColor;

    if (accuracy >= 90) {
      performanceLevel = 'Excellent';
      performanceColor = AppColors.success;
    } else if (accuracy >= 75) {
      performanceLevel = 'Good';
      performanceColor = AppColors.accentCyan;
    } else if (accuracy >= 60) {
      performanceLevel = 'Fair';
      performanceColor = AppColors.warning;
    } else {
      performanceLevel = 'Needs Improvement';
      performanceColor = AppColors.error;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Level',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: performanceColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Text(
                    performanceLevel,
                    style: TextStyle(
                      color: performanceColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildMetricRow('Average Accuracy', '${accuracy.toStringAsFixed(1)}%'),
            _buildMetricRow(
              'Correct Answers',
              '${user.totalCorrect}/${user.totalQuestions}',
            ),
            _buildMetricRow(
              'Average Stars',
              '${(user.totalStars / (user.currentLevel == 1 ? 1 : user.currentLevel)).toStringAsFixed(2)} per level',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: AppFontSizes.md,
              color: AppColors.textMid,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppFontSizes.md,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}