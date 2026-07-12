import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Input teks untuk menambah tugas baru.
class TodoInputField extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const TodoInputField({super.key, required this.onSubmit});

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  final _controller = TextEditingController();

  void _submit() {
    widget.onSubmit(_controller.text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: 'Tulis tugas baru...',
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.paperLine),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _submit,
            style: IconButton.styleFrom(backgroundColor: AppColors.accentRed),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}