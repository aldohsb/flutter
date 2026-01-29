import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'core/theme/app_theme.dart';
import 'data/services/storage_service.dart';
import 'data/services/system_tray_service.dart';
import 'data/repositories/timer_repository.dart';
import 'presentation/providers/timer_provider.dart';
import 'presentation/providers/category_provider.dart';
import 'presentation/providers/statistics_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/screens/timer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize storage
  final storageService = StorageService();
  await storageService.init();
  
  // Initialize window manager
  await windowManager.ensureInitialized();
  
  const windowOptions = WindowOptions(
    size: Size(400, 200),
    minimumSize: Size(300, 150),
    center: true,
    alwaysOnTop: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    backgroundColor: Colors.transparent,
  );
  
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  // Initialize hotkey manager
  await hotKeyManager.unregisterAll();
  
  // Initialize system tray
  final systemTrayService = SystemTrayService();
  await systemTrayService.init();
  
  // Initialize repository
  final timerRepository = TimerRepository(storageService);

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        Provider<SystemTrayService>.value(value: systemTrayService),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => StatisticsProvider(storageService),
        ),
        ChangeNotifierProxyProvider3<CategoryProvider, StatisticsProvider, SettingsProvider, TimerProvider>(
          create: (context) => TimerProvider(
            timerRepository,
            context.read<CategoryProvider>(),
            context.read<StatisticsProvider>(),
            context.read<SettingsProvider>(),
          ),
          update: (context, category, stats, settings, previous) =>
              previous ?? TimerProvider(timerRepository, category, stats, settings),
        ),
      ],
      child: const TimerAldoApp(),
    ),
  );
}

class TimerAldoApp extends StatelessWidget {
  const TimerAldoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Aldo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const TimerScreen(),
    );
  }
}
