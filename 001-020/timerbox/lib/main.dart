import 'package:flutter/material.dart';                  // impor Material Design
import 'package:timerbox/screens/timer_screen.dart';     // impor layar utama — satu-satunya yang dibutuhkan main.dart

void main() => runApp(const TimerBoxApp());              // titik masuk app

class TimerBoxApp extends StatelessWidget {              // root widget — hanya konfigurasi app, tidak ada logika
  const TimerBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimerBox',
      debugShowCheckedModeBanner: false,                 // hilangkan banner DEBUG
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TimerScreen(),                         // serahkan ke TimerScreen — main.dart tidak tahu detailnya
    );
  }
}