// lib/screens/home_screen.dart
// Layar utama: memegang state daftar tugas dan menyusun semua widget lainnya

import 'package:flutter/material.dart'; // Scaffold, ListView, SnackBar, dsb
import '../models/task.dart'; // tipe data Task
import '../utils/task_summary.dart'; // fungsi calculateTaskSummary
import '../widgets/progress_ring.dart'; // header lingkaran progres
import '../widgets/task_tile.dart'; // baris tugas dengan swipe-to-delete
import '../widgets/empty_state.dart'; // tampilan saat daftar kosong
import '../widgets/add_task_sheet.dart'; // form tambah tugas
import '../constants/app_constants.dart'; // nama app dan padding standar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sumber data tunggal (single source of truth) untuk seluruh daftar tugas
  final List<Task> _tasks = [];

  // Menambahkan tugas baru ke posisi paling atas daftar
  void _addTask(String title) {
    setState(() {
      _tasks.insert(
        0, // tugas baru selalu tampil paling atas agar mudah terlihat
        Task(
          id: DateTime.now().microsecondsSinceEpoch.toString(), // id unik dari waktu
          title: title,
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  // Mengubah status selesai/belum selesai tugas berdasarkan posisinya di daftar
  void _toggleTask(int index) {
    setState(() {
      // copyWith membuat objek Task baru, menjaga immutability field lain
      _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    });
  }

  // Menghapus tugas dari daftar, sekaligus menawarkan opsi "Urungkan" lewat SnackBar
  void _removeTask(int index) {
    final removedTask = _tasks[index]; // simpan data sebelum dihapus
    final removedIndex = index; // simpan posisi asli untuk keperluan undo

    setState(() {
      _tasks.removeAt(index); // hapus tugas dari daftar state
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${removedTask.title}" dihapus'),
        action: SnackBarAction(
          label: 'Urungkan',
          onPressed: () {
            setState(() {
              // clamp memastikan index tetap valid meski daftar sudah berubah lagi
              _tasks.insert(removedIndex.clamp(0, _tasks.length), removedTask);
            });
          },
        ),
      ),
    );
  }

  // Membuka bottom sheet untuk mengisi judul tugas baru
  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // agar sheet naik mengikuti tinggi keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => AddTaskSheet(onSubmit: _addTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ringkasan progres dihitung ulang setiap kali build dipanggil
    final summary = calculateTaskSummary(_tasks);

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        icon: const Icon(Icons.add),
        label: const Text('Tugas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12), // jarak antara AppBar dan ring progres
            ProgressRing(
              progress: summary.progress,
              done: summary.done,
              total: summary.total,
            ),
            const SizedBox(height: 16), // jarak antara ring dan daftar tugas
            Expanded(
              // Expanded agar daftar mengisi seluruh sisa ruang vertikal layar
              child: _tasks.isEmpty
                  ? const EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingMedium,
                      ),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index]; // ambil data sesuai index
                        return TaskTile(
                          task: task,
                          onToggle: () => _toggleTask(index),
                          onDismissed: () => _removeTask(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}