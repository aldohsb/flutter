// Goals screen - halaman untuk menampilkan dan manage goals

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/water_provider.dart';
import '../widgets/goal_card_widget.dart';
import '../utils/constants.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Goals'),
      ),
      body: Consumer<WaterProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // === TOTAL POINTS SECTION ===
                _buildPointsHeader(context, provider),
                
                const SizedBox(height: AppConstants.paddingLarge),
                
                // === GOALS SECTION ===
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingNormal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Goals',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppConstants.paddingNormal),
                      
                      // List of goals
                      _buildGoalsList(provider),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.paddingLarge),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build points header dengan trophy icon
  Widget _buildPointsHeader(BuildContext context, WaterProvider provider) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppConstants.paddingNormal),
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryColor,
            AppConstants.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Trophy icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 48,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingNormal),
          
          // Title
          const Text(
            'Total Points',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppConstants.fontSizeMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingSmall),
          
          // Points value
          Text(
            '${provider.totalPoints}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppConstants.fontSizeXXLarge * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: AppConstants.paddingSmall),
          
          // Subtitle
          Text(
            '${provider.goals.where((g) => g.isCompleted).length} / ${provider.goals.length} Goals Completed',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: AppConstants.fontSizeNormal,
            ),
          ),
        ],
      ),
    );
  }

  // Build list of goals
  Widget _buildGoalsList(WaterProvider provider) {
    // Jika tidak ada goals
    if (provider.goals.isEmpty) {
      return _buildEmptyState();
    }
    
    // Sort goals: incomplete first, then completed
    final sortedGoals = [...provider.goals]..sort((a, b) {
      // Completed goals di bawah
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      // Sort by progress percentage
      return b.progressPercentage.compareTo(a.progressPercentage);
    });
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedGoals.length,
      itemBuilder: (context, index) {
        final goal = sortedGoals[index];
        
        return GoalCardWidget(
          goal: goal,
          onTap: () => _showGoalDetails(context, provider, goal),
        );
      },
    );
  }

  // Build empty state
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge * 2),
      child: Column(
        children: [
          const Text(
            '🎯',
            style: TextStyle(fontSize: 80),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          const Text(
            'No Goals Yet',
            style: TextStyle(
              fontSize: AppConstants.fontSizeXLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Goals will be created automatically as you use the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConstants.fontSizeMedium,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Show goal details dialog
  void _showGoalDetails(
    BuildContext context,
    WaterProvider provider,
    dynamic goal,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(
              goal.icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: AppConstants.paddingSmall),
            Expanded(
              child: Text(
                goal.title,
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeLarge,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Text(
              goal.description,
              style: const TextStyle(
                fontSize: AppConstants.fontSizeMedium,
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingLarge),
            
            // Progress info
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingNormal),
              decoration: BoxDecoration(
                color: AppConstants.cardColor,
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusNormal,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${goal.currentProgress} / ${goal.target} days',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: goal.progressPercentage / 100,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        goal.isCompleted
                            ? AppConstants.successColor
                            : AppConstants.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.paddingNormal),
            
            // Points info
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppConstants.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '${goal.points} Points',
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeMedium,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.accentColor,
                  ),
                ),
              ],
            ),
            
            // Status
            if (goal.isCompleted) ...[
              const SizedBox(height: AppConstants.paddingNormal),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingNormal,
                  vertical: AppConstants.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.successColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Completed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          // Close button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          
          // Reset button (only if completed)
          if (goal.isCompleted)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showResetConfirmation(context, provider, goal);
              },
              child: const Text('Reset'),
            ),
        ],
      ),
    );
  }

  // Show reset confirmation dialog
  void _showResetConfirmation(
    BuildContext context,
    WaterProvider provider,
    dynamic goal,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Goal?'),
        content: Text(
          'Are you sure you want to reset "${goal.title}"? This will reset your progress to 0.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await provider.resetGoal(goal.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${goal.title} has been reset'),
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}