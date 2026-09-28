import 'package:flutter/material.dart'; // import widget dasar Flutter untuk teks dan animasi

// Widget untuk menampilkan angka counter dengan animasi transisi setiap kali nilainya berubah
class CounterDisplay extends StatelessWidget {
  // Nilai counter yang akan ditampilkan, dikirim dari CounterScreen
  final int count;

  // Constructor menerima count sebagai parameter wajib
  const CounterDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    // Ambil textTheme dan colorScheme dari tema aktif untuk styling angka
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      // AnimatedSwitcher otomatis meng-animasikan pergantian child berdasarkan Key yang berbeda
      duration: const Duration(milliseconds: 260), // durasi transisi angka, cepat agar tidak terasa lag
      transitionBuilder: (child, animation) {
        // Definisikan animasi geser vertikal dari bawah ke posisi normal (efek "odometer")
        final Animation<Offset> offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.4), // angka baru mulai muncul sedikit dari bawah
          end: Offset.zero, // berhenti tepat di posisi normal
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation, // terapkan animasi geser vertikal
          child: FadeTransition(opacity: animation, child: child), // gabungkan dengan efek fade in/out
        );
      },
      child: Text(
        '$count', // konversi nilai integer count menjadi String untuk ditampilkan
        key: ValueKey<int>(count), // Key unik berbasis nilai count, jadi pemicu AnimatedSwitcher
        style: textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w800, // angka dibuat sangat tebal karena jadi fokus utama layar
          color: colorScheme.onSurface, // warna teks otomatis kontras dengan background tema
          fontSize: 96, // ukuran font besar karena angka adalah konten utama aplikasi
        ),
      ),
    );
  }
}