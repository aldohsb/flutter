// lib/widgets/task_tile.dart
// Satu baris tugas: checkbox animatif, teks coret animatif, dan swipe-to-delete

import 'package:flutter/material.dart'; // Dismissible, Card, InkWell, dsb
import '../models/task.dart'; // tipe data Task
import '../theme/app_colors.dart'; // warna danger, seed, neutral
import '../constants/app_constants.dart'; // radius dan durasi animasi

class TaskTile extends StatelessWidget {
  // Data tugas yang direpresentasikan tile ini
  final Task task;

  // Dipanggil saat tile ditekan, untuk toggle status selesai/belum
  final VoidCallback onToggle;

  // Dipanggil setelah animasi swipe selesai, memberi tahu parent untuk hapus data
  final VoidCallback onDismissed;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Key unik wajib ada agar Flutter tahu widget mana yang sedang di-swipe
      key: ValueKey(task.id),

      // Hanya izinkan swipe dari kanan ke kiri, konsisten dengan gestur "hapus"
      direction: DismissDirection.endToStart,

      // Dipanggil setelah animasi swipe tuntas, bukan saat masih di-drag
      onDismissed: (_) => onDismissed(),

      // Background merah dengan ikon sampah, muncul mengikuti jarak swipe
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),

      // Konten utama tile, dibungkus Card agar tampil sebagai kartu terpisah
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Card(
          child: InkWell(
            // InkWell memberi efek ripple saat tile ditekan untuk toggle
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            onTap: onToggle,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // AnimatedContainer membuat checkbox berubah warna secara halus
                  AnimatedContainer(
                    duration: AppConstants.animationFast,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isDone ? AppColors.seed : Colors.transparent,
                      border: Border.all(
                        color: task.isDone ? AppColors.seed : AppColors.neutral,
                        width: 2,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      // AnimatedSwitcher membuat ikon centang fade-in/fade-out
                      duration: AppConstants.animationFast,
                      child: task.isDone
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                              key: ValueKey('checked'), // key wajib agar transisi terdeteksi
                            )
                          : const SizedBox.shrink(key: ValueKey('unchecked')),
                    ),
                  ),
                  const SizedBox(width: 14), // jarak antara checkbox dan teks judul
                  Expanded(
                    // Expanded agar teks judul mengisi sisa ruang horizontal
                    child: AnimatedDefaultTextStyle(
                      // Efek coret animatif saat status tugas berubah jadi selesai
                      duration: AppConstants.animationFast,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.isDone
                                ? AppColors.neutral
                                : const Color(0xFF1B1B2F),
                          ),
                      child: Text(task.title),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}