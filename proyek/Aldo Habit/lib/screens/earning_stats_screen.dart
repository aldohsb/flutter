import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';

class EarningStatsScreen extends StatefulWidget {
  const EarningStatsScreen({super.key});

  @override
  State<EarningStatsScreen> createState() => _EarningStatsScreenState();
}

class _EarningStatsScreenState extends State<EarningStatsScreen> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  final fmt = NumberFormat('#,##0.00', 'en_US');

  final monthNames = [
    '',
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningProvider>(
      builder: (context, provider, _) {
        final allTime = provider.totalAllTime;
        final monthlyTotals = provider.getMonthlyTotals();
        final monthEntries =
            provider.getEntriesForMonth(_selectedYear, _selectedMonth);
        final monthTotal =
            provider.getMonthlyTotal(_selectedYear, _selectedMonth);
        final monthTarget = provider.monthlyTarget;

        // Urutan bulan dari yang terbaru
        final sortedMonths = monthlyTotals.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return Scaffold(
          appBar: AppBar(title: const Text('Statistik Earning')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Total all time
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Total Semua Waktu',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(
                        '\$${fmt.format(allTime)}',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Statistik per bulan - summary
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                      child: Text(
                        'Per Bulan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    if (sortedMonths.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Belum ada data',
                            style: TextStyle(color: Colors.grey)),
                      )
                    else
                      ...sortedMonths.map((key) {
                        final parts = key.split('-');
                        final year = int.parse(parts[0]);
                        final month = int.parse(parts[1]);
                        final total = monthlyTotals[key]!;
                        final pct = monthTarget > 0
                            ? (total / monthTarget) * 100
                            : null;
                        return ListTile(
                          title: Text('${monthNames[month]} $year'),
                          subtitle: pct != null
                              ? Text('${pct.toStringAsFixed(1)}% dari target',
                                  style: TextStyle(
                                      color: AppTheme.earningPercentageColor(pct),
                                      fontSize: 12))
                              : null,
                          trailing: Text(
                            '\$${fmt.format(total)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          onTap: () => setState(() {
                            _selectedYear = year;
                            _selectedMonth = month;
                          }),
                        );
                      }),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Detail bulan yang dipilih
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${monthNames[_selectedMonth]} $_selectedYear',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '\$${fmt.format(monthTotal)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    if (monthTarget > 0) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (monthTotal / monthTarget).clamp(0.0, 1.5),
                                backgroundColor: Colors.grey[200],
                                color: AppTheme.earningPercentageColor(
                                    (monthTotal / monthTarget) * 100),
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Target: \$${fmt.format(monthTarget)}',
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                                Text(
                                    '${((monthTotal / monthTarget) * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppTheme.earningPercentageColor(
                                            (monthTotal / monthTarget) * 100),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (monthEntries.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Tidak ada transaksi bulan ini',
                            style: TextStyle(color: Colors.grey)),
                      )
                    else
                      ...monthEntries.map((e) {
                        return ListTile(
                          dense: true,
                          title: Row(
                            children: [
                              Text(
                                '\$${fmt.format(e.amount)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              if (e.note != null && e.note!.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    e.note!,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          subtitle: Text(
                            DateFormat('dd/MM HH:mm').format(e.date),
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline,
                                size: 18, color: Colors.grey),
                            onPressed: () => provider.deleteEarning(e.id),
                          ),
                        );
                      }),
                    const SizedBox(height: 8),
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
