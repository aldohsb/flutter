import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/habit_provider.dart';
import '../providers/weight_provider.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/habit_tile.dart';
import '../widgets/weight_tracker_card.dart';
import '../widgets/earning_tracker_card.dart';
import '../widgets/calorie_tracker_card.dart';
import '../widgets/day_confirm_dialog.dart';
import 'data_management_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _dayCheckDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkDayChange());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkDayChange();
    }
  }

  String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  String _yesterdayKey() {
    final d = DateTime.now().subtract(const Duration(days: 1));
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  Future<void> _checkDayChange() async {
    if (_dayCheckDone) return;
    if (!mounted) return;

    final habitProvider =
        context.read<HabitProvider>();
    final lastSeen = habitProvider.lastSeenDate;
    final today = _todayKey();
    final yesterday = _yesterdayKey();

    if (lastSeen != today) {
      // Day changed — show dialog for habits not completed yesterday
      if (lastSeen == yesterday || lastSeen == null) {
        final yesterday0 = DateTime.now().subtract(const Duration(days: 1));
        final missed = habitProvider.missedHabitsOn(yesterday0);

        if (missed.isNotEmpty && mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => DayConfirmDialog(
              missedHabits: missed,
              missedDate: yesterday0,
              onConfirm: (id, completed) {
                if (completed) {
                  habitProvider.setCompletion(
                      id, yesterday0, true);
                }
              },
            ),
          );
        }
      }
      await habitProvider.updateLastSeenDate(today);
    }
    _dayCheckDone = true;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dateLabel = DateFormat('EEEE, d MMMM yyyy').format(today);

    return Scaffold(
      backgroundColor: AppTheme.sage100,
      body: Column(
        children: [
          // ── App Bar manual (tidak pakai SliverAppBar agar kompatibel) ──
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Habit Aldo',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 22),
                        ),
                        Text(
                          dateLabel,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bar_chart_rounded,
                        color: AppTheme.sage600),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StatsScreen()),
                    ),
                    tooltip: 'Statistik',
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz_rounded,
                        color: AppTheme.sage600),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DataManagementScreen()),
                    ),
                    tooltip: 'Kelola Data',
                  ),
                ],
              ),
            ),
          ),

          // ── Scrollable content ──
          Expanded(
            child: Consumer<HabitProvider>(
              builder: (context, hp, _) {
                final habits = hp.habits;

                return ReorderableListView(
                  // Header widgets (non-reorderable)
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Weight tracker
                      const WeightTrackerCard()
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .slideY(begin: 0.05, duration: 300.ms),

                      // Earning tracker
                      const EarningTrackerCard()
                          .animate()
                          .fadeIn(duration: 300.ms, delay: 60.ms)
                          .slideY(
                              begin: 0.05,
                              duration: 300.ms,
                              delay: 60.ms),

                      // Calorie tracker
                      const CalorieTrackerCard()
                          .animate()
                          .fadeIn(duration: 300.ms, delay: 120.ms)
                          .slideY(
                              begin: 0.05,
                              duration: 300.ms,
                              delay: 120.ms),

                      // Section header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
                        child: Row(
                          children: [
                            Text(
                              'Habits Hari Ini',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(),
                            Builder(builder: (_) {
                              final done = habits
                                  .where((h) => h.isCompletedOn(today))
                                  .length;
                              final total = habits.length;
                              final pct = total > 0
                                  ? done / total * 100
                                  : 0.0;
                              final color = total == 0
                                  ? AppTheme.stone300
                                  : AppTheme.completionColor(pct);
                              return Row(
                                children: [
                                  Text(
                                    '$done / $total',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: AppTheme.stone500),
                                  ),
                                  if (total > 0) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: color.withOpacity(0.4)),
                                      ),
                                      child: Text(
                                        '${pct.toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            }),
                          ],
                        ),
                      ),

                      // Empty state
                      if (habits.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Column(
                              children: [
                                const Text('🌱',
                                    style: TextStyle(fontSize: 40)),
                                const SizedBox(height: 12),
                                Text(
                                  'Belum ada habit.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tambah habit pertama kamu di bawah.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Footer padding
                  footer: const SizedBox(height: 100),

                  // Reorder callback
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex--;
                    hp.reorderHabits(oldIndex, newIndex);
                  },

                  // Styling
                  buildDefaultDragHandles: false,
                  padding: EdgeInsets.zero,
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (_, __) => Material(
                        elevation: 6,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: child,
                      ),
                    );
                  },

                  // Habit items
                  children: habits
                      .asMap()
                      .entries
                      .map(
                        (e) => HabitTile(
                          key: ValueKey(e.value.id),
                          habit: e.value,
                          index: e.key,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),

      // ── FAB: Add habit ──
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddHabitDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Habit Baru'),
        backgroundColor: AppTheme.sage600,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    DateTime startDate = DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppTheme.stone100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title:
              Text('Habit Baru', style: Theme.of(ctx).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Habit',
                  hintText: 'Contoh: Baca buku 30 menit',
                ),
                onSubmitted: (_) => _submitAddHabit(
                    ctx, nameCtrl, startDate),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 1)),
                  );
                  if (picked != null) setState(() => startDate = picked);
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
                        'Mulai hitung dari: ${DateFormat('d MMM yyyy').format(startDate)}',
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
              onPressed: () =>
                  _submitAddHabit(ctx, nameCtrl, startDate),
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitAddHabit(BuildContext ctx, TextEditingController ctrl,
      DateTime startDate) {
    if (ctrl.text.trim().isNotEmpty) {
      context
          .read<HabitProvider>()
          .addHabit(ctrl.text.trim(), startDate);
      Navigator.pop(ctx);
    }
  }
}