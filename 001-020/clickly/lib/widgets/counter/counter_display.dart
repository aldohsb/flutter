import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CounterDisplay extends StatelessWidget {
  final int value;

  const CounterDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: AppColors.shadowLight,
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
        ],
      ),
      child: TweenAnimationBuilder<Color?>(
        key: ValueKey<int>(value),
        // key baru di setiap perubahan value => animasi restart dari awal
        tween: ColorTween(begin: AppColors.accent, end: AppColors.primaryText),
        duration: const Duration(milliseconds: 400),
        builder: (context, color, child) {
          return Text(
            '$value',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: color,
                ),
          );
        },
      ),
    );
  }
}