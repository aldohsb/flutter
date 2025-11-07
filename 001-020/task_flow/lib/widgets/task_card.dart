// Widget untuk menampilkan card task individual
// Card = kotak yang menampilkan satu task lengkap dengan semua detailnya

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart';
import 'priority_indicator.dart';
import 'category_chip.dart';

class TaskCard extends StatelessWidget {
  final Task task;              // Data task yang akan ditampilkan
  final VoidCallback onEdit;    // Callback saat tombol edit diklik
  final VoidCallback onDelete;  // Callback saat tombol delete diklik

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil TaskProvider untuk akses method toggle completion
    // context.read = ambil provider tanpa rebuild saat ada perubahan
    final taskProvider = context.read<TaskProvider>();

    // Ambil warna kategori
    final categoryColor = AppConstants.categoryColors[task.category] ?? Colors.grey;

    // Cek apakah task overdue
    final isOverdue = !task.isCompleted && DateHelper.isOverdue(task.deadline);

    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Jarak antar card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        // BoxShadow = bayangan untuk efek depth/kedalaman
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Bayangan hitam transparan
            blurRadius: 10,      // Seberapa blur bayangan
            offset: const Offset(0, 2), // Posisi bayangan (x, y)
          ),
        ],
        // Border kiri berwarna sesuai kategori (accent)
        border: Border(
          left: BorderSide(
            color: categoryColor,
            width: 4,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // InkWell = seperti GestureDetector tapi dengan ripple effect
          onTap: onEdit, // Tap pada card = edit task
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align kiri
              children: [
                // Row pertama: Checkbox, Title, dan Action buttons
                Row(
                  children: [
                    // Checkbox untuk mark as completed
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        // Toggle completion status
                        taskProvider.toggleTaskCompletion(task.id);
                      },
                      activeColor: categoryColor, // Warna saat checked
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Title task (expanded agar ambil sisa space)
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // Text decoration strikethrough jika completed
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          // Warna text pudar jika completed
                          color: task.isCompleted
                              ? Colors.grey
                              : Colors.black87,
                        ),
                        maxLines: 2,              // Maksimal 2 baris
                        overflow: TextOverflow.ellipsis, // ... jika terlalu panjang
                      ),
                    ),
                    // Action buttons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit button
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          onPressed: onEdit,
                          color: Colors.blue,
                          tooltip: 'Edit task', // Tooltip saat hover
                        ),
                        // Delete button
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: onDelete,
                          color: Colors.red,
                          tooltip: 'Delete task',
                        ),
                      ],
                    ),
                  ],
                ),
                
                // Description (jika ada)
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 48), // Align dengan title
                    child: Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4, // Line height
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // Row terakhir: Category chip, Priority, dan Deadline
                Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Wrap(
                    spacing: 8,           // Jarak horizontal antar item
                    runSpacing: 8,        // Jarak vertical jika wrap ke baris baru
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Category chip (mini version)
                      CategoryChip(
                        category: task.category,
                        isSelected: true,
                      ),
                      // Priority indicator
                      PriorityIndicator(
                        priority: task.priority,
                        showLabel: true,
                      ),
                      // Deadline info
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          // Warna background merah jika overdue
                          color: isOverdue
                              ? Colors.red.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14,
                              color: isOverdue ? Colors.red : Colors.grey[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateHelper.getDateDescription(task.deadline),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isOverdue ? Colors.red : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}