import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weight_provider.dart';
import '../theme/app_theme.dart';
import 'weight_goal_dialog.dart';

class WeightTrackerCard extends StatelessWidget {
  const WeightTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeightProvider>(
      builder: (context, provider, _) {
        final goal = provider.goal;
        final currentWeight = provider.currentWeight;
        final todayTarget = provider.getTodayTargetWeight();
        final percentage = provider.getTodayPercentage();

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.monitor_weight_outlined, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Berat Badan',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => const WeightGoalDialog(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (goal == null)
                  TextButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const WeightGoalDialog(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Set Target Berat Badan'),
                  )
                else ...[
                  Row(
                    children: [
                      // Input berat - tombol naik turun
                      _WeightInput(
                        currentWeight: currentWeight,
                        provider: provider,
                      ),
                      const SizedBox(width: 16),
                      // Info target & persentase
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (todayTarget != null)
                              Text(
                                'Target hari ini: ${todayTarget.toStringAsFixed(1)} kg',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            Text(
                              'Target akhir: ${goal.targetWeight.toStringAsFixed(1)} kg',
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                            if (percentage != null) ...[
                              const SizedBox(height: 6),
                              _PercentageBadge(percentage: percentage),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (percentage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (percentage / 100).clamp(0.0, 1.5),
                        backgroundColor: Colors.grey[200],
                        color: AppTheme.weightPercentageColor(percentage),
                        minHeight: 6,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mulai: ${goal.startWeight.toStringAsFixed(1)} kg',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        'Sisa: ${(currentWeight - goal.targetWeight).toStringAsFixed(1)} kg',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WeightInput extends StatelessWidget {
  final double currentWeight;
  final WeightProvider provider;

  const _WeightInput({required this.currentWeight, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => provider.adjustWeight(0.1),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.primaryOlive.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard_arrow_up,
                color: AppTheme.primaryOlive),
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onLongPress: () => _showManualInput(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.lightOlive),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${currentWeight.toStringAsFixed(1)} kg',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => provider.adjustWeight(-0.1),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard_arrow_down, color: Colors.red),
          ),
        ),
      ],
    );
  }

  void _showManualInput(BuildContext context) {
    final controller =
        TextEditingController(text: currentWeight.toStringAsFixed(1));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Input Berat Badan'),
        content: TextField(
          controller: controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Berat (kg)',
            suffixText: 'kg',
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
              if (val != null) {
                provider.setTodayWeight(val);
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
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
    final color = AppTheme.weightPercentageColor(percentage);
    final isGood = percentage <= 100;
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
            isGood ? Icons.trending_down : Icons.warning_amber_rounded,
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
