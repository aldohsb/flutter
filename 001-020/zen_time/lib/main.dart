import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/providers/timer_provider.dart';
import 'package:zentime/providers/overlay_provider.dart';
import 'package:zentime/screens/home_screen.dart';
import 'package:zentime/screens/overlay_screen.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:zentime/services/notification_service.dart';
import 'package:zentime/services/system_tray_service.dart';
import 'package:zentime/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Window Manager (desktop)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    
    WindowOptions windowOptions = const WindowOptions(
      size: Size(450, 800),
      minimumSize: Size(400, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'ZenTime',
    );
    
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  
  // Initialize Hive
  await HiveService.init();
  
  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.requestPermissions();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  final SystemTrayService _trayService = SystemTrayService();
  
  @override
  void initState() {
    super.initState();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      windowManager.addListener(this);
      _initSystemTray();
      _registerHotkeys();
    }
  }
  
  @override
  void dispose() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      windowManager.removeListener(this);
      _unregisterHotkeys();
    }
    super.dispose();
  }
  
  Future<void> _registerHotkeys() async {
    await hotKeyManager.unregisterAll();
    
    // Ctrl+Shift+N - Normal Mode
    HotKey normalModeHotkey = HotKey(
      key: PhysicalKeyboardKey.keyN,
      modifiers: [HotKeyModifier.control, HotKeyModifier.shift],
      scope: HotKeyScope.system,
    );
    
    await hotKeyManager.register(
      normalModeHotkey,
      keyDownHandler: (_) async {
        if (mounted) {
          await context.read<OverlayProvider>().setOverlayMode(false);
          await windowManager.setIgnoreMouseEvents(false);
          await windowManager.show();
          await windowManager.focus();
        }
      },
    );
    
    // Ctrl+Shift+P - Pause/Resume Timer
    HotKey pauseResumeHotkey = HotKey(
      key: PhysicalKeyboardKey.keyP,
      modifiers: [HotKeyModifier.control, HotKeyModifier.shift],
      scope: HotKeyScope.system,
    );
    
    await hotKeyManager.register(
      pauseResumeHotkey,
      keyDownHandler: (_) async {
        if (mounted) {
          final timerProvider = context.read<TimerProvider>();
          final projectProvider = context.read<ProjectProvider>();
          
          if (timerProvider.isRunning) {
            await timerProvider.pauseTimer();
          } else if (timerProvider.activeSession != null) {
            final project = projectProvider.getProject(
              timerProvider.activeSession!.projectId,
            );
            if (project != null) {
              await timerProvider.resumeTimer(project.name);
            }
          }
        }
      },
    );
    
    // Ctrl+Shift+O - Toggle Overlay
    HotKey overlayHotkey = HotKey(
      key: PhysicalKeyboardKey.keyO,
      modifiers: [HotKeyModifier.control, HotKeyModifier.shift],
      scope: HotKeyScope.system,
    );
    
    await hotKeyManager.register(
      overlayHotkey,
      keyDownHandler: (_) async {
        if (mounted) {
          await context.read<OverlayProvider>().toggleOverlayMode();
        }
      },
    );
    
    debugPrint('✅ Hotkeys registered');
  }
  
  Future<void> _unregisterHotkeys() async {
    await hotKeyManager.unregisterAll();
  }
  
  Future<void> _initSystemTray() async {
    await _trayService.initialize(
      onShowNormal: () async {
        await windowManager.show();
        await windowManager.focus();
        if (mounted) {
          context.read<OverlayProvider>().setOverlayMode(false);
        }
      },
      onShowOverlay: () {
        if (mounted) {
          context.read<OverlayProvider>().setOverlayMode(true);
        }
      },
      onExit: () async {
        await windowManager.destroy();
      },
    );
  }
  
  @override
  void onWindowClose() async {
    // Minimize to tray instead of closing
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      await windowManager.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => OverlayProvider()),
      ],
      child: Consumer<OverlayProvider>(
        builder: (context, overlayProvider, child) {
          // Apply overlay mode window settings
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
            _applyOverlayMode(overlayProvider.isOverlayMode);
          }
          
          return MaterialApp(
            title: 'ZenTime',
            debugShowCheckedModeBanner: false,
            theme: overlayProvider.isOverlayMode
                ? _buildOverlayTheme()
                : AppTheme.theme,
            home: overlayProvider.isOverlayMode
                ? const OverlayScreen()
                : const HomeScreen(),
          );
        },
      ),
    );
  }
  
  Future<void> _applyOverlayMode(bool isOverlay) async {
    final overlayProvider = context.read<OverlayProvider>();
    
    if (isOverlay) {
      await windowManager.setSize(const Size(380, 220));
      await windowManager.setAlwaysOnTop(true);
      await windowManager.setSkipTaskbar(true);
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setBackgroundColor(Colors.transparent);
      
      // Apply click-through if enabled
      if (overlayProvider.isClickThrough) {
        await windowManager.setIgnoreMouseEvents(true);
      } else {
        await windowManager.setIgnoreMouseEvents(false);
      }
      
      await windowManager.show();
    } else {
      await windowManager.setSize(const Size(450, 800));
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setSkipTaskbar(false);
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setBackgroundColor(AppConstants.backgroundColor);
      await windowManager.setIgnoreMouseEvents(false);
      await windowManager.show();
    }
  }
  
  ThemeData _buildOverlayTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent,
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.black87,
        textStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}