// Home Screen - Halaman utama aplikasi yang menampilkan daftar tasks
// Ini adalah screen paling kompleks karena ada banyak fitur

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/category_chip.dart';
import '../utils/constants.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load tasks saat screen pertama kali dibuka
    // addPostFrameCallback = jalankan setelah frame pertama selesai render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().loadTasks();
    });
  }

  // Method untuk show dialog konfirmasi delete
  Future<void> _showDeleteConfirmation(String taskId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // Jika user confirm, hapus task
    if (confirmed == true && mounted) {
      await context.read<TaskProvider>().deleteTask(taskId);
      // Show snackbar sebagai feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted')),
        );
      }
    }
  }

  // Method untuk navigasi ke add/edit screen
  Future<void> _navigateToAddEditScreen({task}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(task: task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Background abu-abu muda
      appBar: AppBar(
        title: const Text(
          'TaskFlow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6366F1), // Indigo
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
            tooltip: 'Filter tasks',
          ),
          // More options menu
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'stats',
                child: Row(
                  children: [
                    Icon(Icons.bar_chart, size: 20),
                    SizedBox(width: 8),
                    Text('Statistics'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Clear All Tasks', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'stats') {
                _showStatsDialog();
              } else if (value == 'clear') {
                _showClearAllConfirmation();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header dengan statistik
          _buildStatsHeader(),
          
          // Category filter horizontal scroll
          _buildCategoryFilter(),

          // Task list
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      // Floating Action Button untuk add task
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddEditScreen(),
        backgroundColor: const Color(0xFF6366F1),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  // Widget untuk header dengan statistik
  Widget _buildStatsHeader() {
    // Consumer = widget yang listen ke perubahan provider dan rebuild
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: const BoxDecoration(
            color: Color(0xFF6366F1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Grid statistik
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total',
                      taskProvider.totalTasks.toString(),
                      Icons.task_alt,
                      Colors.white.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Pending',
                      taskProvider.pendingTasks.toString(),
                      Icons.pending_actions,
                      Colors.orange.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Done',
                      taskProvider.completedTasks.toString(),
                      Icons.check_circle,
                      Colors.green.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget untuk satu stat card
  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk category filter
  Widget _buildCategoryFilter() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal, // Horizontal scroll
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            children: [
              // Chip "All"
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CategoryChip(
                  category: 'All',
                  isSelected: taskProvider.selectedCategory == 'All',
                  onTap: () => taskProvider.setCategory('All'),
                ),
              ),
              // Chips untuk setiap kategori
              ...AppConstants.categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CategoryChip(
                    category: category,
                    isSelected: taskProvider.selectedCategory == category,
                    onTap: () => taskProvider.setCategory(category),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  // Widget untuk daftar tasks dengan drag & drop
  Widget _buildTaskList() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final tasks = taskProvider.tasks;

        if (tasks.isEmpty) {
          // Empty state
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_outlined,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No tasks yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the button below to add your first task',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        // ReorderableListView untuk drag & drop
        return ReorderableListView.builder(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          itemCount: tasks.length,
          // onReorder dipanggil saat user drag & drop item
          onReorder: (oldIndex, newIndex) {
            taskProvider.reorderTasks(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            final task = tasks[index];
            // Key unik untuk setiap item (penting untuk reorderable list)
            return TaskCard(
              key: ValueKey(task.id),
              task: task,
              onEdit: () => _navigateToAddEditScreen(task: task),
              onDelete: () => _showDeleteConfirmation(task.id),
            );
          },
        );
      },
    );
  }

  // Bottom sheet untuk filter
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Filter by priority
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
                    children: ['All', ...AppConstants.priorities].map((priority) {
                      final isSelected = taskProvider.selectedPriority == priority;
                      final color = priority == 'All'
                          ? Colors.grey
                          : AppConstants.priorityColors[priority]!;
                      
                      return FilterChip(
                        label: Text(priority),
                        selected: isSelected,
                        onSelected: (selected) {
                          taskProvider.setPriority(priority);
                          Navigator.pop(context);
                        },
                        selectedColor: color.withOpacity(0.2),
                        checkmarkColor: color,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Show completed only toggle
                  SwitchListTile(
                    title: const Text('Show completed only'),
                    value: taskProvider.showCompletedOnly,
                    onChanged: (value) {
                      taskProvider.toggleCompletedFilter();
                    },
                    activeThumbColor: const Color(0xFF6366F1),
                  ),
                  const SizedBox(height: 16),
                  // Clear filters button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        taskProvider.clearFilters();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                      child: const Text('Clear Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Dialog untuk statistik
  void _showStatsDialog() {
    final taskProvider = context.read<TaskProvider>();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatRow('Total Tasks', taskProvider.totalTasks),
            _buildStatRow('Completed', taskProvider.completedTasks),
            _buildStatRow('Pending', taskProvider.pendingTasks),
            _buildStatRow('Overdue', taskProvider.overdueTasks),
            const Divider(),
            Text(
              'Completion Rate: ${taskProvider.totalTasks > 0 ? ((taskProvider.completedTasks / taskProvider.totalTasks) * 100).toStringAsFixed(1) : 0}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Konfirmasi clear all tasks
  Future<void> _showClearAllConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Tasks'),
        content: const Text(
          'Are you sure you want to delete ALL tasks? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<TaskProvider>().deleteAllTasks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All tasks deleted')),
        );
      }
    }
  }
}