// lib/utils/task_summary.dart
// Fungsi murni (pure function) untuk mengubah daftar Task menjadi ringkasan progres

import '../models/task.dart'; // membutuhkan definisi class Task

// Objek hasil perhitungan; dipisah agar HomeScreen tidak menghitung ulang manual
class TaskSummary {
  final int total; // jumlah seluruh tugas
  final int done; // jumlah tugas yang sudah selesai
  final double progress; // rasio selesai, nilainya selalu 0.0 - 1.0

  const TaskSummary({
    required this.total,
    required this.done,
    required this.progress,
  });
}

// Fungsi top-level, dipanggil setiap kali daftar tugas berubah
TaskSummary calculateTaskSummary(List<Task> tasks) {
  // Jika daftar kosong, langsung kembalikan nol agar tidak terjadi pembagian 0/0
  if (tasks.isEmpty) {
    return const TaskSummary(total: 0, done: 0, progress: 0);
  }

  // Menghitung jumlah tugas dengan isDone == true
  final doneCount = tasks.where((task) => task.isDone).length;

  // Progres = jumlah selesai dibagi total tugas, hasilnya pecahan 0.0 - 1.0
  final progressValue = doneCount / tasks.length;

  // Mengembalikan satu objek TaskSummary berisi total, done, dan progress
  return TaskSummary(
    total: tasks.length,
    done: doneCount,
    progress: progressValue,
  );
}