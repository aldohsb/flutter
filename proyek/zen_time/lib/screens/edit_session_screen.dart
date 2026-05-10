import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/utils/time_formatter.dart';

class EditSessionScreen extends StatefulWidget {
  final String sessionId;
  
  const EditSessionScreen({super.key, required this.sessionId});
  
  @override
  State<EditSessionScreen> createState() => _EditSessionScreenState();
}

class _EditSessionScreenState extends State<EditSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;
  
  @override
  void initState() {
    super.initState();
    _loadSession();
  }
  
  void _loadSession() {
    final session = HiveService.getSession(widget.sessionId);
    if (session != null) {
      _startDate = DateTime(
        session.startTime.year,
        session.startTime.month,
        session.startTime.day,
      );
      _startTime = TimeOfDay(
        hour: session.startTime.hour,
        minute: session.startTime.minute,
      );
      
      if (session.endTime != null) {
        _endDate = DateTime(
          session.endTime!.year,
          session.endTime!.month,
          session.endTime!.day,
        );
        _endTime = TimeOfDay(
          hour: session.endTime!.hour,
          minute: session.endTime!.minute,
        );
      }
      
      _notesController.text = session.notes ?? '';
    }
  }
  
  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final session = HiveService.getSession(widget.sessionId);
    
    if (session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Session Not Found')),
        body: const Center(child: Text('Session not found')),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Session'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Start Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectStartDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _startDate != null
                            ? TimeFormatter.formatDate(_startDate!)
                            : 'Select date',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectStartTime(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        _startTime != null
                            ? _startTime!.format(context)
                            : 'Select time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text(
              'End Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectEndDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _endDate != null
                            ? TimeFormatter.formatDate(_endDate!)
                            : 'Select date',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectEndTime(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        _endTime != null
                            ? _endTime!.format(context)
                            : 'Select time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            if (_startDate != null &&
                _startTime != null &&
                _endDate != null &&
                _endTime != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      TimeFormatter.formatDuration(_calculateDuration()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
                hintText: 'Add notes about this session',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _saveSession,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _selectStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (date != null) {
      setState(() {
        _startDate = date;
      });
    }
  }
  
  Future<void> _selectStartTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    
    if (time != null) {
      setState(() {
        _startTime = time;
      });
    }
  }
  
  Future<void> _selectEndDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );
    
    if (date != null) {
      setState(() {
        _endDate = date;
      });
    }
  }
  
  Future<void> _selectEndTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    
    if (time != null) {
      setState(() {
        _endTime = time;
      });
    }
  }
  
  int _calculateDuration() {
    if (_startDate == null ||
        _startTime == null ||
        _endDate == null ||
        _endTime == null) {
      return 0;
    }
    
    final start = DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
    
    final end = DateTime(
      _endDate!.year,
      _endDate!.month,
      _endDate!.day,
      _endTime!.hour,
      _endTime!.minute,
    );
    
    return end.difference(start).inSeconds;
  }
  
  void _saveSession() async {
    if (_startDate == null ||
        _startTime == null ||
        _endDate == null ||
        _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all date and time fields')),
      );
      return;
    }
    
    final duration = _calculateDuration();
    
    if (duration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }
    
    final session = HiveService.getSession(widget.sessionId);
    if (session == null) return;
    
    final startDateTime = DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
    
    final endDateTime = DateTime(
      _endDate!.year,
      _endDate!.month,
      _endDate!.day,
      _endTime!.hour,
      _endTime!.minute,
    );
    
    final updatedSession = session.copyWith(
      startTime: startDateTime,
      endTime: endDateTime,
      durationSeconds: duration,
      notes: _notesController.text.trim().isEmpty 
          ? null 
          : _notesController.text.trim(),
      updatedAt: DateTime.now(),
    );
    
    await HiveService.updateSession(updatedSession);
    
    if (mounted) {
      context.read<ProjectProvider>().loadProjects();
      Navigator.pop(context);
    }
  }
}