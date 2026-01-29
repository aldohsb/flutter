import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:zentime/providers/timer_provider.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/providers/overlay_provider.dart';
import 'package:zentime/utils/time_formatter.dart';
import 'dart:io';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<OverlayProvider>(
      builder: (context, overlayProvider, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: MouseRegion(
            onEnter: (_) async {
              // Disable click-through when mouse enters
              if (overlayProvider.isClickThrough) {
                await windowManager.setIgnoreMouseEvents(false);
              }
            },
            onExit: (_) async {
              // Enable click-through when mouse exits
              if (overlayProvider.isClickThrough) {
                await windowManager.setIgnoreMouseEvents(true);
              }
            },
            child: GestureDetector(
              onPanStart: (_) async {
                if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                  await windowManager.startDragging();
                }
              },
              onDoubleTap: () {
                overlayProvider.toggleClickThrough();
              },
              onSecondaryTap: () {
                _showContextMenu(context);
              },
              child: Center(
                child: Consumer2<TimerProvider, ProjectProvider>(
                  builder: (context, timerProvider, projectProvider, child) {
                    final activeSession = timerProvider.activeSession;
                    
                    if (activeSession == null) {
                      return _buildInactiveTimer(context, overlayProvider.isClickThrough);
                    }
                    
                    final project = projectProvider.getProject(activeSession.projectId);
                    final projectName = project?.name ?? 'Unknown';
                    
                    return _buildActiveTimer(
                      context,
                      projectName,
                      timerProvider.elapsedSeconds,
                      timerProvider.isRunning,
                      overlayProvider.isClickThrough,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildActiveTimer(
    BuildContext context,
    String projectName,
    int seconds,
    bool isRunning,
    bool isClickThrough,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.25),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRunning 
              ? Colors.green.withOpacity(0.4) 
              : Colors.orange.withOpacity(0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            projectName,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            TimeFormatter.formatDuration(seconds),
            style: TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              height: 1.0,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isRunning ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (isRunning ? Colors.green : Colors.orange)
                          .withOpacity(0.7),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                isRunning ? 'Running' : 'Paused',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isClickThrough) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Click-through ON',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildInactiveTimer(BuildContext context, bool isClickThrough) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.25),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_off,
            color: Colors.white.withOpacity(0.9),
            size: 48,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'No Timer',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Right-click for options',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          if (isClickThrough) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Click-through ON',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  void _showContextMenu(BuildContext context) {
    final overlayProvider = context.read<OverlayProvider>();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromCenter(
          center: overlay.localToGlobal(overlay.size.center(Offset.zero)),
          width: 200,
          height: 100,
        ),
        Offset.zero & overlay.size,
      ),
      color: const Color(0xFF2D2D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      items: [
        PopupMenuItem(
          value: 'clickthrough',
          height: 48,
          child: Row(
            children: [
              Icon(
                overlayProvider.isClickThrough ? Icons.touch_app : Icons.touch_app_outlined,
                size: 20,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(width: 12),
              Text(
                overlayProvider.isClickThrough ? 'Disable Click-through' : 'Enable Click-through',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'normal',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.fullscreen_exit, size: 20, color: Colors.white.withOpacity(0.9)),
              const SizedBox(width: 12),
              const Text(
                'Normal Mode (Ctrl+Shift+N)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'exit',
          height: 48,
          child: Row(
            children: [
              Icon(Icons.close, size: 20, color: Colors.red.withOpacity(0.9)),
              const SizedBox(width: 12),
              const Text(
                'Exit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'clickthrough') {
        await overlayProvider.toggleClickThrough();
        if (overlayProvider.isClickThrough) {
          await windowManager.setIgnoreMouseEvents(true);
        } else {
          await windowManager.setIgnoreMouseEvents(false);
        }
      } else if (value == 'normal') {
        await overlayProvider.setOverlayMode(false);
        await windowManager.setIgnoreMouseEvents(false);
      } else if (value == 'exit') {
        if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
          await windowManager.destroy();
        }
      }
    });
  }
}