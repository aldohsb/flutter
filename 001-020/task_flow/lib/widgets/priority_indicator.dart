// Widget untuk menampilkan indikator prioritas task
// Widget = komponen UI yang bisa dipakai berulang kali

import 'package:flutter/material.dart';
import '../utils/constants.dart';

// StatelessWidget = widget yang tidak punya state yang bisa berubah
// Cocok untuk widget yang hanya display data saja
class PriorityIndicator extends StatelessWidget {
  // Property yang harus diisi saat membuat widget ini
  final String priority; // Low, Medium, atau High
  final bool showLabel;  // Apakah tampilkan text label atau tidak

  // Constructor dengan named parameters
  // const = membuat widget immutable, bagus untuk performa
  const PriorityIndicator({
    super.key,           // key untuk identifikasi widget (opsional)
    required this.priority,
    this.showLabel = true, // Default: tampilkan label
  });

  @override
  Widget build(BuildContext context) {
    // Ambil warna sesuai prioritas dari constants
    final color = AppConstants.priorityColors[priority] ?? Colors.grey;
    // ?? Colors.grey = jika priority tidak ditemukan, pakai abu-abu

    // Jika showLabel = true, tampilkan dengan text
    if (showLabel) {
      return Container(
        // Padding = jarak dalam container
        padding: const EdgeInsets.symmetric(
          horizontal: 8,  // Horizontal padding (kiri-kanan)
          vertical: 4,    // Vertical padding (atas-bawah)
        ),
        // Decoration = hiasan untuk container
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Warna background dengan transparansi
          // withOpacity(0.1) = 10% opacity, jadi warna sangat pudar
          borderRadius: BorderRadius.circular(8), // Sudut membulat
          border: Border.all(
            color: color,    // Warna border
            width: 1.5,      // Ketebalan border
          ),
        ),
        // Child = isi dari container
        child: Row(
          mainAxisSize: MainAxisSize.min, // Row hanya sebesar isinya
          children: [
            // Icon prioritas
            Icon(
              Icons.flag,        // Icon bendera
              size: 14,          // Ukuran icon
              color: color,      // Warna icon
            ),
            const SizedBox(width: 4), // Jarak antara icon dan text
            // Text prioritas
            Text(
              priority,
              style: TextStyle(
                fontSize: 12,         // Ukuran font
                fontWeight: FontWeight.w600, // Ketebalan font (semi-bold)
                color: color,         // Warna text
              ),
            ),
          ],
        ),
      );
    } else {
      // Jika showLabel = false, hanya tampilkan icon bulat
      return Container(
        width: 12,   // Lebar container
        height: 12,  // Tinggi container
        decoration: BoxDecoration(
          color: color,                    // Warna solid
          shape: BoxShape.circle,          // Bentuk lingkaran
          border: Border.all(
            color: Colors.white,           // Border putih
            width: 2,                      // Ketebalan border
          ),
        ),
      );
    }
  }
}