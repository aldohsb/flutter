import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../theme/app_theme.dart';
import 'edit_habit_dialog.dart';
import 'history_edit_dialog.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final streak = habit.streak;
    final streakColor = AppTheme.streakColor(streak);
    final streakEmoji = AppTheme.streakLabel(streak);
    final completion = habit.getCompletionPercentage();
    final completionColor = AppTheme.completionColor(completion);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Drag handle
            const Icon(Icons.drag_handle, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            // Checkbox
            GestureDetector(
              onTap: () {
                context.read<HabitProvider>().toggleHabitCompletion(habit.id);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: habit.isCompletedToday
                        ? AppTheme.primaryOlive
                        : AppTheme.primaryOlive.withOpacity(0.35),
                    width: 2,
                  ),
                  color: habit.isCompletedToday
                      ? AppTheme.primaryOlive
                      : Colors.transparent,
                ),
                child: habit.isCompletedToday
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            // Nama + stats
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: habit.isCompletedToday
                          ? TextDecoration.lineThrough
                          : null,
                      color: habit.isCompletedToday
                          ? Colors.grey
                          : AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Streak badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: streakColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: streakColor.withOpacity(0.4), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_fire_department,
                                size: 12, color: streakColor),
                            const SizedBox(width: 3),
                            Text(
                              '$streak hari$streakEmoji',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: streakColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Completion badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: completionColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: completionColor.withOpacity(0.4), width: 1),
                        ),
                        child: Text(
                          '${completion.toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 11,
                              color: completionColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Menu
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[400],
                size: 20,
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  showDialog(
                    context: context,
                    builder: (_) => EditHabitDialog(habit: habit),
                  );
                } else if (value == 'history') {
                  showDialog(
                    context: context,
                    builder: (_) => HistoryEditDialog(habit: habit),
                  );
                } else if (value == 'delete') {
                  _showDeleteDialog(context);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(children: [
                    Icon(Icons.edit_outlined, size: 18),
                    SizedBox(width: 10),
                    Text('Edit nama & tanggal'),
                  ]),
                ),
                const PopupMenuItem(
                  value: 'history',
                  child: Row(children: [
                    Icon(Icons.history, size: 18),
                    SizedBox(width: 10),
                    Text('Edit history'),
                  ]),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Hapus', style: TextStyle(color: Colors.red)),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Habit'),
        content: Text('Yakin hapus "${habit.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              context.read<HabitProvider>().deleteHabit(habit.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
