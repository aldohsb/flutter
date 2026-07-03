import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';

class ChromatoApp extends StatelessWidget {
  const ChromatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chromato',
      debugShowCheckedModeBanner: false,
      // matikan banner debug pojok kanan atas
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}