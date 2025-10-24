import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/providers/timer_provider.dart';
import 'package:zentime/screens/home_screen.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:zentime/services/notification_service.dart';
import 'package:zentime/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await HiveService.init();
  
  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.requestPermissions();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
      ],
      child: MaterialApp(
        title: 'ZenTime',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}