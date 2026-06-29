import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';

class DayConfirmDialog extends StatefulWidget {
  final List<Habit> missedHabits;
  final DateTime missedDate;
  final void Function(String habitId, bool completed) onConfirm;

  const DayConfirmDialog({
    super.key,
    required this.missedHabits,
    required this.missedDate,
    required this.onConfirm,
  });

  @override
  State<DayConfirmDialog> createState() => _DayConfirmDialogState();
}

class _DayConfirmDialogState extends State<DayConfirmDialog> {
  late final Map<String, bool> _answers;

  @override
  void initState() {
    super.initState();
    _answers = {for (final h in widget.missedHabits) h.id: false};
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        DateFormat('EEEE, d MMM').format(widget.missedDate);
    return AlertDialog(
      backgroundColor: AppTheme.stone100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🌅', style: TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(
            'Hari Baru',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 18),
          ),
          Text(
            'Apakah kamu selesaikan habit ini kemarin ($dateLabel)?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.missedHabits.map((habit) {
            return _HabitConfirmRow(
              habit: habit,
              value: _answers[habit.id]!,
              onChanged: (v) => setState(() => _answers[habit.id] = v),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Lewati'),
        ),
        ElevatedButton(
          onPressed: () {
            for (final entry in _answers.entries) {
              widget.onConfirm(entry.key, entry.value);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}

class _HabitConfirmRow extends StatelessWidget {
  final Habit habit;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _HabitConfirmRow({
    required this.habit,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: value
            ? AppTheme.sage200.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? AppTheme.sage400 : AppTheme.stone200,
        ),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        title: Text(
          habit.name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                decoration: value ? TextDecoration.lineThrough : null,
                color: value ? AppTheme.stone500 : AppTheme.stone700,
              ),
        ),
        secondary: value
            ? const Icon(Icons.check_circle_rounded,
                color: AppTheme.sage600, size: 20)
            : const Icon(Icons.radio_button_unchecked_rounded,
                color: AppTheme.stone300, size: 20),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
