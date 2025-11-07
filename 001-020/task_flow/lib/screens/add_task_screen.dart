// Screen untuk menambah atau mengedit task
// Screen = halaman penuh dalam aplikasi

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart';
import '../widgets/category_chip.dart';
import '../widgets/priority_indicator.dart';

class AddTaskScreen extends StatefulWidget {
  // StatefulWidget = widget yang punya state yang bisa berubah
  final Task? task; // Null jika mode add, ada value jika mode edit

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // GlobalKey untuk form validation
  // Key untuk mengakses state Form dari luar
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk text input
  // Controller = objek untuk kontrol dan baca value dari TextField
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  // Variables untuk menyimpan pilihan user
  late String _selectedCategory;
  late String _selectedPriority;
  late DateTime _selectedDeadline;

  @override
  void initState() {
    // initState = dipanggil sekali saat widget pertama kali dibuat
    super.initState();

    // Inisialisasi controllers dan variables
    // Jika mode edit (widget.task != null), isi dengan data task
    // Jika mode add (widget.task == null), isi dengan nilai default
    _titleController = TextEditingController(
      text: widget.task?.title ?? '', // ?? = jika null, pakai ''
    );
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _selectedCategory = widget.task?.category ?? AppConstants.categories[0];
    _selectedPriority = widget.task?.priority ?? AppConstants.priorities[1];
    _selectedDeadline = widget.task?.deadline ?? DateTime.now();
  }

  @override
  void dispose() {
    // dispose = dipanggil saat widget dihapus dari tree
    // Penting untuk dispose controller agar tidak memory leak
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Method untuk save task
  Future<void> _saveTask() async {
    // Validasi form
    if (!_formKey.currentState!.validate()) {
      return; // Jika tidak valid, stop
    }

    final taskProvider = context.read<TaskProvider>();

    if (widget.task == null) {
      // Mode ADD: buat task baru
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // ID unik dari timestamp
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        priority: _selectedPriority,
        deadline: _selectedDeadline,
        createdAt: DateTime.now(),
      );
      await taskProvider.addTask(newTask);
    } else {
      // Mode EDIT: update task yang ada
      final updatedTask = widget.task!.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        priority: _selectedPriority,
        deadline: _selectedDeadline,
      );
      await taskProvider.updateTask(updatedTask);
    }

    // Kembali ke screen sebelumnya
    if (mounted) {
      // mounted check = pastikan widget masih ada di tree
      Navigator.pop(context);
    }
  }

  // Method untuk pilih tanggal
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)), // 2 tahun ke depan
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppConstants.categoryColors[_selectedCategory]!,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Pick waktu setelah tanggal dipilih
      if (mounted) {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_selectedDeadline),
        );

        if (time != null && mounted) {
          setState(() {
            // setState = beritahu Flutter bahwa ada state yang berubah
            // Flutter akan rebuild widget ini
            _selectedDeadline = DateTime(
              picked.year,
              picked.month,
              picked.day,
              time.hour,
              time.minute,
            );
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan mode (add atau edit)
    final isEditMode = widget.task != null;

    return Scaffold(
      // Scaffold = struktur dasar screen dengan AppBar dan Body
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Task' : 'Add New Task'),
        backgroundColor: AppConstants.categoryColors[_selectedCategory],
        foregroundColor: Colors.white, // Warna text dan icon di AppBar
        elevation: 0, // Hilangkan bayangan AppBar
      ),
      body: Form(
        // Form = wrapper untuk form validation
        key: _formKey,
        child: ListView(
          // ListView = scrollable column
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          children: [
            // Title input
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                hintText: 'Enter task title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                // Validator = fungsi untuk validasi input
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title'; // Error message
                }
                return null; // null = valid
              },
            ),

            const SizedBox(height: 16),

            // Description input
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Enter task description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Textarea dengan 3 baris
              textCapitalization: TextCapitalization.sentences,
            ),

            const SizedBox(height: 24),

            // Category selection
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.categories.map((category) {
                return CategoryChip(
                  category: category,
                  isSelected: _selectedCategory == category,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Priority selection
            const Text(
              'Priority',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.priorities.map((priority) {
                final isSelected = _selectedPriority == priority;
                final color = AppConstants.priorityColors[priority]!;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPriority = priority;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? color : color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: color.withOpacity(0.5),
                              width: 1.5,
                            ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flag,
                          size: 16,
                          color: isSelected ? Colors.white : color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          priority,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Deadline picker
            const Text(
              'Deadline',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppConstants.categoryColors[_selectedCategory],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateHelper.formatDate(_selectedDeadline),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            DateHelper.formatTime(_selectedDeadline),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Save button
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.categoryColors[_selectedCategory],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                isEditMode ? 'Update Task' : 'Create Task',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}