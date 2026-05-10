import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/models/project_model.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'package:zentime/widgets/progress_bar_widget.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  final bool isCompact;
  
  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.isCompact = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
        final todayDuration = projectProvider.getTodayDuration(project.id);
        final weekDuration = projectProvider.getWeekDuration(project.id);
        final todayProgress = projectProvider.getTodayProgress(project.id);
        final weekProgress = projectProvider.getWeekProgress(project.id);
        
        // Always use compact mode for consistency
        return _CompactCard(
          project: project,
          todayDuration: todayDuration,
          weekDuration: weekDuration,
          todayProgress: todayProgress,
          weekProgress: weekProgress,
          onTap: onTap,
        );
      },
    );
  }
}

class _CompactCard extends StatelessWidget {
  final ProjectModel project;
  final int todayDuration;
  final int weekDuration;
  final double todayProgress;
  final double weekProgress;
  final VoidCallback onTap;
  
  const _CompactCard({
    required this.project,
    required this.todayDuration,
    required this.weekDuration,
    required this.todayProgress,
    required this.weekProgress,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Color indicator
              Container(
                width: 5,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(project.colorValue),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: Color(project.colorValue).withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Project info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (project.description != null &&
                        project.description!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        project.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Progress indicators
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Today
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Today: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        TimeFormatter.formatDurationToHours(todayDuration),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(project.colorValue),
                        ),
                      ),
                      Text(
                        ' / ${project.dailyTargetHours.toStringAsFixed(1)}h',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Week: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        TimeFormatter.formatDurationToHours(weekDuration),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(project.colorValue),
                        ),
                      ),
                      Text(
                        ' / ${project.weeklyTargetHours.toStringAsFixed(1)}h',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullCard extends StatelessWidget {
  final ProjectModel project;
  final int todayDuration;
  final int weekDuration;
  final double todayProgress;
  final double weekProgress;
  final VoidCallback onTap;
  
  const _FullCard({
    required this.project,
    required this.todayDuration,
    required this.weekDuration,
    required this.todayProgress,
    required this.weekProgress,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(project.colorValue),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: Color(project.colorValue).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        if (project.description != null &&
                            project.description!.isNotEmpty)
                          Text(
                            project.description!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Today Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${TimeFormatter.formatDurationToHours(todayDuration)} / ${project.dailyTargetHours.toStringAsFixed(1)}h',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ProgressBarWidget(
                    progress: todayProgress,
                    color: Color(project.colorValue),
                    height: 8,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Week Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'This Week',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${TimeFormatter.formatDurationToHours(weekDuration)} / ${project.weeklyTargetHours.toStringAsFixed(1)}h',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ProgressBarWidget(
                    progress: weekProgress,
                    color: Color(project.colorValue),
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}