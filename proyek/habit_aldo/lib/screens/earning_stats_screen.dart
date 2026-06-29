import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';

class EarningStatsScreen extends StatelessWidget {
  const EarningStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningProvider>(
      builder: (context, ep, _) {
        final fmt = NumberFormat.currency(
            symbol: '\$', decimalDigits: 2, locale: 'en_US');
        final summary = ep.monthlySummary;

        return Scaffold(
          backgroundColor: AppTheme.sage100,
          appBar: AppBar(title: const Text('Statistik Earning')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Total all time ──
              _StatCard(
                label: 'Total Semua Waktu',
                value: fmt.format(ep.allTimeTotal),
                icon: '💼',
                color: AppTheme.accentGold,
              ),

              // ── Bar chart ──
              if (summary.length >= 2) ...[
                const SizedBox(height: 12),
                _MonthlyBarChart(summary: summary, fmt: fmt),
              ],

              const SizedBox(height: 12),

              // ── Monthly table ──
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.sage200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                      child: Text(
                        'Per Bulan',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Divider(height: 1),
                    if (summary.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Belum ada data earning.',
                            style: TextStyle(color: AppTheme.stone500),
                          ),
                        ),
                      ),
                    ...summary.reversed.map((s) {
                      final year = s['year'] as int;
                      final month = s['month'] as int;
                      final total = s['total'] as double;
                      final target = ep.monthlyTarget(year, month) ?? 0;
                      final pct = target > 0 ? (total / target * 100) : null;

                      return _MonthRow(
                        label: DateFormat('MMMM yyyy')
                            .format(DateTime(year, month)),
                        total: fmt.format(total),
                        target: target > 0 ? fmt.format(target) : null,
                        pct: pct,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.sage200),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              Text(
                value,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 26,
                      color: color,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> summary;
  final NumberFormat fmt;

  const _MonthlyBarChart({required this.summary, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final data = summary.takeLast(6).toList();
    final maxY =
        data.map((s) => s['total'] as double).reduce((a, b) => a > b ? a : b) *
            1.2;

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
          Text('6 Bulan Terakhir',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 14),
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barGroups: data.asMap().entries.map((e) {
                  final total = e.value['total'] as double;
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: total,
                        color: AppTheme.accentGold,
                        width: 22,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: AppTheme.stone100,
                        ),
                      ),
                    ],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 48,
                      getTitlesWidget: (v, _) => Text(
                        '\$${(v / 1000).toStringAsFixed(0)}k',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final idx = v.toInt();
                        if (idx < 0 || idx >= data.length) return const SizedBox.shrink();
                        final month = data[idx]['month'] as int;
                        return Text(
                          DateFormat('MMM')
                              .format(DateTime(2024, month)),
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) =>
                      const FlLine(color: AppTheme.stone200, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthRow extends StatelessWidget {
  final String label;
  final String total;
  final String? target;
  final double? pct;

  const _MonthRow({
    required this.label,
    required this.total,
    this.target,
    this.pct,
  });

  @override
  Widget build(BuildContext context) {
    final color = pct != null ? AppTheme.completionColor(pct!) : AppTheme.stone500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.sage200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
                if (target != null)
                  Text(
                    'Target: $target',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                total,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.accentGold,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (pct != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${pct!.toStringAsFixed(0)}%',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: color),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

extension _TakeLast<T> on List<T> {
  List<T> takeLast(int n) =>
      length <= n ? this : sublist(length - n);
}
