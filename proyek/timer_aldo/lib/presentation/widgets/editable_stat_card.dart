import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../data/models/statistics.dart';
import '../../data/models/category.dart';

class EditableStatCard extends StatefulWidget {
  final Statistics statistics;
  final Category category;
  final Function(Statistics) onUpdate;
  final Function()? onDelete;
  
  const EditableStatCard({
    super.key,
    required this.statistics,
    required this.category,
    required this.onUpdate,
    this.onDelete,
  });
  
  @override
  State<EditableStatCard> createState() => _EditableStatCardState();
}

class _EditableStatCardState extends State<EditableStatCard> {
  bool _isEditing = false;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  
  @override
  void initState() {
    super.initState();
    final hours = widget.statistics.activeSeconds ~/ 3600;
    final minutes = (widget.statistics.activeSeconds % 3600) ~/ 60;
    _hoursController = TextEditingController(text: hours.toString());
    _minutesController = TextEditingController(text: minutes.toString());
  }
  
  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }
  
  void _saveChanges() {
    final hours = int.tryParse(_hoursController.text) ?? 0;
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    final newActiveSeconds = (hours * 3600) + (minutes * 60);
    
    final updatedStats = widget.statistics.copyWith(
      activeSeconds: newActiveSeconds,
      totalSeconds: newActiveSeconds + widget.statistics.pausedSeconds,
    );
    
    widget.onUpdate(updatedStats);
    setState(() {
      _isEditing = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: widget.category.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, MMMM d, y').format(widget.statistics.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isEditing) ...[
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  ),
                  if (widget.onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: Colors.red,
                      onPressed: widget.onDelete,
                    ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            if (_isEditing) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _hoursController,
                      decoration: const InputDecoration(
                        labelText: 'Hours',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _minutesController,
                      decoration: const InputDecoration(
                        labelText: 'Minutes',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        final hours = widget.statistics.activeSeconds ~/ 3600;
                        final minutes = (widget.statistics.activeSeconds % 3600) ~/ 60;
                        _hoursController.text = hours.toString();
                        _minutesController.text = minutes.toString();
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ] else ...[
              _buildStatRow(
                'Active Time',
                widget.statistics.formattedActive,
                Icons.timer_outlined,
              ),
              const SizedBox(height: 8),
              _buildStatRow(
                'Sessions',
                widget.statistics.sessionCount.toString(),
                Icons.repeat,
              ),
              const SizedBox(height: 8),
              _buildStatRow(
                'Paused Time',
                widget.statistics.formattedPaused,
                Icons.pause_circle_outline,
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
