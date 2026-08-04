import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';
import 'character_stat.dart';
import 'gradient_scaffold_background.dart';
import 'mistake_service.dart';
import 'quiz_category.dart';

/// Layar ringkasan aksara yang paling sering dijawab salah, dikelompokkan
/// per kategori lewat tab, agar pemain tahu apa yang perlu diulang.
/// Data diambil dari [MistakeService] yang mencatat setiap jawaban di
/// [QuizScreen].
class MistakeReviewScreen extends StatelessWidget {
  const MistakeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: QuizCategory.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aksara Perlu Diulang'),
          actions: [
            IconButton(
              tooltip: 'Reset catatan kesalahan',
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => _confirmReset(context),
            ),
          ],
          bottom: TabBar(
            tabs: [for (final category in QuizCategory.values) Tab(text: category.displayName)],
          ),
        ),
        body: GradientScaffoldBackground(
          child: SafeArea(
            child: TabBarView(
              children: [
                for (final category in QuizCategory.values) _MistakeList(category: category),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.sandSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        title: const Text('Reset catatan kesalahan?'),
        content: const Text('Seluruh catatan aksara yang sering salah akan dihapus permanen. Progres level tidak terpengaruh.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<MistakeService>().resetAllStats();
    }
  }
}

class _MistakeList extends StatelessWidget {
  const _MistakeList({required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    final mistakeService = context.watch<MistakeService>();
    final stats = mistakeService.mostMistaken(category);

    if (stats.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            'Belum ada kesalahan tercatat untuk ${category.displayName}.\nTerus berlatih, catatan akan muncul di sini.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.inkFaint, fontSize: 13.5),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: stats.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => _MistakeTile(stat: stats[index]),
    );
  }
}

class _MistakeTile extends StatelessWidget {
  const _MistakeTile({required this.stat});

  final CharacterStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.sandSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.stone.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.sagePale,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(stat.character, style: AppTheme.jpTextStyle(fontSize: 24, color: AppColors.sageDeep)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.romaji,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: stat.accuracy,
                    minHeight: 5,
                    backgroundColor: AppColors.stone,
                    valueColor: const AlwaysStoppedAnimation(AppColors.success),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stat.wrongCount}x salah',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.error),
              ),
              const SizedBox(height: 2),
              Text(
                '${(stat.accuracy * 100).round()}% benar',
                style: const TextStyle(fontSize: 11, color: AppColors.inkFaint),
              ),
            ],
          ),
        ],
      ),
    );
  }
}