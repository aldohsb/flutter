import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/providers/timer_provider.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'package:zentime/utils/constants.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer2<TimerProvider, ProjectProvider>(
      builder: (context, timerProvider, projectProvider, child) {
        final activeSession = timerProvider.activeSession;
        
        if (activeSession == null) {
          return const SizedBox.shrink();
        }
        
        final project = projectProvider.getProject(activeSession.projectId);
        if (project == null) {
          return const SizedBox.shrink();
        }
        
        final isRunning = timerProvider.isRunning;
        
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryDark,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left: status dot + project name + timer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isRunning ? Colors.red : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            project.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      TimeFormatter.formatDuration(timerProvider.elapsedSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right: Stop button (tall)
              SizedBox(
                width: 56,
                child: ElevatedButton(
                  onPressed: () => _showStopConfirmation(context, timerProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.errorColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    minimumSize: const Size(56, 64),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stop, color: Colors.white, size: 22),
                      SizedBox(height: 2),
                      Text(
                        'Stop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _showStopConfirmation(BuildContext context, TimerProvider timerProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop Timer'),
        content: const Text('Are you sure you want to stop this timer? The session will be saved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await timerProvider.stopTimer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.errorColor,
            ),
            child: const Text('Stop'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  
  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: foregroundColor, size: 20),
      label: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 2,
      ),
    );
  }
}