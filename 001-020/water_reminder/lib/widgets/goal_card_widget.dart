// Widget untuk menampilkan card goal individual

import 'package:flutter/material.dart';
import '../models/hydration_goal.dart';
import '../utils/constants.dart';

class GoalCardWidget extends StatelessWidget {
  // Properties yang required
  final HydrationGoal goal;
  final VoidCallback? onTap; // Callback saat card di-tap

  const GoalCardWidget({
    super.key,
    required this.goal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // InkWell untuk ripple effect saat di-tap
      child: InkWell(
        onTap: onTap,
        // borderRadius harus sama dengan card
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === HEADER SECTION ===
              Row(
                children: [
                  // Icon emoji dalam circle
                  _buildIconCircle(),
                  const SizedBox(width: AppConstants.paddingNormal),
                  
                  // Title dan description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          goal.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2, // Max 2 baris
                          overflow: TextOverflow.ellipsis, // ... jika kepanjangan
                        ),
                      ],
                    ),
                  ),
                  
                  // Points badge
                  _buildPointsBadge(context),
                ],
              ),
              
              const SizedBox(height: AppConstants.paddingNormal),
              
              // === PROGRESS SECTION ===
              Row(
                children: [
                  // Progress bar
                  Expanded(
                    child: _buildProgressBar(),
                  ),
                  const SizedBox(width: AppConstants.paddingSmall),
                  
                  // Progress text
                  Text(
                    '${goal.currentProgress}/${goal.target}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              // Completed badge (jika sudah selesai)
              if (goal.isCompleted) ...[
                const SizedBox(height: AppConstants.paddingSmall),
                _buildCompletedBadge(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Build icon circle dengan background color
  Widget _buildIconCircle() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        // Warna background berdasarkan status
        color: goal.isCompleted
            ? AppConstants.successColor.withValues(alpha: 0.2)
            : AppConstants.primaryColor.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          goal.icon,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  // Build points badge
  Widget _buildPointsBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSmall,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppConstants.accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            '${goal.points}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppConstants.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }

  // Build animated progress bar
  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 8,
        child: LinearProgressIndicator(
          // value 0.0 - 1.0
          value: goal.progressPercentage / 100,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            goal.isCompleted
                ? AppConstants.successColor
                : AppConstants.primaryColor,
          ),
        ),
      ),
    );
  }

  // Build completed badge
  Widget _buildCompletedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSmall,
        vertical: 4,
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
            size: 16,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            'Completed',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}