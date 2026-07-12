import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import 'todo_item_tile.dart';

/// Daftar tugas menggunakan ListView.builder.
class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onRemove;

  const TodoListView({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 24),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItemTile(
          key: ValueKey(todo.id),
          todo: todo,
          onToggle: () => onToggle(todo.id),
          onRemove: () => onRemove(todo.id),
        );
      },
    );
  }
}