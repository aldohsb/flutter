import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/wordbank/word_bank.dart';
import '../../state/page_progress_provider.dart';
import '../../state/progress_provider.dart';
import 'level_card.dart';

class LevelSelectScreen extends ConsumerWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = ref.watch(progressProvider);
    final pageProgress = ref.watch(pageProgressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Level')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wordGroups.length,
        itemBuilder: (context, groupIndex) {
          final group = wordGroups[groupIndex];
          final start = WordBank.levelStartOfGroup(groupIndex);
          final levels = List.generate(group.levelCount, (i) => start + i);

          return Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kelompok ${group.id}: ${group.label}',
                    style: AppTextStyles.heading),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    for (final level in levels)
                      LevelCard(
                        level: level,
                        isCompleted: completed.contains(level),
                        isStarted: (pageProgress[level] ?? 0) > 0,
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}