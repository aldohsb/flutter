import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Indikator progres tugas selesai vs total tugas.
class TodoProgressBar extends StatelessWidget {
  final int done;
  final int total;

  const TodoProgressBar({super.key, required this.done, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : done / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.paperLine,
                color: AppColors.accentGreen,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text('$done/$total', style: const TextStyle(color: AppColors.inkSoft)),
        ],
      ),
    );
  }
}