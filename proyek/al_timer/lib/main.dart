import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/timer_repository.dart';
import 'data/services/local_storage_service.dart';
import 'data/services/system_tray_service.dart';
import 'presentation/providers/timer_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/widgets/timer_display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize sqflite for Windows
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  
  // Initialize window manager
  await windowManager.ensureInitialized();
  
  // Initialize hotkey manager
  await hotKeyManager.unregisterAll();
  
  // Initialize services
  final localStorageService = LocalStorageService();
  await localStorageService.init();
  
  final timerRepository = TimerRepository(localStorageService);
  await timerRepository.init();
  
  final systemTrayService = SystemTrayService();
  
  // Configure window
  const windowOptions = WindowOptions(
    size: Size(300, 120),
    minimumSize: Size(200, 80),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(true);
    await windowManager.setHasShadow(false);
    await windowManager.show();
    await windowManager.focus();
  });
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(localStorageService),
        ),
        ChangeNotifierProvider(
          create: (context) => TimerProvider(
            timerRepository,
            context.read<SettingsProvider>(),
          ),
        ),
      ],
      child: const AlTimerApp(),
    ),
  );
  
  // Initialize system tray after app starts
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await systemTrayService.init();
  });
}

class AlTimerApp extends StatelessWidget {
  const AlTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'Al Timer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          home: const TimerHomeScreen(),
        );
      },
    );
  }
}

class TimerHomeScreen extends StatelessWidget {
  const TimerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    
    return Scaffold(
      backgroundColor: settings.isTransparent 
          ? Colors.transparent 
          : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
      body: const TimerDisplay(),
    );
  }
}