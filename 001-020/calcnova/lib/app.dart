import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'theme/app_colors.dart';

class CalcNovaApp extends StatelessWidget {
  const CalcNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalcNova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundStart,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.glowNova,
          brightness: Brightness.dark,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}