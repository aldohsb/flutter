// ============================================================
// widgets/die_face.dart
// Menampilkan satu wajah dadu sebagai StatelessWidget.
// Menerima nilai dari luar — tidak tahu cara melempar dadu.
// ============================================================

import 'package:flutter/material.dart';

// Pemetaan nilai dadu ke IconData.
// Ditaruh di file widget karena IconData butuh package Flutter.
const Map<int, IconData> _dieIcons = {
  1: Icons.looks_one_rounded,
  2: Icons.looks_two_rounded,
  3: Icons.looks_3_rounded,
  4: Icons.looks_4_rounded,
  5: Icons.looks_5_rounded,
  6: Icons.looks_6_rounded,
};

// Warna berbeda tiap sisi dadu — memberikan identitas visual setiap angka.
const Map<int, Color> _dieFaceColors = {
  1: Color(0xFFE53935), // merah  — angka 1 paling menonjol
  2: Color(0xFFE91E63), // pink
  3: Color(0xFF8E24AA), // ungu
  4: Color(0xFF1E88E5), // biru
  5: Color(0xFF00ACC1), // cyan
  6: Color(0xFF43A047), // hijau  — angka 6 paling menguntungkan
};

class DieFace extends StatelessWidget {
  // Nilai dadu yang ditampilkan, 1–6.
  final int value;

  // Ukuran kotak dadu — opsional, default 130px.
  final double size;

  const DieFace({
    super.key,
    required this.value,
    this.size = 130,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil ikon dan warna dari Map.
    // Gunakan fallback (!) dengan yakin karena value selalu 1–6 dari model.
    final IconData icon  = _dieIcons[value]!;
    final Color faceColor = _dieFaceColors[value]!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: faceColor,
        borderRadius: BorderRadius.circular(size * 0.22),

        // Shadow berwarna sesuai wajah — efek glow yang hidup.
        boxShadow: [
          BoxShadow(
            color: faceColor.withOpacity(0.45),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      // Ikon angka dadu di tengah kotak.
      child: Icon(
        icon,
        size: size * 0.58,         // ikon ~58% dari ukuran kotak
        color: Colors.white,
      ),
    );
  }
}