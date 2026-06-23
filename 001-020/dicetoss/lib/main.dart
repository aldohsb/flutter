// ============================================================
// main.dart — konfigurasi app, tidak ada logika di sini.
// ============================================================

import 'package:flutter/material.dart';
import 'screens/dice_screen.dart';

void main() => runApp(const DicetossApp());

class DicetossApp extends StatelessWidget {
  const DicetossApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicetoss',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E)),
        useMaterial3: true,
      ),
      home: const DiceScreen(),
    );
  }
}