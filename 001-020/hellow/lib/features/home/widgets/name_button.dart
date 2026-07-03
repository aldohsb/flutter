// lib/features/home/widgets/name_button.dart  [UPDATED — Part 3]
// ─────────────────────────────────────────────────────────
// KONSEP BARU: GestureDetector + AnimatedScale
//
// Perubahan dari Part 1:
//   → Tombol dibungkus AnimatedScale untuk efek "press" yang terasa
//   → Belajar menggunakan GestureDetector untuk event kustom
//   → Upgrade dari StatelessWidget ke StatefulWidget (perlu state isPressed)
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';

class NameButton extends StatefulWidget {
  // Perlu StatefulWidget karena harus menyimpan state _isPressed
  const NameButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<NameButton> createState() => _NameButtonState();
}

class _NameButtonState extends State<NameButton> {
  bool _isPressed = false;
  // State sederhana: apakah tombol sedang ditekan atau tidak

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector: mendeteksi berbagai gesture (tap, swipe, long press, dll)
      // Dipakai di sini untuk mendapat event "mulai tekan" dan "lepas tekan"
      // yang tidak tersedia di onPressed ElevatedButton

      onTapDown: (_) => setState(() => _isPressed = true),
      // onTapDown: dipanggil saat jari/kursor mulai menekan
      // _ : parameter TapDownDetails tidak kita butuhkan

      onTapUp: (_) {
        setState(() => _isPressed = false);
        // onTapUp: dipanggil saat jari/kursor diangkat
        widget.onPressed();
        // Baru panggil callback setelah animasi release dimulai
      },

      onTapCancel: () => setState(() => _isPressed = false),
      // onTapCancel: dipanggil jika gesture dibatalkan
      // (misalnya jari geser keluar tombol sebelum diangkat)
      // Pastikan tombol kembali ke ukuran normal walau tidak jadi diklik

      child: AnimatedScale(
        // AnimatedScale: implicit animation yang menganimasikan perubahan scale
        // Tidak butuh AnimationController — cukup ubah nilai scale dan Flutter
        // otomatis menganimasikan perubahan tersebut
        scale: _isPressed ? 0.94 : 1.0,
        // Saat ditekan: mengecil ke 94% ukuran asli
        // Saat dilepas: kembali ke 100% ukuran asli
        duration: const Duration(milliseconds: 100),
        // Durasi singkat agar feedback terasa responsif
        curve: Curves.easeInOut,
        child: ElevatedButton.icon(
          onPressed: null,
          // onPressed: null karena kita sudah handle gesture di GestureDetector
          // null membuat button tidak punya ripple effect bawaan Flutter
          // Ini disengaja agar efek custom AnimatedScale terasa lebih bersih
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            foregroundColor: AppColors.textOnDark,
            disabledBackgroundColor: AppColors.teal,
            // disabledBackgroundColor: warna tetap teal walau onPressed null
            disabledForegroundColor: AppColors.textOnDark,
            // disabledForegroundColor: warna teks tetap putih
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
          ),
          icon: const Icon(Icons.edit_rounded, size: 18),
          label: const Text(
            'Change Name',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}