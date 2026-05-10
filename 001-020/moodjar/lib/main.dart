import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(MoodJarApp());

class MoodJarApp extends StatelessWidget {
  const MoodJarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
