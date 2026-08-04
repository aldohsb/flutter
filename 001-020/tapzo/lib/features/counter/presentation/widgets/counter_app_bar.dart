import 'package:flutter/material.dart'; // import widget dasar untuk AppBar dan styling

// Custom AppBar Tapzo: menampilkan judul aplikasi + indikator titik status milestone
class CounterAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Status apakah counter saat ini berada di kelipatan 10 (dikirim dari CounterScreen)
  final bool isMilestone;

  // Constructor menerima status milestone sebagai parameter wajib
  const CounterAppBar({super.key, required this.isMilestone});

  @override
  Widget build(BuildContext context) {
    // Ambil skema warna aktif dari tema, agar AppBar konsisten dengan seluruh aplikasi
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: Colors.transparent, // transparan agar menyatu dengan gradient background layar
      elevation: 0, // hilangkan bayangan default AppBar untuk kesan flat modern
      centerTitle: true, // judul diposisikan di tengah, gaya minimalis
      title: Row(
        mainAxisSize: MainAxisSize.min, // Row hanya selebar kontennya, tidak melebar penuh
        children: [
          // Teks judul aplikasi
          Text(
            'Tapzo',
            style: TextStyle(
              fontWeight: FontWeight.w700, // judul tebal agar terlihat kuat sebagai brand
              color: colorScheme.onSurface, // warna menyesuaikan tema aktif
              fontSize: 22, // ukuran judul proporsional di AppBar
            ),
          ),
          const SizedBox(width: 8), // jarak kecil antara judul dan indikator titik
          // Titik indikator kecil yang animasinya berubah warna saat milestone tercapai
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // durasi transisi perubahan warna titik
            width: 10, // lebar titik indikator, kecil agar tidak mengganggu judul
            height: 10, // tinggi sama dengan lebar agar berbentuk lingkaran sempurna
            decoration: BoxDecoration(
              shape: BoxShape.circle, // bentuk lingkaran untuk indikator titik
              color: isMilestone
                  ? colorScheme.tertiary // warna menyala saat sedang milestone
                  : colorScheme.outlineVariant, // warna redup saat kondisi normal
            ),
          ),
        ],
      ),
    );
  }

  // Wajib diimplementasikan karena class ini implements PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}