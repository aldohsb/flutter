import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../state/progress_provider.dart';
import 'level_card.dart';

class LevelSelectScreen extends ConsumerWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(progressProvider);
    final notifier = ref.read(progressProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Level')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: AppConstants.totalLevels,
        itemBuilder: (context, index) {
          final level = index + 1;
          return LevelCard(
            level: level,
            isCompleted: completed.contains(level),
            isUnlocked: notifier.isUnlocked(level),
          );
        },
      ),
    );
  }
}