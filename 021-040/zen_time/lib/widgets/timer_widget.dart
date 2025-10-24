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
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryDark,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isRunning ? Colors.red : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isRunning ? 'Running' : 'Paused',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              Text(
                project.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              Text(
                TimeFormatter.formatDuration(timerProvider.elapsedSeconds),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isRunning)
                    _ActionButton(
                      onPressed: () async {
                        await timerProvider.pauseTimer();
                      },
                      icon: Icons.pause,
                      label: 'Pause',
                      backgroundColor: Colors.white,
                      foregroundColor: AppConstants.primaryColor,
                    )
                  else
                    _ActionButton(
                      onPressed: () async {
                        await timerProvider.resumeTimer(project.name);
                      },
                      icon: Icons.play_arrow,
                      label: 'Resume',
                      backgroundColor: Colors.white,
                      foregroundColor: AppConstants.primaryColor,
                    ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    onPressed: () => _showStopConfirmation(context, timerProvider),
                    icon: Icons.stop,
                    label: 'Stop',
                    backgroundColor: AppConstants.errorColor,
                    foregroundColor: Colors.white,
                  ),
                ],
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