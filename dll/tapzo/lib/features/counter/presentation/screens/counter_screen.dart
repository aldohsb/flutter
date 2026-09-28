import 'package:flutter/material.dart'; // import widget dasar Flutter untuk Scaffold, dialog, dll
import 'package:flutter/services.dart'; // import untuk mengakses HapticFeedback

import '../../../../core/theme/app_colors.dart'; // import warna kustom aplikasi
import '../../../../core/constants/app_strings.dart'; // import kumpulan string aplikasi
import '../widgets/counter_app_bar.dart'; // import AppBar kustom
import '../widgets/counter_display.dart'; // import widget tampilan angka
import '../widgets/counter_button.dart'; // import widget tombol tap utama

// Halaman utama Tapzo, StatefulWidget karena nilai counter berubah seiring interaksi user
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key}); // constructor tanpa parameter tambahan

  @override
  State<CounterScreen> createState() => _CounterScreenState(); // State pengelola logika counter
}

class _CounterScreenState extends State<CounterScreen> {
  // Variabel utama penyimpan nilai counter, disimpan sebagai state lokal di memory
  int _count = 0;

  // Getter untuk mengecek apakah counter saat ini kelipatan 10 dan bukan nol (kondisi milestone)
  bool get _isMilestone => _count != 0 && _count % 10 == 0;

  // Fungsi menambah counter, dipanggil setiap kali tombol besar di-tap
  void _increment() {
    setState(() => _count++); // setState memberitahu Flutter untuk rebuild widget dengan nilai baru
    HapticFeedback.lightImpact(); // getaran ringan tiap tap, memberi sensasi fisik interaksi
    if (_isMilestone) {
      HapticFeedback.mediumImpact(); // getaran lebih kuat khusus saat mencapai kelipatan 10
    }
  }

  // Fungsi menampilkan dialog konfirmasi sebelum counter benar-benar direset ke nol
  Future<void> _confirmReset() async {
    // Tampilkan dialog dan tunggu hasil pilihan user (true = konfirmasi, false/null = batal)
    final bool? confirmed = await showDialog<bool>(
      context: context, // context dipakai untuk menampilkan dialog di atas layar aktif
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // sudut dialog membulat, konsisten desain
        ),
        title: const Text(AppStrings.resetTitle), // judul dialog dari konstanta string
        content: const Text(AppStrings.resetMessage), // isi pesan dialog dari konstanta string
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false), // tutup dialog, batalkan reset
            child: const Text(AppStrings.cancelLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true), // tutup dialog, konfirmasi reset
            child: const Text(AppStrings.resetLabel),
          ),
        ],
      ),
    );

    // Hanya reset counter jika user benar-benar menekan tombol konfirmasi
    if (confirmed == true) {
      setState(() => _count = 0); // kembalikan nilai counter ke nol
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil skema warna aktif dari tema untuk background dan komponen lain
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true, // gradient background terlihat sampai belakang AppBar transparan
      appBar: CounterAppBar(isMilestone: _isMilestone), // AppBar kustom, kirim status milestone
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // gradient lembut sebagai latar seluruh layar, kesan modern dan tidak flat
            colors: [
              colorScheme.surface, // warna atas mengikuti surface tema
              AppColors.seed.withValues(alpha: 0.08), // warna bawah sedikit tersentuh warna brand
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // konten diposisikan di tengah layar
            children: [
              Text(
                AppStrings.subtitle, // teks kecil di atas angka, memberi konteks aplikasi
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
              ),
              const SizedBox(height: 12), // jarak antara subtitle dan angka counter
              CounterDisplay(count: _count), // tampilkan angka counter dengan animasi odometer
              const SizedBox(height: 48), // jarak antara angka dan tombol tap besar
              CounterButton(onTap: _increment), // tombol tap utama untuk menambah counter
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmReset, // tombol reset memicu dialog konfirmasi, bukan langsung reset
        icon: const Icon(Icons.refresh_rounded), // ikon refresh sebagai penanda fungsi reset
        label: const Text(AppStrings.resetLabel), // label teks tombol reset
        backgroundColor: colorScheme.secondaryContainer, // warna FAB mengikuti tema agar konsisten
        foregroundColor: colorScheme.onSecondaryContainer, // warna kontras dengan background FAB
      ),
    );
  }
}