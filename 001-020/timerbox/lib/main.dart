import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const TimerBoxApp());

enum TimerState { idle, running, paused }

class TimerBoxApp extends StatelessWidget {
  const TimerBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimerBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  Timer? _timer;
  TimerState _state = TimerState.idle;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    setState(() => _state = TimerState.running);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() => _state = TimerState.paused);
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _state = TimerState.idle;
    });
  }

  String _formatTime() {
    final int minutes = _seconds ~/ 60;
    final int seconds = _seconds % 60;
    final String mm = minutes.toString().padLeft(2, '0');
    final String ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('TimerBox', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()],
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_state == TimerState.idle) ...[
                _buildButton('Start', Colors.green, _start),
              ],
              if (_state == TimerState.running) ...[
                _buildButton('Pause', Colors.orange, _pause),
                const SizedBox(width: 16),
                _buildButton('Reset', Colors.red, _reset),
              ],
              if (_state == TimerState.paused) ...[
                _buildButton('Resume', Colors.green, _start),
                const SizedBox(width: 16),
                _buildButton('Reset', Colors.red, _reset),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
