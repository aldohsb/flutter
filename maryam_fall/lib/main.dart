import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const MaryamFallApp());
}

class MaryamFallApp extends StatelessWidget {
  const MaryamFallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaryamFall',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const GameScreen(),
    );
  }
}