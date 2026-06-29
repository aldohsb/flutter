// lib/features/home/widgets/name_button.dart
// ─────────────────────────────────────────────────────────
// Widget tombol dengan ikon dan teks.
// Dipisah agar home_screen.dart tetap bersih dan pendek.
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class NameButton extends StatelessWidget {
  const NameButton({super.key, required this.onPressed});
  // onPressed: callback function — dikerjakan oleh parent
  // Pola ini memisahkan "apa yang terjadi" dari "tampilannya"

  final VoidCallback onPressed;
  // VoidCallback = typedef untuk: void Function()
  // Fungsi tanpa parameter dan tanpa return value

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      // Meneruskan callback ke tombol

      icon: const Icon(Icons.edit_rounded, size: 18),
      // Ikon pensil di sebelah kiri teks

      label: const Text('Change Name'),
      // Teks tombol
      // Style otomatis mengikuti elevatedButtonTheme dari AppTheme
    );
  }
}