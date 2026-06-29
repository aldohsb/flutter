import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/streak_badge.dart';

class HabitHistoryScreen extends StatefulWidget {
  final Habit habit;

  const HabitHistoryScreen({super.key, required this.habit});

  @override
  State<HabitHistoryScreen> createState() => _HabitHistoryScreenState();
}

class _HabitHistoryScreenState extends State<HabitHistoryScreen> {
  late DateTime _focusedMonth;
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _focusedMonth = DateTime(_today.year, _today.month);
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final streak = habit.streak;
    final completion = habit.completionPercent;

    return Scaffold(
      backgroundColor: AppTheme.sage100,
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                StreakBadge(streak: streak, fontSize: 12),
                const SizedBox(width: 6),
                CompletionBadge(percent: completion, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Summary strip ──
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.sage200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SummaryItem(
                  label: 'Mulai Dari',
                  value: DateFormat('d MMM yyyy')
                      .format(habit.startDate),
                ),
                _SummaryItem(
                  label: 'Streak',
                  value: '$streak hari',
                  valueColor: AppTheme.streakColor(streak),
                ),
                _SummaryItem(
                  label: 'Completion',
                  value: '${completion.toStringAsFixed(1)}%',
                  valueColor: AppTheme.completionColor(completion),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── Month navigator ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded),
                  onPressed: () => setState(() {
                    _focusedMonth = DateTime(
                        _focusedMonth.year, _focusedMonth.month - 1);
                  }),
                  color: AppTheme.sage600,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DateFormat('MMMM yyyy').format(_focusedMonth),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded),
                  onPressed: _focusedMonth.year == _today.year &&
                          _focusedMonth.month == _today.month
                      ? null
                      : () => setState(() {
                            _focusedMonth = DateTime(
                                _focusedMonth.year, _focusedMonth.month + 1);
                          }),
                  color: AppTheme.sage600,
                ),
              ],
            ),
          ),

          // ── Calendar ──
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.sage200),
              ),
              child: _CalendarGrid(
                habit: habit,
                focusedMonth: _focusedMonth,
                today: _today,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final Habit habit;
  final DateTime focusedMonth;
  final DateTime today;

  const _CalendarGrid({
    required this.habit,
    required this.focusedMonth,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HabitProvider>();
    final daysInMonth =
        DateTime(focusedMonth.year, focusedMonth.month + 1, 0).day;
    final firstWeekday =
        DateTime(focusedMonth.year, focusedMonth.month, 1).weekday;
    // weekday: 1=Mon, 7=Sun → offset for Sun-start grid
    final offset = firstWeekday % 7; // Sun=0, Mon=1 ... Sat=6

    const weekLabels = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Column(
      children: [
        // ── Day headers ──
        Row(
          children: weekLabels
              .map(
                (d) => Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.sage600,
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),

        // ── Day cells ──
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: offset + daysInMonth,
            itemBuilder: (ctx, idx) {
              if (idx < offset) return const SizedBox.shrink();
              final day = idx - offset + 1;
              final date = DateTime(focusedMonth.year, focusedMonth.month, day);
              final isToday = date.year == today.year &&
                  date.month == today.month &&
                  date.day == today.day;
              final isFuture = date.isAfter(today);
              final isBeforeStart = date.isBefore(DateTime(
                  habit.startDate.year,
                  habit.startDate.month,
                  habit.startDate.day));
              final isCompleted = habit.isCompletedOn(date);

              return GestureDetector(
                onTap: isFuture || isBeforeStart
                    ? null
                    : () {
                        provider.setCompletion(
                            habit.id, date, !isCompleted);
                      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isBeforeStart
                        ? Colors.transparent
                        : isFuture
                            ? Colors.transparent
                            : isCompleted
                                ? AppTheme.sage500
                                : AppTheme.stone100,
                    borderRadius: BorderRadius.circular(8),
                    border: isToday
                        ? Border.all(color: AppTheme.sage600, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isToday
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isBeforeStart
                            ? AppTheme.stone300
                            : isFuture
                                ? AppTheme.stone300
                                : isCompleted
                                    ? Colors.white
                                    : AppTheme.stone700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── Legend ──
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(
                color: AppTheme.sage500, label: 'Selesai'),
            const SizedBox(width: 16),
            _LegendItem(
                color: AppTheme.stone100,
                borderColor: AppTheme.stone300,
                label: 'Tidak selesai'),
            const SizedBox(width: 16),
            _LegendItem(
                color: Colors.transparent,
                borderColor: AppTheme.sage600,
                label: 'Hari ini',
                isBorder: true),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final String label;
  final bool isBorder;

  const _LegendItem({
    required this.color,
    required this.label,
    this.borderColor,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: isBorder ? 2 : 1)
                : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryItem(
      {required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: valueColor ?? AppTheme.sage700,
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
