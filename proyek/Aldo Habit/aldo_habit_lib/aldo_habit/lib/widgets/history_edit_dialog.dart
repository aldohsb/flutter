import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../theme/app_theme.dart';

class HistoryEditDialog extends StatefulWidget {
  final Habit habit;
  const HistoryEditDialog({super.key, required this.habit});

  @override
  State<HistoryEditDialog> createState() => _HistoryEditDialogState();
}

class _HistoryEditDialogState extends State<HistoryEditDialog> {
  late Set<DateTime> _completedDates;
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _completedDates = widget.habit.completionHistory
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();
    _focusedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _toggleDate(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    if (d.isAfter(todayDate)) return; // Tidak bisa edit masa depan
    setState(() {
      if (_completedDates.contains(d)) {
        _completedDates.remove(d);
      } else {
        _completedDates.add(d);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(
            _focusedMonth.year, _focusedMonth.month + 1, 0)
        .day;
    final firstDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sun

    final monthNames = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];

    return AlertDialog(
      title: Text('Edit History: ${widget.habit.name}'),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Month navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => setState(() {
                    _focusedMonth = DateTime(
                        _focusedMonth.year, _focusedMonth.month - 1);
                  }),
                ),
                Text(
                  '${monthNames[_focusedMonth.month]} ${_focusedMonth.year}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    final next = DateTime(
                        _focusedMonth.year, _focusedMonth.month + 1);
                    final now = DateTime.now();
                    if (next.year < now.year ||
                        (next.year == now.year &&
                            next.month <= now.month)) {
                      setState(() => _focusedMonth = next);
                    }
                  },
                ),
              ],
            ),
            // Day headers
            Row(
              children: ['M', 'S', 'S', 'R', 'K', 'J', 'S']
                  .map((d) => Expanded(
                        child: Center(
                          child: Text(d,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 4),
            // Calendar grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: startWeekday + daysInMonth,
              itemBuilder: (context, index) {
                if (index < startWeekday) return const SizedBox();
                final day = index - startWeekday + 1;
                final date =
                    DateTime(_focusedMonth.year, _focusedMonth.month, day);
                final today = DateTime.now();
                final todayDate =
                    DateTime(today.year, today.month, today.day);
                final isFuture = date.isAfter(todayDate);
                final isCompleted = _completedDates.contains(date);
                final isToday = date == todayDate;

                return GestureDetector(
                  onTap: isFuture ? null : () => _toggleDate(date),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.primaryOlive
                          : isFuture
                              ? Colors.transparent
                              : Colors.grey[100],
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: AppTheme.accentGold, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 12,
                          color: isCompleted
                              ? Colors.white
                              : isFuture
                                  ? Colors.grey[300]
                                  : AppTheme.textDark,
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              '${_completedDates.length} hari selesai',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal')),
        ElevatedButton(
          onPressed: () {
            context.read<HabitProvider>().updateHabitHistory(
                  widget.habit.id,
                  _completedDates.toList(),
                );
            Navigator.pop(context);
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
