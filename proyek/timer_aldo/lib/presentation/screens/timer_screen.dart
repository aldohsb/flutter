import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import '../providers/timer_provider.dart';
import '../providers/category_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/timer_display.dart';
import '../../data/services/system_tray_service.dart';
import '../../core/utils/window_helper.dart';
import 'statistics_screen.dart';
import 'category_screen.dart';
import 'settings_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});
  
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _setupSystemTray();
    _applySettings();
  }
  
  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }
  
  void _setupSystemTray() {
    final systemTray = context.read<SystemTrayService>();
    
    systemTray.onShow = () async {
      await WindowHelper.show();
      await WindowHelper.focus();
    };
    
    systemTray.onHide = () async {
      await WindowHelper.hide();
    };
    
    systemTray.onPauseResume = () {
      context.read<TimerProvider>().togglePause();
    };
    
    systemTray.onReset = () {
      context.read<TimerProvider>().reset();
    };
    
    systemTray.onStatistics = () async {
      await _navigateToStatistics();
    };
    
    systemTray.onCategories = () async {
      await _navigateToCategories();
    };
    
    systemTray.onSettings = () async {
      await _navigateToSettings();
    };
    
    systemTray.onExit = () {
      windowManager.destroy();
    };
  }
  
  Future<void> _applySettings() async {
    final settings = context.read<SettingsProvider>();
    await WindowHelper.setOpacity(settings.opacity);
    await WindowHelper.setAlwaysOnTop(settings.alwaysOnTop);
  }
  
  Future<void> _navigateToStatistics() async {
    await WindowHelper.setSize(const Size(900, 700));
    await WindowHelper.center();
    
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
      
      await WindowHelper.setSize(const Size(400, 200));
    }
  }
  
  Future<void> _navigateToCategories() async {
    await WindowHelper.setSize(const Size(600, 500));
    await WindowHelper.center();
    
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CategoryScreen()),
      );
      
      await WindowHelper.setSize(const Size(400, 200));
    }
  }
  
  Future<void> _navigateToSettings() async {
    await WindowHelper.setSize(const Size(600, 600));
    await WindowHelper.center();
    
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
      
      await WindowHelper.setSize(const Size(400, 200));
      await _applySettings();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
      body: Consumer3<TimerProvider, CategoryProvider, SettingsProvider>(
        builder: (context, timerProvider, categoryProvider, settingsProvider, _) {
          final selectedCategory = categoryProvider.selectedCategory;
          
          // Update system tray tooltip
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<SystemTrayService>().updateTooltip(
              'Timer Aldo - ${timerProvider.formattedTime}',
            );
          });
          
          return GestureDetector(
            onSecondaryTap: () async {
              await _showContextMenu();
            },
            child: Stack(
              children: [
                // Main timer display
                Center(
                  child: TimerDisplay(
                    time: timerProvider.formattedTime,
                    fontSize: settingsProvider.fontSize,
                    color: selectedCategory?.color,
                    isRunning: timerProvider.isRunning,
                  ),
                ),
                
                // Category indicator (small dot)
                if (selectedCategory != null)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              selectedCategory.icon,
                              size: 14,
                              color: selectedCategory.color,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              selectedCategory.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedCategory.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Future<void> _showContextMenu() async {
    final timerProvider = context.read<TimerProvider>();
    
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width / 2,
        overlay.size.height / 2,
        overlay.size.width / 2,
        overlay.size.height / 2,
      ),
      items: [
        if (timerProvider.isStopped)
          const PopupMenuItem(
            value: 'start',
            child: Row(
              children: [
                Icon(Icons.play_arrow, size: 18),
                SizedBox(width: 12),
                Text('Start'),
              ],
            ),
          ),
        if (timerProvider.isRunning)
          const PopupMenuItem(
            value: 'pause',
            child: Row(
              children: [
                Icon(Icons.pause, size: 18),
                SizedBox(width: 12),
                Text('Pause'),
              ],
            ),
          ),
        if (timerProvider.isPaused)
          const PopupMenuItem(
            value: 'resume',
            child: Row(
              children: [
                Icon(Icons.play_arrow, size: 18),
                SizedBox(width: 12),
                Text('Resume'),
              ],
            ),
          ),
        if (!timerProvider.isStopped) ...[
          const PopupMenuItem(
            value: 'stop',
            child: Row(
              children: [
                Icon(Icons.stop, size: 18),
                SizedBox(width: 12),
                Text('Stop & Save'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'reset',
            child: Row(
              children: [
                Icon(Icons.refresh, size: 18),
                SizedBox(width: 12),
                Text('Reset'),
              ],
            ),
          ),
        ],
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'statistics',
          child: Row(
            children: [
              Icon(Icons.bar_chart, size: 18),
              SizedBox(width: 12),
              Text('Statistics'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'categories',
          child: Row(
            children: [
              Icon(Icons.category_outlined, size: 18),
              SizedBox(width: 12),
              Text('Categories'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined, size: 18),
              SizedBox(width: 12),
              Text('Settings'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'exit',
          child: Row(
            children: [
              Icon(Icons.exit_to_app, size: 18),
              SizedBox(width: 12),
              Text('Exit'),
            ],
          ),
        ),
      ],
    );
    
    if (position != null && mounted) {
      switch (position) {
        case 'start':
          timerProvider.start();
          break;
        case 'pause':
          timerProvider.pause();
          break;
        case 'resume':
          timerProvider.resume();
          break;
        case 'stop':
          await timerProvider.stop();
          break;
        case 'reset':
          timerProvider.reset();
          break;
        case 'statistics':
          await _navigateToStatistics();
          break;
        case 'categories':
          await _navigateToCategories();
          break;
        case 'settings':
          await _navigateToSettings();
          break;
        case 'exit':
          await windowManager.destroy();
          break;
      }
    }
  }
}
