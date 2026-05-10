import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/providers/timer_provider.dart';
import 'package:zentime/screens/add_edit_project_screen.dart';
import 'package:zentime/screens/edit_session_screen.dart';
import 'package:zentime/widgets/session_list_item.dart';
import 'package:zentime/widgets/progress_bar_widget.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'package:zentime/utils/constants.dart';
import 'package:zentime/services/hive_service.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;
  
  const ProjectDetailScreen({super.key, required this.projectId});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
        final project = projectProvider.getProject(projectId);
        
        if (project == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Project Not Found')),
            body: const Center(child: Text('Project not found')),
          );
        }
        
        final sessions = projectProvider.getProjectSessions(projectId);
        final todayDuration = projectProvider.getTodayDuration(projectId);
        final weekDuration = projectProvider.getWeekDuration(projectId);
        final todayProgress = projectProvider.getTodayProgress(projectId);
        final weekProgress = projectProvider.getWeekProgress(projectId);
        
        return Scaffold(
          appBar: AppBar(
            title: Text(project.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditProjectScreen(
                        projectId: projectId,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppConstants.surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Color(project.colorValue),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            project.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (project.description != null &&
                        project.description!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        project.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${TimeFormatter.formatDurationToHours(todayDuration)} / ${project.dailyTargetHours.toStringAsFixed(1)}h',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ProgressBarWidget(
                          progress: todayProgress,
                          color: Color(project.colorValue),
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'This Week',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${TimeFormatter.formatDurationToHours(weekDuration)} / ${project.weeklyTargetHours.toStringAsFixed(1)}h',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ProgressBarWidget(
                          progress: weekProgress,
                          color: Color(project.colorValue),
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sessions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${sessions.length} total',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              Expanded(
                child: sessions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No sessions yet',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start a timer to track time',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          final session = sessions[index];
                          return SessionListItem(
                            session: session,
                            onEdit: session.isRunning
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditSessionScreen(
                                          sessionId: session.id,
                                        ),
                                      ),
                                    );
                                  },
                            onDelete: () async {
                              await HiveService.deleteSession(session.id);
                              projectProvider.loadProjects();
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              final isThisProjectRunning = 
                  timerProvider.activeSession?.projectId == projectId;
              final hasActiveSession = timerProvider.activeSession != null;
              
              return FloatingActionButton.extended(
                onPressed: (isThisProjectRunning || hasActiveSession)
                    ? null
                    : () async {
                        await timerProvider.startTimer(projectId, project.name);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                icon: Icon(
                  isThisProjectRunning ? Icons.timer : Icons.play_arrow,
                ),
                label: Text(
                  isThisProjectRunning 
                      ? 'Running' 
                      : hasActiveSession 
                          ? 'Another Running' 
                          : 'Start Timer'
                ),
                backgroundColor: (isThisProjectRunning || hasActiveSession)
                    ? Colors.grey
                    : AppConstants.primaryColor,
              );
            },
          ),
        );
      },
    );
  }
}