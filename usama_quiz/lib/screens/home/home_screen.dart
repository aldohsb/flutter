import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../models/models.dart';
import '../../providers/app_providers.dart';
import '../quiz/quiz_screen.dart';
import '../stats/advanced_stats_screen.dart';
import '../settings/settings_screen.dart';
import '../user_selection/user_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserProvider>(
          builder: (context, userProvider, _) =>
              Text(userProvider.currentUsername ?? 'UsamaQuiz'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AdvancedStatsScreen()),
              );
            },
            icon: const Icon(Icons.analytics),
            tooltip: 'Statistics',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Switch User'),
                  content: const Text('Do you want to switch to another user?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const UserSelectionScreen(),
                          ),
                        );
                      },
                      child: const Text('Switch'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.person),
            tooltip: 'Switch User',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Levels'),
            Tab(text: 'Statistics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLevelsTab(),
          const StatisticsTab(),
        ],
      ),
    );
  }

  Widget _buildLevelsTab() {
    return Consumer2<UserProvider, ProgressProvider>(
      builder: (context, userProvider, progressProvider, _) {
        final username = userProvider.currentUsername ?? '';
        final highestLevel = progressProvider.highestLevel;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Card
              _buildProgressCard(userProvider.currentUser),
              const SizedBox(height: AppSpacing.xxl),

              // HIRAGANA: Levels 1-40
              Text(
                'Hiragana (Level 1-40)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(1, 40, highestLevel, progressProvider),
              const SizedBox(height: AppSpacing.xxl),

              // KATAKANA: Levels 41-80
              Text(
                'Katakana (Level 41-80)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(41, 80, highestLevel, progressProvider),
              const SizedBox(height: AppSpacing.xxl),

              // KANJI PART 1: Levels 81-120
              Text(
                'Kanji Part 1 (Level 81-120)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(81, 120, highestLevel, progressProvider),
              const SizedBox(height: AppSpacing.xxl),

              // KANJI PART 2: Levels 121-160
              Text(
                'Kanji Part 2 (Level 121-160)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(121, 160, highestLevel, progressProvider),
              const SizedBox(height: AppSpacing.xxl),

              // KANJI PART 3: Levels 161-200
              Text(
                'Kanji Part 3 (Level 161-200)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(161, 200, highestLevel, progressProvider),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressCard(UserProfile? user) {
    if (user == null) return const SizedBox();

    return Card(
      color: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Level',
                      style: TextStyle(
                        color: AppColors.textMid,
                        fontSize: AppFontSizes.md,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      user.currentLevel.toString(),
                      style: const TextStyle(
                        fontSize: AppFontSizes.huge,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Stars',
                      style: TextStyle(
                        color: AppColors.textMid,
                        fontSize: AppFontSizes.md,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.accentGold, size: 24),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          user.totalStars.toString(),
                          style: const TextStyle(
                            fontSize: AppFontSizes.xxl,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelsGrid(
    int startLevel,
    int endLevel,
    int highestLevel,
    ProgressProvider progressProvider,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1,
      ),
      itemCount: endLevel - startLevel + 1,
      itemBuilder: (context, index) {
        final level = startLevel + index;
        final isUnlocked = level <= highestLevel;
        final progress = progressProvider.getLevelProgress(level);

        return _buildLevelButton(
          level: level,
          isUnlocked: isUnlocked,
          stars: progress?.stars ?? 0,
          onTap: isUnlocked
              ? () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(level: level),
                    ),
                  )
              : null,
        );
      },
    );
  }

  Widget _buildLevelButton({
    required int level,
    required bool isUnlocked,
    required int stars,
    required VoidCallback? onTap,
  }) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            color: isUnlocked ? AppColors.greyLight : AppColors.greyMid,
            border: Border.all(
              color: isUnlocked ? AppColors.primaryMain : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                level.toString(),
                style: TextStyle(
                  fontSize: AppFontSizes.xxl,
                  fontWeight: FontWeight.w700,
                  color: isUnlocked ? AppColors.primaryDark : AppColors.textLight,
                ),
              ),
              if (stars > 0) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    stars,
                    (index) => const Icon(
                      Icons.star,
                      size: 12,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
              ],
              if (!isUnlocked)
                const Icon(Icons.lock, size: 16, color: AppColors.textLight),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.currentUser;
          if (user == null) return const SizedBox();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Statistics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AdvancedStatsScreen()),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildStatCard(
                context: context,
                label: 'Current Level',
                value: user.currentLevel.toString(),
                icon: Icons.trending_up,
              ),
              _buildStatCard(
                context: context,
                label: 'Total Stars',
                value: user.totalStars.toString(),
                icon: Icons.star,
              ),
              _buildStatCard(
                context: context,
                label: 'Accuracy',
                value: '${user.accuracy.toStringAsFixed(1)}%',
                icon: Icons.check_circle,
              ),
              _buildStatCard(
                context: context,
                label: 'Questions Answered',
                value: user.totalQuestions.toString(),
                icon: Icons.help,
              ),
              _buildStatCard(
                context: context,
                label: 'Correct Answers',
                value: user.totalCorrect.toString(),
                icon: Icons.check,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryMain, size: 32),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: AppColors.textMid),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}