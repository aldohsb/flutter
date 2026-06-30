// lib/features/home/screens/home_screen.dart  [UPDATED — Part 2]
// ─────────────────────────────────────────────────────────
// Perubahan dari Part 1:
//   → Dialog dipindah ke change_name_dialog.dart
//   → _showChangeNameDialog kini async (menunggu hasil dialog)
//   → Tambah SnackBar sebagai feedback setelah nama berubah
//   → Hapus TextEditingController dari sini (sudah di dialog)
//   → home_screen.dart jadi lebih pendek dan fokus
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';
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
  // Tidak ada lagi TextEditingController di sini
  // Controller sekarang hidup di dalam ChangeNameDialog

  // ── Method: tampilkan dialog (sekarang async) ──────────
  Future<void> _showChangeNameDialog() async {
    // async: method ini bisa menggunakan await
    // Future<void>: method ini mengembalikan Future tapi tidak ada nilai

    final String? newName = await showChangeNameDialog(
      // await: tunggu sampai dialog ditutup dan dapat nilai return
      // Eksekusi baris berikutnya baru berjalan setelah dialog tertutup
      context: context,
      currentName: _name,
    );
    // newName adalah hasil dari Navigator.pop(newName) di dalam dialog
    // Jika user cancel → newName = null

    if (newName == null) return;
    // Guard clause: user menekan Cancel, tidak ada yang perlu dilakukan

    if (!mounted) return;
    // mounted: cek apakah widget masih terpasang di widget tree
    // PENTING: setelah await, widget bisa saja sudah di-dispose
    // Mengakses setState/context pada widget yang sudah di-dispose = crash

    setState(() => _name = newName);
    // Arrow function dalam setState untuk kode satu baris

    _showSuccessSnackBar(newName);
    // Tampilkan feedback setelah nama berubah
  }

  // ── Method: tampilkan SnackBar ─────────────────────────
  void _showSuccessSnackBar(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      // ScaffoldMessenger: cara yang benar untuk menampilkan SnackBar
      // Lebih stabil dari Scaffold.of(context).showSnackBar (deprecated)
      SnackBar(
        content: Text('Hello, $name! 👋'),
        behavior: SnackBarBehavior.floating,
        // floating: SnackBar mengambang di atas konten, tidak menempel di bawah
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.textPrimary,
        duration: const Duration(seconds: 2),
        // SnackBar otomatis hilang setelah 2 detik
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
              _buildDecorationCircle(),
              const SizedBox(height: 40),
              GreetingText(name: _name),
              const SizedBox(height: 48),
              NameButton(onPressed: _showChangeNameDialog),
              const Spacer(flex: 3),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorationCircle() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.coralLight,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

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