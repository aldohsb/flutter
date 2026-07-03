import 'package:flutter/material.dart';
import 'counter_button.dart';
import '../../core/theme/app_colors.dart';

class CounterControls extends StatelessWidget {
  final VoidCallback onDecrement;
  final VoidCallback onReset;
  final VoidCallback onIncrement;

  const CounterControls({
    super.key,
    required this.onDecrement,
    required this.onReset,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CounterButton(
          heroTag: 'decrement',
          icon: Icons.remove,
          onPressed: onDecrement,
        ),
        const SizedBox(width: 20),
        CounterButton(
          heroTag: 'reset',
          icon: Icons.refresh,
          backgroundColor: AppColors.danger,
          onPressed: onReset,
        ),
        const SizedBox(width: 20),
        CounterButton(
          heroTag: 'increment',
          icon: Icons.add,
          onPressed: onIncrement,
        ),
      ],
    );
  }
}