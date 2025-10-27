import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zentime/providers/project_provider.dart';
import 'package:zentime/utils/constants.dart';

class AddEditProjectScreen extends StatefulWidget {
  final String? projectId;
  
  const AddEditProjectScreen({super.key, this.projectId});
  
  @override
  State<AddEditProjectScreen> createState() => _AddEditProjectScreenState();
}

class _AddEditProjectScreenState extends State<AddEditProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dailyTargetController = TextEditingController();
  final _weeklyTargetController = TextEditingController();
  
  Color _selectedColor = AppConstants.primaryColor;
  
  final List<Color> _colorOptions = [
    AppConstants.primaryColor,
    const Color(0xFF2196F3),
    const Color(0xFFF44336),
    const Color(0xFFFF9800),
    const Color(0xFF9C27B0),
    const Color(0xFF4CAF50),
    const Color(0xFFE91E63),
    const Color(0xFF00BCD4),
  ];
  
  @override
  void initState() {
    super.initState();
    if (widget.projectId != null) {
      _loadProject();
    } else {
      _dailyTargetController.text = '2';
      _weeklyTargetController.text = '10';
    }
  }
  
  void _loadProject() {
    final projectProvider = context.read<ProjectProvider>();
    final project = projectProvider.getProject(widget.projectId!);
    
    if (project != null) {
      _nameController.text = project.name;
      _descriptionController.text = project.description ?? '';
      _dailyTargetController.text = project.dailyTargetHours.toString();
      _weeklyTargetController.text = project.weeklyTargetHours.toString();
      _selectedColor = Color(project.colorValue);
    }
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dailyTargetController.dispose();
    _weeklyTargetController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isEdit = widget.projectId != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Project' : 'New Project'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                hintText: 'Enter project name',
                prefixIcon: Icon(Icons.label),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter project name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Enter project description',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Project Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colorOptions.map((color) {
                final isSelected = color.value == _selectedColor.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dailyTargetController,
                    decoration: const InputDecoration(
                      labelText: 'Daily Target (hours)',
                      prefixIcon: Icon(Icons.today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      final number = double.tryParse(value);
                      if (number == null || number <= 0) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _weeklyTargetController,
                    decoration: const InputDecoration(
                      labelText: 'Weekly Target (hours)',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      final number = double.tryParse(value);
                      if (number == null || number <= 0) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _saveProject,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                isEdit ? 'Update Project' : 'Create Project',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            
            if (isEdit) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _deleteProject,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppConstants.errorColor,
                  side: const BorderSide(color: AppConstants.errorColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Delete Project',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  void _saveProject() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final projectProvider = context.read<ProjectProvider>();
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final dailyTarget = double.parse(_dailyTargetController.text);
    final weeklyTarget = double.parse(_weeklyTargetController.text);
    
    if (widget.projectId != null) {
      await projectProvider.updateProject(
        projectId: widget.projectId!,
        name: name,
        description: description.isEmpty ? null : description,
        color: _selectedColor,
        dailyTargetHours: dailyTarget,
        weeklyTargetHours: weeklyTarget,
      );
    } else {
      await projectProvider.addProject(
        name: name,
        description: description.isEmpty ? null : description,
        color: _selectedColor,
        dailyTargetHours: dailyTarget,
        weeklyTargetHours: weeklyTarget,
      );
    }
    
    if (mounted) {
      Navigator.pop(context);
    }
  }
  
  void _deleteProject() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: const Text(
          'Are you sure you want to delete this project? All sessions will also be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final projectProvider = context.read<ProjectProvider>();
              await projectProvider.deleteProject(widget.projectId!);
              if (mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.errorColor,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}