// lib/features/home/screens/home_screen.dart  [FINAL — Part 3]
// ─────────────────────────────────────────────────────────
// Perubahan dari Part 2:
//   → Tambah AnimatedEntrance pada setiap elemen UI
//   → Stagger delay berbeda tiap elemen → masuk berurutan
//   → AnimatedContainer untuk lingkaran dekoratif
//   → Struktur build() makin rapi karena logika animasi
//     sudah dipisah ke widget-widget kecil
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';
import 'package:hellow/features/home/widgets/animated_entrance.dart';
import 'package:hellow/features/home/widgets/change_name_dialog.dart';
import 'package:hellow/features/home/widgets/greeting_text.dart';
import 'package:hellow/features/home/widgets/name_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = 'World';

  // ── Dialog async (sama seperti Part 2) ────────────────
  Future<void> _showChangeNameDialog() async {
    final String? newName = await showChangeNameDialog(
      context: context,
      currentName: _name,
    );
    if (newName == null) return;
    if (!mounted) return;
    setState(() => _name = newName);
    _showSuccessSnackBar(newName);
  }

  void _showSuccessSnackBar(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello, $name! 👋'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.textPrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              // Setiap elemen dibungkus AnimatedEntrance dengan delay bertahap
              // Hasilnya: elemen muncul satu per satu dari atas ke bawah
              // Teknik ini disebut "staggered animation"

              AnimatedEntrance(
                delay: const Duration(milliseconds: 0),
                // Lingkaran muncul pertama, tanpa delay
                child: _buildDecorationCircle(),
              ),

              const SizedBox(height: 40),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 150),
                // Teks "HELLO + nama" muncul 150ms setelah lingkaran
                child: GreetingText(name: _name),
              ),

              const SizedBox(height: 48),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 300),
                // Tombol muncul terakhir, 300ms setelah lingkaran
                child: NameButton(onPressed: _showChangeNameDialog),
              ),

              const Spacer(flex: 3),

              AnimatedEntrance(
                delay: const Duration(milliseconds: 400),
                // Footer muncul paling terakhir dengan delay terpanjang
                child: _buildFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper: lingkaran dekoratif ────────────────────────
  Widget _buildDecorationCircle() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // TweenAnimationBuilder: explicit animation tanpa AnimationController
        // Cocok untuk animasi satu kali yang dipicu oleh perubahan nilai target
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          // Animasi dari skala 0 ke 1 (muncul dari titik)
          duration: const Duration(milliseconds: 700),
          curve: Curves.elasticOut,
          // elasticOut: efek "pegas" — melewati 1.0 lalu balik ke 1.0
          // Memberi kesan "pop" yang playful

          builder: (BuildContext context, double value, Widget? child) {
            // builder dipanggil setiap frame dengan nilai terkini
            // value: angka antara 0.0 dan 1.0 (dari tween di atas)
            // child: widget yang tidak berubah (opsional, untuk optimasi)
            return Transform.scale(
              scale: value,
              // Transform.scale: ubah ukuran widget tanpa mempengaruhi layout
              child: child,
            );
          },
          child: Container(
            // child di TweenAnimationBuilder: di-cache, tidak direbuild tiap frame
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.coralLight,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          top: -10,
          right: -10,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            // Lingkaran kecil juga pakai efek elastic, sedikit lebih cepat
            builder: (_, double value, Widget? child) => Transform.scale(
              scale: value,
              child: child,
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.teal,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Helper: footer ─────────────────────────────────────
  Widget _buildFooter() {
    return Center(
      child: Text(
        'tap the button to change your name',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}