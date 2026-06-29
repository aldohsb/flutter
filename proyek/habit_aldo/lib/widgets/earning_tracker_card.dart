import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';
import '../screens/earning_stats_screen.dart';

class EarningTrackerCard extends StatelessWidget {
  const EarningTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningProvider>(
      builder: (context, ep, _) {
        final today = DateTime.now();
        final todayTotal = ep.todayTotal;
        final progressPct = ep.todayProgressPercent();
        final monthTarget =
            ep.monthlyTarget(today.year, today.month) ?? 0;
        final fmt = NumberFormat.currency(
            symbol: '\$', decimalDigits: 2, locale: 'en_US');

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.sage200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Row(
                  children: [
                    const Text('💰', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text('Earning',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EarningStatsScreen()),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.sage100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.sage300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.bar_chart_rounded,
                                size: 14, color: AppTheme.sage600),
                            const SizedBox(width: 4),
                            Text('Statistik',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppTheme.sage600,
                                      fontWeight: FontWeight.w600,
                                    )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Today total + Add button ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hari ini',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            fmt.format(todayTotal),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 28,
                                  color: AppTheme.accentGold,
                                ),
                          ),
                          if (monthTarget > 0)
                            Text(
                              'Target bulan ini: ${fmt.format(monthTarget)}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddDialog(context, ep),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Catat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentGold,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),

                // ── Progress bar ──
                if (progressPct != null) ...[
                  const SizedBox(height: 14),
                  _EarningProgressBar(percent: progressPct),
                ],

                // ── Today's entries mini list ──
                if (ep.todayEntries.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  ...ep.todayEntries.reversed.take(3).map(
                        (e) => _MiniEntryRow(
                          amount: fmt.format(e.amount),
                          note: e.note,
                          time: DateFormat('HH:mm').format(e.date),
                          onDelete: () => ep.deleteEntry(e.id),
                        ),
                      ),
                  if (ep.todayEntries.length > 3)
                    Text(
                      '+ ${ep.todayEntries.length - 3} entri lainnya',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppTheme.sage600),
                    ),
                ],

                // ── Set target button ──
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () => _showTargetDialog(context, ep, today),
                  icon: const Icon(Icons.flag_outlined,
                      size: 14, color: AppTheme.sage600),
                  label: Text(
                    monthTarget > 0
                        ? 'Ubah target bulan ini'
                        : 'Set target bulan ini',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppTheme.sage600),
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddDialog(BuildContext context, EarningProvider ep) {
    final amtCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Catat Earning',
            style: Theme.of(ctx).textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amtCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Jumlah (USD)',
                prefixText: '\$ ',
                hintText: '0.00',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                hintText: 'Sumber, keterangan...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amtCtrl.text);
              if (amount != null && amount > 0) {
                ep.addEntry(amount, note: noteCtrl.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showTargetDialog(
      BuildContext context, EarningProvider ep, DateTime today) {
    final existing =
        ep.monthlyTarget(today.year, today.month)?.toStringAsFixed(2) ?? '';
    final ctrl = TextEditingController(text: existing);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Target Earning',
            style: Theme.of(ctx).textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM yyyy').format(today),
              style: Theme.of(ctx).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ctrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Target (USD)',
                prefixText: '\$ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final target = double.tryParse(ctrl.text);
              if (target != null && target > 0) {
                ep.setMonthlyTarget(today.year, today.month, target);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

class _EarningProgressBar extends StatelessWidget {
  final double percent;
  const _EarningProgressBar({required this.percent});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.completionColor(percent);
    final label = '${percent.toStringAsFixed(1)}% dari target harian kumulatif';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (percent / 100).clamp(0.0, 1.5),
            backgroundColor: AppTheme.stone200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _MiniEntryRow extends StatelessWidget {
  final String amount;
  final String note;
  final String time;
  final VoidCallback onDelete;

  const _MiniEntryRow({
    required this.amount,
    required this.note,
    required this.time,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppTheme.accentGold,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note.isNotEmpty ? '$amount · $note' : amount,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(time, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 4),
          InkWell(
            onTap: onDelete,
            child: const Icon(Icons.close_rounded,
                size: 14, color: AppTheme.stone300),
          ),
        ],
      ),
    );
  }
}
