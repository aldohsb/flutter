import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/streak_badge.dart';
import '../screens/habit_history_screen.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final int index;

  const HabitTile({super.key, required this.habit, required this.index});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isCompleted = habit.isCompletedOn(today);
    final streak = habit.streak;
    final completion = habit.completionPercent;

    return Animate(
      effects: [
        FadeEffect(duration: 200.ms, delay: (index * 40).ms),
        SlideEffect(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
          duration: 200.ms,
          delay: (index * 40).ms,
        ),
      ],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isCompleted ? AppTheme.sage200.withOpacity(0.4) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted ? AppTheme.sage300 : AppTheme.stone200,
            width: 1,
          ),
          boxShadow: isCompleted
              ? null
              : [
                  BoxShadow(
                    color: AppTheme.stone200.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              context.read<HabitProvider>().toggleCompletion(habit.id, today),
          onLongPress: () => _showOptionsSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // ── Drag handle ──
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(
                    Icons.drag_indicator_rounded,
                    color: AppTheme.stone300,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),

                // ── Checkbox ──
                GestureDetector(
                  onTap: () => context
                      .read<HabitProvider>()
                      .toggleCompletion(habit.id, today),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.sage600
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isCompleted
                            ? AppTheme.sage600
                            : AppTheme.sage400,
                        width: 1.5,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 16)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),

                // ── Name + meta ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: isCompleted
                                      ? AppTheme.stone500
                                      : AppTheme.stone700,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          StreakBadge(streak: streak),
                          const SizedBox(width: 6),
                          CompletionBadge(percent: completion),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'since ${DateFormat('d MMM').format(habit.startDate)}',
                              style: Theme.of(context).textTheme.labelSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── More button ──
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded,
                      size: 18, color: AppTheme.stone500),
                  onPressed: () => _showOptionsSheet(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    // Capture provider BEFORE opening bottom sheet supaya context tetap valid
    final provider = context.read<HabitProvider>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => _HabitOptionsSheet(
        habit: habit,
        provider: provider,
        rootContext: context,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Options Sheet — provider di-pass langsung, bukan via context
// ─────────────────────────────────────────────────────────────
class _HabitOptionsSheet extends StatelessWidget {
  final Habit habit;
  final HabitProvider provider;
  final BuildContext rootContext;

  const _HabitOptionsSheet({
    required this.habit,
    required this.provider,
    required this.rootContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.stone100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.stone300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              habit.name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Divider(height: 20),
          _OptionItem(
            icon: Icons.history_rounded,
            label: 'Lihat Riwayat',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                rootContext,
                MaterialPageRoute(
                  builder: (_) => HabitHistoryScreen(habit: habit),
                ),
              );
            },
          ),
          _OptionItem(
            icon: Icons.edit_rounded,
            label: 'Edit Habit',
            onTap: () {
              Navigator.pop(context);
              _showEditDialog(rootContext);
            },
          ),
          _OptionItem(
            icon: Icons.delete_outline_rounded,
            label: 'Hapus Habit',
            color: AppTheme.errorRed,
            onTap: () {
              Navigator.pop(context);
              _confirmDelete(rootContext);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameCtrl = TextEditingController(text: habit.name);
    DateTime selectedDate = habit.startDate;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => AlertDialog(
          backgroundColor: AppTheme.stone100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Text('Edit Habit',
              style: Theme.of(ctx).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Habit',
                  hintText: 'Contoh: Olahraga 30 menit',
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setModalState(() => selectedDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.sage200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded,
                          size: 16, color: AppTheme.sage600),
                      const SizedBox(width: 8),
                      Text(
                        'Mulai: ${DateFormat('d MMM yyyy').format(selectedDate)}',
                        style: Theme.of(ctx).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                if (name.isNotEmpty) {
                  // Pakai provider yang sudah di-capture, bukan context
                  provider.updateHabit(habit.id, name, selectedDate);
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Habit?'),
        content: Text(
            'Semua data "${habit.name}" akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed),
            onPressed: () {
              // Pakai provider yang sudah di-capture, bukan context
              provider.deleteHabit(habit.id);
              Navigator.pop(ctx);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _OptionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.stone700;
    return ListTile(
      leading: Icon(icon, color: c, size: 20),
      title: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: c, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}