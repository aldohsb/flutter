import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_card.dart';
import '../widgets/add_habit_dialog.dart';
import '../widgets/weight_tracker_card.dart';
import '../widgets/earning_tracker_card.dart';
import '../widgets/day_change_confirmation.dart';
import '../theme/app_theme.dart';
import 'earning_stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _confirmationShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkConfirmation();
    });
  }

  void _checkConfirmation() {
    final provider = context.read<HabitProvider>();
    if (provider.confirmationPending && !_confirmationShown) {
      _confirmationShown = true;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => DayChangeConfirmationSheet(
          habits: provider.habitsNeedingConfirmation,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for confirmation
    return Consumer<HabitProvider>(
      builder: (context, provider, _) {
        if (provider.confirmationPending && !_confirmationShown) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkConfirmation();
          });
        }

        final today = DateFormat('EEEE, d MMMM yyyy', 'id_ID')
            .format(DateTime.now());
        final total = provider.habits.length;
        final completed =
            provider.habits.where((h) => h.isCompletedToday).length;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Aldo Habit'),
            actions: [
              IconButton(
                icon: const Icon(Icons.bar_chart_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EarningStatsScreen()),
                ),
                tooltip: 'Statistik Earning',
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              // Header tanggal + progress
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOlive,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        today,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$completed',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' / $total',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'habit selesai',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      if (total > 0) ...[
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: completed / total,
                            backgroundColor: Colors.white24,
                            color: Colors.white,
                            minHeight: 5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Weight Tracker
              const SliverToBoxAdapter(
                child: WeightTrackerCard(),
              ),

              // Earning Tracker
              const SliverToBoxAdapter(
                child: EarningTrackerCard(),
              ),

              // Section header habit list
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
                  child: Row(
                    children: [
                      const Text(
                        'HABIT LIST',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(tahan & seret untuk urutkan)',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ),

              // Habit list dengan reorder
              if (provider.habits.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Icon(
                          Icons.checklist_outlined,
                          size: 64,
                          color: AppTheme.primaryOlive.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada habit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + untuk tambah habit pertama',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverReorderableList(
                  itemCount: provider.habits.length,
                  itemBuilder: (context, index) {
                    final habit = provider.habits[index];
                    return ReorderableDragStartListener(
                      key: ValueKey(habit.id),
                      index: index,
                      child: HabitCard(habit: habit),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    provider.reorderHabits(oldIndex, newIndex);
                  },
                ),

              // Bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const AddHabitDialog(),
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
