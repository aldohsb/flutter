import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weight_provider.dart';
import '../theme/app_theme.dart';

class WeightTrackerCard extends StatelessWidget {
  const WeightTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeightProvider>(
      builder: (context, wp, _) {
        final today = DateTime.now();
        final current = wp.currentWeight;
        final target = wp.targetForToday();
        final goal = wp.goal;
        final deviation = target != null && current > 0
            ? ((current - target) / target) * 100
            : null;

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
                    const Text('⚖️', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Berat Badan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    _SetupButton(
                      onTap: () => _showGoalDialog(context, wp),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Main weight row ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Decrease button
                    _WeightButton(
                      icon: Icons.remove_rounded,
                      onTap: () => wp.adjustWeight(-0.1),
                    ),
                    const SizedBox(width: 12),

                    // Weight display
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            current > 0
                                ? '${current.toStringAsFixed(1)} kg'
                                : '— kg',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 36,
                                  color: AppTheme.sage700,
                                ),
                          ),
                          if (target != null)
                            Text(
                              'Target hari ini: ${target.toStringAsFixed(2)} kg',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),
                    // Increase button
                    _WeightButton(
                      icon: Icons.add_rounded,
                      onTap: () => wp.adjustWeight(0.1),
                    ),
                  ],
                ),

                // ── Progress indicator ──
                if (deviation != null) ...[
                  const SizedBox(height: 14),
                  _DeviationBar(deviation: deviation),
                ],

                // ── Goal info ──
                if (goal != null) ...[
                  const SizedBox(height: 10),
                  _GoalInfo(goal: goal),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGoalDialog(BuildContext context, WeightProvider wp) {
    final goal = wp.goal;
    final startCtrl = TextEditingController(
        text: goal?.startWeightKg.toStringAsFixed(1) ?? '');
    final targetCtrl = TextEditingController(
        text: goal?.targetWeightKg.toStringAsFixed(1) ?? '');
    final daysCtrl = TextEditingController(
        text: goal?.durationDays.toString() ?? '');
    DateTime startDate = goal?.startDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppTheme.stone100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Target Berat Badan',
              style: Theme.of(ctx).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: 'Berat Awal (kg)',
                    suffixText: 'kg'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: targetCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    labelText: 'Target Berat (kg)',
                    suffixText: 'kg'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: daysCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Durasi (hari)',
                    suffixText: 'hari'),
              ),
              const SizedBox(height: 10),
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
                        'Mulai: ${startDate.day}/${startDate.month}/${startDate.year}',
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
                child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                final sw = double.tryParse(startCtrl.text);
                final tw = double.tryParse(targetCtrl.text);
                final d = int.tryParse(daysCtrl.text);
                if (sw != null && tw != null && d != null && d > 0) {
                  wp.setGoal(
                    startWeight: sw,
                    targetWeight: tw,
                    startDate: startDate,
                    durationDays: d,
                  );
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _WeightButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.sage100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: AppTheme.sage700, size: 22),
        ),
      ),
    );
  }
}

class _DeviationBar extends StatelessWidget {
  final double deviation; // positive = above target (bad for weight loss)

  const _DeviationBar({required this.deviation});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.weightDeviationColor(deviation);
    final isGood = deviation <= 0;
    final label = isGood
        ? '${deviation.abs().toStringAsFixed(1)}% di bawah target ✓'
        : '${deviation.toStringAsFixed(1)}% di atas target ⚠';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (deviation.abs().clamp(0, 10) / 10),
                  backgroundColor: AppTheme.stone200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ),
          ],
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

class _GoalInfo extends StatelessWidget {
  final dynamic goal;
  const _GoalInfo({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.sage100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InfoChip(
              label: 'Target Akhir',
              value: '${goal.targetWeightKg.toStringAsFixed(1)} kg'),
          _InfoChip(
              label: 'Turun/hari',
              value: '${goal.dailyLossKg.toStringAsFixed(3)} kg'),
          _InfoChip(label: 'Durasi', value: '${goal.durationDays} hari'),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.sage700,
                    fontSize: 13)),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppTheme.stone500)),
      ],
    );
  }
}

class _SetupButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SetupButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.sage100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.sage300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.tune_rounded,
                size: 14, color: AppTheme.sage600),
            const SizedBox(width: 4),
            Text('Setup',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.sage600,
                      fontWeight: FontWeight.w600,
                    )),
          ],
        ),
      ),
    );
  }
}
