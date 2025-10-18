import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';
import '../quiz/quiz_screen.dart';
import '../stats/advanced_stats_screen.dart';
import '../settings/settings_screen.dart';
import '../user_selection/user_selection_screen.dart';
import '../../widgets/common/star_widget.dart';
import '../../models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                MaterialPageRoute(builder: (_) => AdvancedStatsScreen()),
              );
            },
            icon: Icon(Icons.analytics),
            tooltip: 'Statistics',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Switch User'),
                  content: Text('Do you want to switch to another user?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => UserSelectionScreen(),
                          ),
                        );
                      },
                      child: Text('Switch'),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.person),
            tooltip: 'Switch User',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Levels'),
            Tab(text: 'Statistics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLevelsTab(),
          StatisticsTab(),
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
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Card
              _buildProgressCard(userProvider.currentUser),
              SizedBox(height: AppSpacing.xxl),

              // Levels Grid
              Text(
                'Hiragana (Level 1-40)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(1, 40, highestLevel, progressProvider),
              SizedBox(height: AppSpacing.xxl),

              Text(
                'Katakana (Level 41-80)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(41, 80, highestLevel, progressProvider),
              SizedBox(height: AppSpacing.xxl),

              Text(
                'Kanji (Level 81-200)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: AppSpacing.lg),
              _buildLevelsGrid(81, 120, highestLevel, progressProvider),
              SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressCard(UserProfile? user) {
    if (user == null) return SizedBox();

    return Card(
      color: AppColors.primaryLight,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
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
                      'Current Level',
                      style: TextStyle(
                        color: AppColors.textMid,
                        fontSize: AppFontSizes.md,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      user.currentLevel.toString(),
                      style: TextStyle(
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
                    Text(
                      'Total Stars',
                      style: TextStyle(
                        color: AppColors.textMid,
                        fontSize: AppFontSizes.md,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.accentGold, size: 24),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          user.totalStars.toString(),
                          style: TextStyle(
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
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    stars,
                    (index) => Icon(
                      Icons.star,
                      size: 12,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
              ],
              if (!isUnlocked)
                Icon(Icons.lock, size: 16, color: AppColors.textLight),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.currentUser;
          if (user == null) return SizedBox();

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
                        MaterialPageRoute(builder: (_) => AdvancedStatsScreen()),
                      );
                    },
                    child: Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              _buildStatCard(
                label: 'Current Level',
                value: user.currentLevel.toString(),
                icon: Icons.trending_up,
              ),
              _buildStatCard(
                label: 'Total Stars',
                value: user.totalStars.toString(),
                icon: Icons.star,
              ),
              _buildStatCard(
                label: 'Accuracy',
                value: '${user.accuracy.toStringAsFixed(1)}%',
                icon: Icons.check_circle,
              ),
              _buildStatCard(
                label: 'Questions Answered',
                value: user.totalQuestions.toString(),
                icon: Icons.help,
              ),
              _buildStatCard(
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
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.lg),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryMain, size: 32),
            SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: AppColors.textMid),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: AppFontSizes.xl,
                      fontWeight: FontWeight.w700,
                    ),
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