// lib/widgets/empty_state.dart
// Tampilan sederhana saat daftar tugas masih kosong, mengganti layar putih polos

import 'package:flutter/material.dart'; // Icon, Text, Column
import '../theme/app_colors.dart'; // warna neutral untuk teks sekunder

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center memastikan seluruh konten berada tepat di tengah area kosong
      child: Column(
        mainAxisSize: MainAxisSize.min, // kolom hanya setinggi isinya, bukan full
        children: [
          Icon(
            Icons.spa_outlined, // ikon outline bergaya tenang, bukan ikon "kosong" klise
            size: 64,
            color: AppColors.neutral.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 12), // jarak vertikal antara ikon dan judul
          Text(
            'Belum ada tugas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.neutral,
                ),
          ),
          const SizedBox(height: 4), // jarak kecil antara judul dan subjudul
          Text(
            'Ketuk tombol + untuk mulai menambahkan',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral,
                ),
          ),
        ],
      ),
    );
  }
}