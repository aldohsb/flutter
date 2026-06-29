import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';

class EarningTrackerCard extends StatelessWidget {
  const EarningTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningProvider>(
      builder: (context, provider, _) {
        final now = DateTime.now();
        final monthTotal = provider.getMonthlyTotal(now.year, now.month);
        final percentage = provider.getTodayCumulativePercentage();
        final cumTarget = provider.getCumulativeTargetToday();
        final dailyTarget = provider.getDailyTarget(now.year, now.month);
        final todayTotal = provider.getTodayTotal();
        final hasGoal = provider.monthlyTarget > 0;
        final fmt = NumberFormat('#,##0.00', 'en_US');

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Earning',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => _showGoalDialog(context, provider),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => _showAddDialog(context, provider),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Total bulan ini + target
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${fmt.format(monthTotal)}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Bulan ini  •  Hari ini: \$${fmt.format(todayTotal)}',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (hasGoal)
                      _PercentageBadge(percentage: percentage),
                  ],
                ),
                if (hasGoal) ...[
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (percentage / 100).clamp(0.0, 1.5),
                      backgroundColor: Colors.grey[200],
                      color: AppTheme.earningPercentageColor(percentage),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Target s/d hari ini: \$${fmt.format(cumTarget)}',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        'Target/hari: \$${fmt.format(dailyTarget)}',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Target bulan ini: \$${fmt.format(provider.monthlyTarget)}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
                // Entries hari ini
                if (provider.getTodayEntries().isNotEmpty) ...[
                  const Divider(height: 16),
                  const Text('Input hari ini:',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  ...provider.getTodayEntries().take(3).map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          children: [
                            Text(
                              DateFormat('HH:mm').format(e.date),
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${fmt.format(e.amount)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            if (e.note != null && e.note!.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  e.note!,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                            IconButton(
                              icon: const Icon(Icons.close, size: 14),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () =>
                                  provider.deleteEarning(e.id),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      )),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGoalDialog(BuildContext context, EarningProvider provider) {
    final controller = TextEditingController(
        text: provider.monthlyTarget > 0
            ? provider.monthlyTarget.toStringAsFixed(2)
            : '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Target Earning Bulanan'),
        content: TextField(
          controller: controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Target per bulan (USD)',
            prefixText: '\$ ',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(controller.text);
              if (val != null && val > 0) {
                provider.setMonthlyTarget(val);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context, EarningProvider provider) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Earning'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Jumlah (USD)',
                prefixText: '\$ ',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(amountController.text);
              if (val != null && val > 0) {
                provider.addEarning(val,
                    note: noteController.text.trim().isEmpty
                        ? null
                        : noteController.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}

class _PercentageBadge extends StatelessWidget {
  final double percentage;
  const _PercentageBadge({required this.percentage});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.earningPercentageColor(percentage);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            percentage >= 100
                ? Icons.trending_up
                : Icons.trending_down,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
