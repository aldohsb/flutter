import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../theme/app_colors.dart';

/// Satu baris tugas: checkbox, judul, dan swipe untuk hapus.
class TodoItemTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const TodoItemTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: _dismissBackground(),
      child: ListTile(
        onTap: onToggle,
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) => onToggle(),
          activeColor: AppColors.accentGreen,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 17,
            color: todo.isDone ? AppColors.doneGrey : AppColors.ink,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }

  Widget _dismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      color: AppColors.accentRed,
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }
}