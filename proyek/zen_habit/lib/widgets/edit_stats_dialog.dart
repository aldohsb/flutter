import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/habit_provider.dart';

class EditStatsDialog extends StatefulWidget {
  final String habitId;

  const EditStatsDialog({super.key, required this.habitId});

  @override
  State<EditStatsDialog> createState() => _EditStatsDialogState();
}

class _EditStatsDialogState extends State<EditStatsDialog> {
  late TextEditingController _streakController;
  final _formKey = GlobalKey<FormState>();
  List<DateTime> _selectedDates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Load data after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HabitProvider>(context, listen: false);
      final habit = provider.getHabitById(widget.habitId);
      
      if (habit != null) {
        setState(() {
          _streakController = TextEditingController(
            text: habit.streak.toString(),
          );
          _selectedDates = List.from(habit.completionHistory);
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _streakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AlertDialog(
      title: const Text('Edit Statistics'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _streakController,
                decoration: const InputDecoration(
                  labelText: 'Current Streak (days)',
                  prefixIcon: Icon(Icons.local_fire_department),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a streak value';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Completion History',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextButton.icon(
                    onPressed: _addDate,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Date'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_selectedDates.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'No dates added',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _selectedDates.length,
                      itemBuilder: (context, index) {
                        final sortedDates = List<DateTime>.from(_selectedDates)
                          ..sort((a, b) => b.compareTo(a));
                        final date = sortedDates[index];
                        return ListTile(
                          dense: true,
                          title: Text(
                            DateFormat('EEEE, d MMM yyyy').format(date),
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            onPressed: () {
                              setState(() {
                                _selectedDates.removeWhere((d) =>
                                    d.year == date.year &&
                                    d.month == date.month &&
                                    d.day == date.day);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _addDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final normalizedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      
      // Check if date already exists
      final exists = _selectedDates.any((date) =>
          date.year == normalizedDate.year &&
          date.month == normalizedDate.month &&
          date.day == normalizedDate.day);
      
      if (!exists) {
        setState(() {
          _selectedDates.add(normalizedDate);
        });
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<HabitProvider>(context, listen: false);
      final newStreak = int.parse(_streakController.text);
      
      // Update history first
      await provider.updateHabitHistory(widget.habitId, _selectedDates);
      
      // Then update streak manually (this will override the auto-calculated one)
      await provider.updateHabitStreak(widget.habitId, newStreak);
      
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}