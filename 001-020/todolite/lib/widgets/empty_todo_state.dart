import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Tampilan saat daftar tugas masih kosong.
class EmptyTodoState extends StatelessWidget {
  const EmptyTodoState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.edit_note, size: 56, color: AppColors.doneGrey),
          const SizedBox(height: 8),
          Text(
            'Belum ada tugas.\nTulis satu di atas!',
            textAlign: TextAlign.center,
            style: GoogleFonts.caveat(fontSize: 22, color: AppColors.inkSoft),
          ),
        ],
      ),
    );
  }
}