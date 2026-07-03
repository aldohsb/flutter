import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/counter/counter_display.dart';
import '../../widgets/counter/counter_controls.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  // satu-satunya sumber kebenaran (single source of truth) untuk nilai counter

  void _increment() {
    setState(() {
      if (_counter < AppConstants.counterMax) _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > AppConstants.counterMin) _counter--;
    });
  }

  void _reset() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          // batas lebar ini mencegah layout melebar aneh di web/Windows
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterDisplay(value: _counter),
              const SizedBox(height: 40),
              CounterControls(
                onDecrement: _decrement,
                onReset: _reset,
                onIncrement: _increment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}