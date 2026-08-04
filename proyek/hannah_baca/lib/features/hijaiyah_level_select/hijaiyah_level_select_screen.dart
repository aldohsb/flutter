import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/hijaiyah/hijaiyah_level_config.dart';
import '../../state/hijaiyah_page_progress_provider.dart';
import '../../state/hijaiyah_progress_provider.dart';
import 'hijaiyah_level_card.dart';

class HijaiyahLevelSelectScreen extends ConsumerWidget {
  const HijaiyahLevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(hijaiyahProgressProvider);
    final pageProgress = ref.watch(hijaiyahPageProgressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Huruf Hijaiyah')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: HijaiyahLevelConfig.totalLevels,
        itemBuilder: (context, index) {
          final level = index + 1;
          return HijaiyahLevelCard(
            level: level,
            isCompleted: completed.contains(level),
            isStarted: (pageProgress[level] ?? 0) > 0,
          );
        },
      ),
    );
  }
}