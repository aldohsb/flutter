import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weight_provider.dart';

class WeightGoalDialog extends StatefulWidget {
  const WeightGoalDialog({super.key});

  @override
  State<WeightGoalDialog> createState() => _WeightGoalDialogState();
}

class _WeightGoalDialogState extends State<WeightGoalDialog> {
  final _startController = TextEditingController();
  final _targetController = TextEditingController();
  final _daysController = TextEditingController();
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final provider = context.read<WeightProvider>();
    final goal = provider.goal;
    if (goal != null) {
      _startController.text = goal.startWeight.toStringAsFixed(1);
      _targetController.text = goal.targetWeight.toStringAsFixed(1);
      _daysController.text = goal.targetDays.toString();
      _startDate = goal.startDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Target Berat Badan'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _startController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Berat awal (kg)',
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _targetController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Target berat (kg)',
                suffixText: 'kg',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _daysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target hari',
                suffixText: 'hari',
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tanggal mulai'),
              subtitle: Text(
                '${_startDate.day}/${_startDate.month}/${_startDate.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => _startDate = picked);
              },
            ),
            // Preview penurunan harian
            if (_startController.text.isNotEmpty &&
                _targetController.text.isNotEmpty &&
                _daysController.text.isNotEmpty)
              Builder(builder: (_) {
                final start = double.tryParse(_startController.text);
                final target = double.tryParse(_targetController.text);
                final days = int.tryParse(_daysController.text);
                if (start != null && target != null && days != null && days > 0) {
                  final daily = (target - start) / days;
                  return Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Penurunan harian: ${daily.abs().toStringAsFixed(3)} kg/hari',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.blueGrey),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Simpan'),
        ),
      ],
    );
  }

  void _save() {
    final start = double.tryParse(_startController.text);
    final target = double.tryParse(_targetController.text);
    final days = int.tryParse(_daysController.text);
    if (start == null || target == null || days == null || days <= 0) return;

    context.read<WeightProvider>().setGoal(
          startWeight: start,
          targetWeight: target,
          startDate: _startDate,
          targetDays: days,
        );
    Navigator.pop(context);
  }
}
