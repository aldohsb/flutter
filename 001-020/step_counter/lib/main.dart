import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/step_provider.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'config/theme_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage
  await StorageService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StepProvider()),
      ],
      child: MaterialApp(
        title: 'StepCounter',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}