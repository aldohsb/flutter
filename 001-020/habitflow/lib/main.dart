import 'package:flutter/material.dart';                  // impor Material Design
import 'package:habitflow/screens/habit_screen.dart';    // impor layar utama — satu-satunya yang dibutuhkan main.dart

void main() => runApp(const HabitFlowApp());             // titik masuk app

class HabitFlowApp extends StatelessWidget {             // root widget — hanya konfigurasi, tidak ada logika
  const HabitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HabitFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HabitScreen(),                         // serahkan ke HabitScreen — main.dart tidak tahu detailnya
    );
  }
}