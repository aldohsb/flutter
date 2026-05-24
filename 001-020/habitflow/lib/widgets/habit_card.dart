import 'package:flutter/material.dart';              // diperlukan untuk Card, CheckboxListTile, TextStyle
import 'package:habitflow/models/habit.dart';        // impor model Habit — widget ini menampilkan satu Habit

class HabitCard extends StatelessWidget {            // StatelessWidget — card tidak punya state sendiri, semua dari luar
  final Habit habit;                                 // data habit yang ditampilkan — dioper dari screen
  final VoidCallback onToggle;                       // callback saat checkbox ditekan — screen yang menangani logika toggle

  const HabitCard({                                  // constructor — semua field required
    super.key,
    required this.habit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),      // jarak bawah antar card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),     // sudut membulat konsisten
      ),
      child: CheckboxListTile(
        value: habit.isDone,                         // status centang dari data habit
        onChanged: (_) => onToggle(),                // _ artinya parameter bool? value tidak dipakai — langsung panggil callback
        title: Text(
          habit.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: habit.isDone                 // coret kalau selesai
                ? TextDecoration.lineThrough
                : null,
            color: habit.isDone
                ? Colors.grey.shade400               // abu-abu kalau selesai
                : const Color(0xFF1A1A1A),           // gelap kalau belum
          ),
        ),
        activeColor: Colors.teal,                    // warna centang saat isDone=true
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}