import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/models/project_model.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'package:zentime/widgets/progress_bar_widget.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  
  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
        final todayDuration = projectProvider.getTodayDuration(project.id);
        final weekDuration = projectProvider.getWeekDuration(project.id);
        final todayProgress = projectProvider.getTodayProgress(project.id);
        final weekProgress = projectProvider.getWeekProgress(project.id);
        
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
                        width: 8,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(project.colorValue),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
      },
    );
  }
}