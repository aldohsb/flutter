import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../theme/app_theme.dart';

class DayChangeConfirmationSheet extends StatefulWidget {
  final List<Habit> habits;

  const DayChangeConfirmationSheet({super.key, required this.habits});

  @override
  State<DayChangeConfirmationSheet> createState() =>
      _DayChangeConfirmationSheetState();
}

class _DayChangeConfirmationSheetState
    extends State<DayChangeConfirmationSheet> {
  late Map<String, bool?> _answers; // null = belum dijawab
  int _currentIndex = 0;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _answers = {for (var h in widget.habits) h.id: null};
  }

  Habit get currentHabit => widget.habits[_currentIndex];

  void _answer(bool completed) async {
    setState(() => _answers[currentHabit.id] = completed);

    if (completed) {
      await context
          .read<HabitProvider>()
          .confirmYesterdayCompletion(currentHabit.id);
    }

    if (_currentIndex < widget.habits.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _done = true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        context.read<HabitProvider>().dismissConfirmation();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final dayNames = [
      '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    final yesterdayName = dayNames[yesterday.weekday];

    return WillPopScope(
      onWillPop: () async {
        context.read<HabitProvider>().dismissConfirmation();
        return true;
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.wb_sunny_outlined,
                size: 32, color: AppTheme.accentGold),
            const SizedBox(height: 8),
            Text(
              'Review $yesterdayName',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${yesterday.day}/${yesterday.month}/${yesterday.year}',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            if (_done)
              const Column(
                children: [
                  Icon(Icons.check_circle, size: 48, color: AppTheme.primaryOlive),
                  SizedBox(height: 8),
                  Text('Tersimpan!', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            else ...[
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.habits.length, (i) {
                  final answered = _answers[widget.habits[i].id] != null;
                  final isCurrent = i == _currentIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isCurrent ? 14 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: answered
                          ? AppTheme.primaryOlive
                          : isCurrent
                              ? AppTheme.primaryOlive.withOpacity(0.5)
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Habit card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundCream,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppTheme.lightOlive.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    const Text('Apakah kamu menyelesaikan',
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(
                      currentHabit.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'kemarin ($yesterdayName)?',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _answer(false),
                      icon: const Icon(Icons.close, color: Colors.red),
                      label: const Text('Tidak',
                          style: TextStyle(color: Colors.red)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _answer(true),
                      icon: const Icon(Icons.check),
                      label: const Text('Ya, selesai!'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.read<HabitProvider>().dismissConfirmation();
                  Navigator.pop(context);
                },
                child: const Text('Lewati semua',
                    style: TextStyle(color: Colors.grey)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
