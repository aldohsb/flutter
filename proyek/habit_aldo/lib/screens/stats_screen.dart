import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../providers/habit_provider.dart';
import '../providers/weight_provider.dart';
import '../models/habit.dart';
import '../models/weight_entry.dart';
import '../theme/app_theme.dart';
import '../widgets/streak_badge.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sage100,
      appBar: AppBar(
        title: const Text('Statistik'),
        bottom: TabBar(
          controller: _tab,
          indicatorColor: AppTheme.sage600,
          labelColor: AppTheme.sage700,
          unselectedLabelColor: AppTheme.stone500,
          indicatorWeight: 2.5,
          tabs: const [
            Tab(text: 'Berat Badan'),
            Tab(text: 'Habit'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _WeightStatsTab(),
          _HabitStatsTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// WEIGHT STATS TAB
// ═══════════════════════════════════════════════════════════════

class _WeightStatsTab extends StatefulWidget {
  const _WeightStatsTab();

  @override
  State<_WeightStatsTab> createState() => _WeightStatsTabState();
}

class _WeightStatsTabState extends State<_WeightStatsTab> {
  // Range pilihan: 7, 30, 90 hari
  int _rangeDays = 30;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeightProvider>(
      builder: (context, wp, _) {
        final goal = wp.goal;
        final entries = wp.entries;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Summary cards ──
            _WeightSummaryRow(wp: wp),
            const SizedBox(height: 14),

            // ── Range selector ──
            _RangeSelector(
              selected: _rangeDays,
              onChanged: (v) => setState(() => _rangeDays = v),
            ),
            const SizedBox(height: 12),

            // ── Line chart ──
            if (entries.length >= 2)
              _WeightLineChart(
                entries: entries,
                goal: goal,
                rangeDays: _rangeDays,
              )
            else
              _EmptyChart(
                message: entries.isEmpty
                    ? 'Belum ada data berat badan.\nMulai input dari halaman utama.'
                    : 'Butuh minimal 2 data untuk menampilkan grafik.',
              ),

            const SizedBox(height: 14),

            // ── Progress toward goal ──
            if (goal != null) ...[
              _WeightGoalProgress(wp: wp, goal: goal),
              const SizedBox(height: 14),
            ],

            // ── History table ──
            if (entries.isNotEmpty)
              _WeightHistoryTable(entries: entries),
          ],
        );
      },
    );
  }
}

class _WeightSummaryRow extends StatelessWidget {
  final WeightProvider wp;
  const _WeightSummaryRow({required this.wp});

  @override
  Widget build(BuildContext context) {
    final goal = wp.goal;
    final entries = wp.entries;
    final current = wp.currentWeight;
    final target = wp.targetForToday();

    // Calculate total loss so far
    final startW = goal?.startWeightKg ?? (entries.isNotEmpty ? entries.first.weightKg : 0);
    final totalLoss = startW > 0 && current > 0 ? startW - current : 0.0;
    final remaining = goal != null ? current - goal.targetWeightKg : 0.0;

    return Row(
      children: [
        _StatMiniCard(
          label: 'Saat Ini',
          value: current > 0 ? '${current.toStringAsFixed(1)} kg' : '—',
          color: AppTheme.sage600,
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: 'Target Hari Ini',
          value: target != null ? '${target.toStringAsFixed(2)} kg' : '—',
          color: AppTheme.accentGold,
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: totalLoss >= 0 ? 'Sudah Turun' : 'Sudah Naik',
          value: totalLoss != 0
              ? '${totalLoss.abs().toStringAsFixed(1)} kg'
              : '—',
          color: totalLoss >= 0 ? AppTheme.successGreen : AppTheme.errorRed,
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: 'Sisa Target',
          value: goal != null && remaining > 0
              ? '${remaining.toStringAsFixed(1)} kg'
              : goal != null
                  ? '✓ Tercapai!'
                  : '—',
          color: goal != null && remaining <= 0
              ? AppTheme.successGreen
              : AppTheme.stone500,
        ),
      ],
    );
  }
}

class _WeightLineChart extends StatelessWidget {
  final List<WeightEntry> entries;
  final dynamic goal;
  final int rangeDays;

  const _WeightLineChart({
    required this.entries,
    required this.goal,
    required this.rangeDays,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: rangeDays));

    // Filter entries in range
    final filtered = entries
        .where((e) => e.date.isAfter(cutoff) || e.date.isAtSameMomentAs(cutoff))
        .toList();

    if (filtered.length < 2) {
      return _EmptyChart(
        message: 'Tidak cukup data dalam $rangeDays hari terakhir.',
      );
    }

    // Build actual weight spots
    final first = filtered.first.date;
    List<FlSpot> actualSpots = filtered.map((e) {
      final x = e.date.difference(first).inHours / 24.0;
      return FlSpot(x, e.weightKg);
    }).toList();

    // Build target spots (if goal set)
    List<FlSpot> targetSpots = [];
    if (goal != null) {
      for (final e in filtered) {
        final x = e.date.difference(first).inHours / 24.0;
        final t = goal.targetForDate(e.date);
        targetSpots.add(FlSpot(x, t));
      }
    }

    // Y axis range
    final allY = [
      ...actualSpots.map((s) => s.y),
      ...targetSpots.map((s) => s.y),
    ];
    final minY = (allY.reduce((a, b) => a < b ? a : b) - 1).floorToDouble();
    final maxY = (allY.reduce((a, b) => a > b ? a : b) + 1).ceilToDouble();

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 12),
            child: Text('Grafik Berat Badan',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => const FlLine(
                    color: AppTheme.sage200,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (v, _) => Text(
                        '${v.toStringAsFixed(0)}kg',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: (rangeDays / 5).ceilToDouble(),
                      getTitlesWidget: (v, _) {
                        final d = first.add(Duration(hours: (v * 24).round()));
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            DateFormat('d/M').format(d),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots.map((s) {
                      final isTarget = s.barIndex == 1;
                      return LineTooltipItem(
                        isTarget ? 'Target\n' : 'Aktual\n',
                        TextStyle(
                          color: isTarget
                              ? AppTheme.accentGold
                              : AppTheme.sage600,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '${s.y.toStringAsFixed(2)} kg',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                lineBarsData: [
                  // Actual weight line
                  LineChartBarData(
                    spots: actualSpots,
                    color: AppTheme.sage500,
                    barWidth: 2.5,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (_, __, ___, ____) =>
                          FlDotCirclePainter(
                        radius: 3,
                        color: AppTheme.sage600,
                        strokeWidth: 1.5,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.sage400.withOpacity(0.3),
                          AppTheme.sage400.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                  // Target line (dashed style via dash array)
                  if (targetSpots.isNotEmpty)
                    LineChartBarData(
                      spots: targetSpots,
                      color: AppTheme.accentGold,
                      barWidth: 1.5,
                      isCurved: false,
                      dashArray: [5, 4],
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _LegendDot(color: AppTheme.sage500, label: 'Berat Aktual'),
              const SizedBox(width: 20),
              if (targetSpots.isNotEmpty)
                const _LegendDash(color: AppTheme.accentGold, label: 'Target'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightGoalProgress extends StatelessWidget {
  final WeightProvider wp;
  final dynamic goal;

  const _WeightGoalProgress({required this.wp, required this.goal});

  @override
  Widget build(BuildContext context) {
    final current = wp.currentWeight;
    final start = goal.startWeightKg as double;
    final target = goal.targetWeightKg as double;
    final totalToLose = start - target;
    final lost = start - current;
    final progress = totalToLose > 0
        ? (lost / totalToLose).clamp(0.0, 1.0)
        : 0.0;
    final pct = progress * 100;
    final color = AppTheme.completionColor(pct);

    // Days elapsed / remaining
    final today = DateTime.now();
    final daysElapsed = today.difference(goal.startDate as DateTime).inDays;
    final daysTotal = goal.durationDays as int;
    final daysRemaining = (daysTotal - daysElapsed).clamp(0, daysTotal);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress Menuju Target',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${start.toStringAsFixed(1)} kg',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.stone500),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: AppTheme.stone200,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ),
              ),
              Text(
                '${target.toStringAsFixed(1)} kg',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.stone500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '${pct.toStringAsFixed(1)}% tercapai · $daysRemaining hari tersisa dari $daysTotal hari',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightHistoryTable extends StatelessWidget {
  final List<WeightEntry> entries;
  const _WeightHistoryTable({required this.entries});

  @override
  Widget build(BuildContext context) {
    final reversed = entries.reversed.take(14).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text('Riwayat (14 Terakhir)',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          const Divider(height: 1),
          ...reversed.asMap().entries.map((e) {
            final entry = e.value;
            final prev = e.key < reversed.length - 1
                ? reversed[e.key + 1].weightKg
                : null;
            final diff = prev != null ? entry.weightKg - prev : null;
            return _WeightRow(entry: entry, diff: diff);
          }),
        ],
      ),
    );
  }
}

class _WeightRow extends StatelessWidget {
  final WeightEntry entry;
  final double? diff;
  const _WeightRow({required this.entry, this.diff});

  @override
  Widget build(BuildContext context) {
    Color diffColor = AppTheme.stone400;
    String diffLabel = '—';
    if (diff != null) {
      diffColor = diff! < 0 ? AppTheme.successGreen : AppTheme.errorRed;
      diffLabel = '${diff! >= 0 ? '+' : ''}${diff!.toStringAsFixed(1)} kg';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.sage200)),
      ),
      child: Row(
        children: [
          Text(
            DateFormat('EEE, d MMM yyyy').format(entry.date),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(
            '${entry.weightKg.toStringAsFixed(1)} kg',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 68,
            child: Text(
              diffLabel,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: diffColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// HABIT STATS TAB
// ═══════════════════════════════════════════════════════════════

class _HabitStatsTab extends StatefulWidget {
  const _HabitStatsTab();

  @override
  State<_HabitStatsTab> createState() => _HabitStatsTabState();
}

class _HabitStatsTabState extends State<_HabitStatsTab> {
  int _rangeDays = 30;

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, hp, _) {
        final habits = hp.habits;

        if (habits.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🌱', style: TextStyle(fontSize: 48)),
                SizedBox(height: 12),
                Text(
                  'Belum ada habit.',
                  style: TextStyle(color: AppTheme.stone500),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Overall summary ──
            _HabitOverallSummary(habits: habits),
            const SizedBox(height: 14),

            // ── Range selector ──
            _RangeSelector(
              selected: _rangeDays,
              onChanged: (v) => setState(() => _rangeDays = v),
            ),
            const SizedBox(height: 12),

            // ── Daily completion rate bar chart ──
            _DailyCompletionChart(habits: habits, rangeDays: _rangeDays),
            const SizedBox(height: 14),

            // ── Per-habit leaderboard ──
            _HabitLeaderboard(habits: habits, rangeDays: _rangeDays),
          ],
        );
      },
    );
  }
}

class _HabitOverallSummary extends StatelessWidget {
  final List<Habit> habits;
  const _HabitOverallSummary({required this.habits});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final doneToday = habits.where((h) => h.isCompletedOn(today)).length;
    final totalToday = habits.length;
    final completionPct =
        totalToday > 0 ? (doneToday / totalToday * 100) : 0.0;

    final avgCompletion = habits.isEmpty
        ? 0.0
        : habits.map((h) => h.completionPercent).reduce((a, b) => a + b) /
            habits.length;

    final maxStreak =
        habits.isEmpty ? 0 : habits.map((h) => h.streak).reduce((a, b) => a > b ? a : b);
    final totalStreak = habits.fold(0, (sum, h) => sum + h.streak);

    return Row(
      children: [
        _StatMiniCard(
          label: 'Selesai Hari Ini',
          value: '$doneToday / $totalToday',
          color: AppTheme.completionColor(completionPct),
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: 'Rata-rata Completion',
          value: '${avgCompletion.toStringAsFixed(0)}%',
          color: AppTheme.completionColor(avgCompletion),
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: 'Streak Terpanjang',
          value: '🔥 $maxStreak',
          color: AppTheme.streakColor(maxStreak),
        ),
        const SizedBox(width: 8),
        _StatMiniCard(
          label: 'Total Streak',
          value: '$totalStreak hari',
          color: AppTheme.sage600,
        ),
      ],
    );
  }
}

class _DailyCompletionChart extends StatelessWidget {
  final List<Habit> habits;
  final int rangeDays;

  const _DailyCompletionChart(
      {required this.habits, required this.rangeDays});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    // Build daily completion data for range
    final List<_DayData> data = [];
    for (int i = rangeDays - 1; i >= 0; i--) {
      final day = today.subtract(Duration(days: i));
      final total = habits.length;
      final done = habits.where((h) => h.isCompletedOn(day)).length;
      final pct = total > 0 ? done / total * 100 : 0.0;
      data.add(_DayData(date: day, pct: pct, done: done, total: total));
    }

    // Show only last N points depending on range to avoid crowding
    final displayStep = rangeDays <= 14 ? 1 : rangeDays <= 30 ? 1 : 3;
    final displayData = <_DayData>[];
    for (int i = 0; i < data.length; i++) {
      if (i % displayStep == 0) displayData.add(data[i]);
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 14),
            child: Text('Completion Rate Harian',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                minY: 0,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final d = displayData[groupIndex];
                      return BarTooltipItem(
                        '${DateFormat('d MMM').format(d.date)}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: '${d.done}/${d.total} · ${d.pct.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (_) => const FlLine(
                    color: AppTheme.sage200,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 34,
                      interval: 25,
                      getTitlesWidget: (v, _) => Text(
                        '${v.toInt()}%',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 26,
                      getTitlesWidget: (v, _) {
                        final idx = v.toInt();
                        if (idx < 0 || idx >= displayData.length) {
                          return const SizedBox.shrink();
                        }
                        // Show label every few bars
                        final labelEvery = displayData.length <= 10
                            ? 1
                            : displayData.length <= 20
                                ? 3
                                : 5;
                        if (idx % labelEvery != 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            DateFormat('d/M').format(displayData[idx].date),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: displayData.asMap().entries.map((e) {
                  final d = e.value;
                  final color = d.pct >= 90
                      ? AppTheme.successGreen
                      : d.pct >= 70
                          ? AppTheme.sage500
                          : d.pct >= 50
                              ? AppTheme.warningAmber
                              : d.pct > 0
                                  ? AppTheme.errorRed.withOpacity(0.7)
                                  : AppTheme.stone200;
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: d.pct,
                        color: color,
                        width: rangeDays <= 14 ? 18 : rangeDays <= 30 ? 10 : 6,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 100,
                          color: AppTheme.stone100,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Color legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _LegendDot(color: AppTheme.successGreen, label: '≥90%'),
              const SizedBox(width: 12),
              const _LegendDot(color: AppTheme.sage500, label: '70–89%'),
              const SizedBox(width: 12),
              const _LegendDot(color: AppTheme.warningAmber, label: '50–69%'),
              const SizedBox(width: 12),
              _LegendDot(color: AppTheme.errorRed.withOpacity(0.7), label: '<50%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayData {
  final DateTime date;
  final double pct;
  final int done;
  final int total;
  const _DayData(
      {required this.date,
      required this.pct,
      required this.done,
      required this.total});
}

class _HabitLeaderboard extends StatelessWidget {
  final List<Habit> habits;
  final int rangeDays;

  const _HabitLeaderboard(
      {required this.habits, required this.rangeDays});

  @override
  Widget build(BuildContext context) {
    // Sort by completion desc
    final sorted = [...habits]
      ..sort((a, b) => b.completionPercent.compareTo(a.completionPercent));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text('Performa Per Habit',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          const Divider(height: 1),
          ...sorted.asMap().entries.map((e) {
            return _HabitLeaderboardRow(
              rank: e.key + 1,
              habit: e.value,
              rangeDays: rangeDays,
            );
          }),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _HabitLeaderboardRow extends StatelessWidget {
  final int rank;
  final Habit habit;
  final int rangeDays;

  const _HabitLeaderboardRow({
    required this.rank,
    required this.habit,
    required this.rangeDays,
  });

  @override
  Widget build(BuildContext context) {
    final completion = habit.completionPercent;
    final streak = habit.streak;
    final color = AppTheme.completionColor(completion);

    // Count done in range
    final today = DateTime.now();
    int doneInRange = 0;
    int totalInRange = 0;
    for (int i = 0; i < rangeDays; i++) {
      final day = today.subtract(Duration(days: i));
      if (!day.isBefore(habit.startDate)) {
        totalInRange++;
        if (habit.isCompletedOn(day)) doneInRange++;
      }
    }
    final rangePct = totalInRange > 0 ? doneInRange / totalInRange * 100 : 0.0;
    final rangeColor = AppTheme.completionColor(rangePct);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.sage200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Rank
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: rank == 1
                      ? AppTheme.accentGold.withOpacity(0.15)
                      : rank == 2
                          ? AppTheme.stone200
                          : AppTheme.sage100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    rank == 1
                        ? '🥇'
                        : rank == 2
                            ? '🥈'
                            : rank == 3
                                ? '🥉'
                                : '$rank',
                    style: TextStyle(
                      fontSize: rank <= 3 ? 13 : 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.stone700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  habit.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreakBadge(streak: streak, fontSize: 11),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 36),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Range completion bar
                    Row(
                      children: [
                        Text(
                          '$rangeDays hari: ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.stone500),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: rangePct / 100,
                              minHeight: 6,
                              backgroundColor: AppTheme.stone100,
                              valueColor:
                                  AlwaysStoppedAnimation(rangeColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${rangePct.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: rangeColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // All-time completion bar
                    Row(
                      children: [
                        Text(
                          'All-time: ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.stone500),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: completion / 100,
                              minHeight: 6,
                              backgroundColor: AppTheme.stone100,
                              valueColor: AlwaysStoppedAnimation(color),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${completion.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════

class _RangeSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _RangeSelector(
      {required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.stone200,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [7, 30, 90].map((days) {
          final isSelected = selected == days;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(days),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.stone300.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$days Hari',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? AppTheme.sage700
                              : AppTheme.stone500,
                        ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StatMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatMiniCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.sage200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppTheme.stone500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  final String message;
  const _EmptyChart({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('📊', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 10),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.stone500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _LegendDash extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDash({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}