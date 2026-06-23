import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/quiz_result.dart';
import '../../providers/profile_provider.dart';
import '../../providers/result_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/empty_state.dart';
import '../result/result_screen.dart';

/// Menampilkan seluruh riwayat hasil tes milik profil yang sedang aktif,
/// diurutkan dari yang paling baru, beserta opsi untuk menghapus sesi.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String userId,
    QuizResult result,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus hasil tes ini?'),
        content: const Text('Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Hapus', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(userResultHistoryProvider(userId).notifier)
          .deleteResult(result.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(activeProfileProvider);

    if (activeProfile == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final history = ref.watch(userResultHistoryProvider(activeProfile.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Tes')),
      body: history.isEmpty
          ? const EmptyState(
              icon: Icons.history_rounded,
              title: 'Belum ada riwayat',
              message: 'Hasil tes yang sudah Anda kerjakan akan muncul '
                  'di halaman ini.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final result = history[index];
                return _HistoryTile(
                  result: result,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(result: result),
                      ),
                    );
                  },
                  onDelete: () => _confirmDelete(
                    context,
                    ref,
                    activeProfile.id,
                    result,
                  ),
                );
              },
            ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.result,
    required this.onTap,
    required this.onDelete,
  });

  final QuizResult result;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('d MMM yyyy, HH:mm', 'id_ID').format(
      result.completedAt,
    );

    return Dismissible(
      key: ValueKey(result.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.insights_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil Tes OCEAN',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dateLabel,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
