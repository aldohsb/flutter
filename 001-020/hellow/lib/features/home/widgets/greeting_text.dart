// lib/features/home/widgets/greeting_text.dart
// ─────────────────────────────────────────────────────────
// Widget ini hanya menampilkan nama. Kenapa dipisah?
// → Single Responsibility: satu widget, satu tugas
// → Nanti di Part 3 kita tambah animasi di sini saja
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';
import 'package:hellow/core/theme/app_text_styles.dart';
// Import menggunakan package name (bukan relative path '../../../')
// Ini best practice karena tidak bergantung pada posisi file

class GreetingText extends StatelessWidget {
  const GreetingText({super.key, required this.name});
  // super.key: meneruskan key ke parent StatelessWidget
  // required: parameter wajib diisi saat widget dipanggil
  // this.name: shorthand untuk menyimpan nilai ke field name

  final String name;
  // final: nilai tidak berubah setelah widget dibuat (immutable)

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Rata kiri: label dan nama sejajar di sisi kiri
      children: [
        Text(
          'HELLO,',
          style: AppTextStyles.label,
          // Label kecil di atas nama
        ),

        const SizedBox(height: 4),
        // Jarak vertikal 4px antara label dan nama

        Text(
          name,
          style: AppTextStyles.greeting,
          // Nama ditampilkan besar dan bold dengan warna coral
        ),

        const SizedBox(height: 8),

        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.coralLight,
            // Garis dekoratif berwarna coral muda di bawah nama
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Garis underline dekoratif sebagai signature visual
      ],
    );
  }
}