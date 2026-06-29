import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/habit_provider.dart';
import 'providers/weight_provider.dart';
import 'providers/earning_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

class HabitAldoApp extends StatefulWidget {
  const HabitAldoApp({super.key});

  @override
  State<HabitAldoApp> createState() => _HabitAldoAppState();
}

class _HabitAldoAppState extends State<HabitAldoApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initProviders();
  }

  Future<void> _initProviders() async {
    final hp = context.read<HabitProvider>();
    final wp = context.read<WeightProvider>();
    final ep = context.read<EarningProvider>();

    await Future.wait([
      hp.init(),
      wp.init(),
      ep.init(),
    ]);

    if (mounted) setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFFF0F4EF),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🌿', style: TextStyle(fontSize: 40)),
                SizedBox(height: 16),
                CircularProgressIndicator(
                  color: Color(0xFF4E7A47),
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Habit Aldo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => WeightProvider()),
        ChangeNotifierProvider(create: (_) => EarningProvider()),
      ],
      child: const HabitAldoApp(),
    );
  }
}
