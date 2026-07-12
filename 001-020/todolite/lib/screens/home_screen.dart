import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../widgets/todo_app_bar.dart';
import '../widgets/todo_input_field.dart';
import '../widgets/todo_progress_bar.dart';
import '../widgets/todo_list_view.dart';
import '../widgets/empty_todo_state.dart';
import '../painters/lined_paper_painter.dart';

/// Layar utama TodoLite, menyimpan seluruh state daftar tugas.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [];

  void _addTodo(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _todos.add(Todo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.trim(),
      ));
    });
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.isDone = !todo.isDone;
    });
  }

  void _removeTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  int get _doneCount => _todos.where((t) => t.isDone).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TodoAppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: LinedPaperPainter()),
          ),
          SafeArea(
            child: Column(
              children: [
                TodoInputField(onSubmit: _addTodo),
                TodoProgressBar(done: _doneCount, total: _todos.length),
                Expanded(
                  child: _todos.isEmpty
                      ? const EmptyTodoState()
                      : TodoListView(
                          todos: _todos,
                          onToggle: _toggleTodo,
                          onRemove: _removeTodo,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}