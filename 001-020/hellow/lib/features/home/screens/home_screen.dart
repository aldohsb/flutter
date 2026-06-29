// lib/features/home/screens/home_screen.dart
// ─────────────────────────────────────────────────────────
// Ini adalah INTI pembelajaran Part 1:
//   → StatefulWidget: widget yang bisa menyimpan & mengubah state
//   → setState: cara memberitahu Flutter untuk rebuild UI
//   → TextEditingController: cara membaca input dari TextField
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';
import 'package:hellow/features/home/widgets/greeting_text.dart';
import 'package:hellow/features/home/widgets/name_button.dart';

// ── StatefulWidget terdiri dari DUA class ─────────────────
// 1. HomeScreen       → deklarasi widget (tidak berubah)
// 2. _HomeScreenState → state/data yang bisa berubah

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // createState: menghubungkan widget dengan state-nya
  // Dipanggil sekali saat widget pertama kali dibuat
}

class _HomeScreenState extends State<HomeScreen> {
  // Underscore (_) di depan nama: konvensi untuk class private
  // Private di Dart = hanya bisa diakses dalam file ini

  // ── State variables ────────────────────────────────────
  String _name = 'World';
  // _name: data yang disimpan oleh widget ini
  // Nilai awal 'World' → ditampilkan sebagai "Hello, World!"

  final TextEditingController _controller = TextEditingController();
  // TextEditingController: objek penghubung antara TextField dan kode
  // 'final' karena objek controller-nya tidak diganti, hanya isinya

  // ── Lifecycle: dispose ─────────────────────────────────
  @override
  void dispose() {
    _controller.dispose();
    // WAJIB: bebaskan memori controller saat widget dihapus dari tree
    // Jika tidak, terjadi memory leak
    super.dispose();
    // Selalu panggil super.dispose() di akhir
  }

  // ── Method: tampilkan dialog ganti nama ───────────────
  void _showChangeNameDialog() {
    _controller.text = _name;
    // Pre-fill input dengan nama saat ini agar mudah diedit
    // controller.text = setter untuk mengisi teks ke TextField

    showDialog<void>(
      context: context,
      // context: BuildContext yang dimiliki State, bukan parameter build
      builder: (BuildContext dialogContext) {
        // builder menerima context baru khusus untuk dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            // Dialog dengan sudut sangat rounded
          ),
          title: const Text('What\'s your name?'),
          // Judul dialog

          content: TextField(
            controller: _controller,
            // Hubungkan controller ke TextField ini
            autofocus: true,
            // Keyboard otomatis muncul saat dialog terbuka
            textCapitalization: TextCapitalization.words,
            // Otomatis kapitalisasi huruf pertama setiap kata
            decoration: const InputDecoration(
              hintText: 'Enter your name...',
            ),
            onSubmitted: (_) => _saveName(dialogContext),
            // Tekan Enter/Done di keyboard = sama dengan klik Confirm
            // Parameter _ artinya nilai String tidak kita gunakan
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              // pop(): tutup dialog tanpa menyimpan
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _saveName(dialogContext),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // ── Method: simpan nama baru ───────────────────────────
  void _saveName(BuildContext dialogContext) {
    final String newName = _controller.text.trim();
    // trim(): hapus spasi di awal dan akhir input

    if (newName.isEmpty) return;
    // Guard clause: jangan simpan jika input kosong

    setState(() {
      _name = newName;
      // setState: memberitahu Flutter bahwa state berubah
      // Flutter akan memanggil build() lagi → UI terupdate
      // PENTING: perubahan state HARUS di dalam setState()
    });

    Navigator.of(dialogContext).pop();
    // Tutup dialog setelah menyimpan nama
  }

  // ── Build: UI layout ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    // build() dipanggil setiap kali setState() dipanggil
    // Flutter sangat efisien: hanya widget yang berubah yang dirender ulang

    return Scaffold(
      body: SafeArea(
        // SafeArea: hindari konten tertutup notch/status bar/nav bar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          // Padding konsisten di kiri-kanan dan atas-bawah

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Semua anak rata kiri
            children: [
              const Spacer(flex: 2),
              // Spacer: widget kosong yang mengisi ruang fleksibel
              // flex: 2 → ambil 2 bagian dari total ruang kosong

              // Dekorasi lingkaran coral di belakang teks
              _buildDecorationCircle(),

              const SizedBox(height: 40),

              GreetingText(name: _name),
              // Widget tampilan nama, menerima _name sebagai parameter
              // Saat setState dipanggil, widget ini dirender ulang dengan nama baru

              const SizedBox(height: 48),

              NameButton(onPressed: _showChangeNameDialog),
              // Widget tombol, menerima method _showChangeNameDialog sebagai callback

              const Spacer(flex: 3),
              // Spacer lebih besar di bawah agar konten condong ke atas-tengah

              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper widget: lingkaran dekoratif ─────────────────
  Widget _buildDecorationCircle() {
    return Stack(
      // Stack: menumpuk widget di atas satu sama lain
      clipBehavior: Clip.none,
      // Clip.none: child boleh keluar dari batas Stack
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.coralLight,
            shape: BoxShape.circle,
            // Bentuk lingkaran penuh
          ),
        ),
        // Lingkaran besar

        Positioned(
          top: -10,
          right: -10,
          // Posisi relatif terhadap parent Stack
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Lingkaran kecil teal sebagai aksen, keluar sedikit dari area
      ],
    );
  }

  // ── Helper widget: footer ─────────────────────────────
  Widget _buildFooter() {
    return Center(
      child: Text(
        'tap the button to change your name',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          letterSpacing: 0.3,
        ),
        // Theme.of(context): akses ThemeData yang sudah kita set di AppTheme
        // copyWith: salin style yang ada, tapi override beberapa properti
        // ?. (null-safe operator): jika bodySmall null, ekspresi ini null juga
      ),
    );
  }
}