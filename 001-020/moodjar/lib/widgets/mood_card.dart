import 'package:flutter/material.dart';          // import widget Flutter
import '../models/mood_entry.dart';               // import model — path relatif naik satu level (..)

class MoodCard extends StatelessWidget {          // StatelessWidget — semua data datang dari luar lewat constructor
  final Mood? selectedMood;                       // mood aktif — null = belum dipilih, diterima dari parent

  const MoodCard({
    super.key,
    required this.selectedMood,                   // required — parent wajib mengisi ini
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMood    = selectedMood != null; // cek ada pilihan atau belum
    final MoodData? data  = hasMood               // ambil data mood dari Map global
        ? moodDataMap[selectedMood]
        : null;

    final String emoji    = data?.emoji  ?? '😶';              // ?? = fallback jika data null
    final String label    = data?.label  ?? 'Pilih moodmu';
    final String sub      = hasMood
        ? 'Mood kamu hari ini tercatat ✓'
        : 'Ketuk salah satu emoji di bawah';
    final Color cardColor = data != null
        ? Color(data.colorValue)                               // warna dari model
        : const Color(0xFF6C63FF);                             // default ungu

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),             // durasi transisi ukuran & warna
      curve: Curves.easeOutCubic,                              // kurva melambat di akhir
      width: double.infinity,
      height: hasMood ? 260.0 : 220.0,                        // kartu membesar saat mood dipilih
      decoration: BoxDecoration(
        color: cardColor,                                       // perubahan warna otomatis dianimasikan
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.40),                // bayangan mengikuti warna kartu
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(                       // animasi skala emoji saat berganti
            key: ValueKey(emoji),                              // key berubah → animasi diulang dari awal
            tween: Tween(begin: 0.5, end: 1.0),               // dari 50% → 100% ukuran
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,                          // efek memantul — terasa playful
            builder: (context, value, child) =>
                Transform.scale(scale: value, child: child),   // terapkan nilai skala ke child
            child: Text(emoji, style: const TextStyle(fontSize: 64)),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(                                    // fade antar teks label
            duration: const Duration(milliseconds: 250),
            child: Text(
              label,
              key: ValueKey(label),                           // key berbeda = widget baru = fade
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              sub,
              key: ValueKey(sub),
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}