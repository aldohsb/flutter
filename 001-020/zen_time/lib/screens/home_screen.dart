import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/providers/overlay_provider.dart';
import 'package:zentime/screens/add_edit_project_screen.dart';
import 'package:zentime/screens/project_detail_screen.dart';
import 'package:zentime/screens/settings_screen.dart';
import 'package:zentime/widgets/project_card.dart';
import 'package:zentime/widgets/timer_widget.dart';
import 'package:zentime/widgets/reorderable_grid_view.dart';
import 'package:zentime/utils/constants.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    
    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        title: const Text('ZenTime'),
        actions: _buildActions(context),
      ),
      body: Column(
        children: [
          // Custom draggable title bar for desktop
          if (isDesktop) _buildCustomTitleBar(context),
          
          const TimerWidget(),
          
          // Statistics Summary
          Consumer<ProjectProvider>(
            builder: (context, projectProvider, child) {
              final projects = projectProvider.projects;
              
              int totalTodaySeconds = 0;
              int totalWeekSeconds = 0;
              
              for (var project in projects) {
                totalTodaySeconds += projectProvider.getTodayDuration(project.id);
                totalWeekSeconds += projectProvider.getWeekDuration(project.id);
              }
              
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppConstants.primaryColor.withOpacity(0.1),
                      AppConstants.accentColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppConstants.primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.today,
                        label: 'Today',
                        value: TimeFormatter.formatDurationToHours(totalTodaySeconds),
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppConstants.dividerColor,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.calendar_today,
                        label: 'This Week',
                        value: TimeFormatter.formatDurationToHours(totalWeekSeconds),
                        color: AppConstants.accentColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          // Projects Grid
          Expanded(
            child: Consumer<ProjectProvider>(
              builder: (context, projectProvider, child) {
                final projects = projectProvider.projects;
                
                if (projects.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No projects yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + to create your first project',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ReorderableGridView(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  itemCount: projects.length,
                  onReorder: (oldIndex, newIndex) {
                    projectProvider.reorderProjects(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return ProjectCard(
                      key: ValueKey(project.id),
                      project: project,
                      isCompact: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(
                              projectId: project.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditProjectScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildCustomTitleBar(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) async {
        await windowManager.startDragging();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppConstants.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Text(
              'ZenTime',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            ..._buildActions(context),
            const SizedBox(width: 8),
            // Window controls
            IconButton(
              icon: const Icon(Icons.minimize, size: 20),
              color: Colors.white,
              onPressed: () async {
                await windowManager.minimize();
              },
              tooltip: 'Minimize',
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              color: Colors.white,
              onPressed: () async {
                await windowManager.close();
              },
              tooltip: 'Close',
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
  
  List<Widget> _buildActions(BuildContext context) {
    final bool isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    
    return [
      if (isDesktop)
        IconButton(
          icon: const Icon(Icons.picture_in_picture_alt),
          tooltip: 'Overlay Mode',
          color: isDesktop ? Colors.white : null,
          onPressed: () {
            context.read<OverlayProvider>().toggleOverlayMode();
          },
        ),
      IconButton(
        icon: const Icon(Icons.settings),
        color: isDesktop ? Colors.white : null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.info_outline),
        color: isDesktop ? Colors.white : null,
        onPressed: () => _showInfo(context),
      ),
    ];
  }
  
  void _showInfo(BuildContext context) {
    final alarmInterval = HiveService.getSetting(
      'alarm_interval',
      defaultValue: AppConstants.alarmIntervalMinutes,
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About ZenTime'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ZenTime - Time Tracking App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Track your project time with zen focus.'),
            const SizedBox(height: 16),
            const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('• Multi-project tracking'),
            const Text('• Daily & weekly targets'),
            Text('• $alarmInterval-minute interval alarms (customizable)'),
            const Text('• Session management'),
            const Text('• Progress statistics'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}