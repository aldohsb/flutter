import 'package:flutter/material.dart'; // import widget dasar Material untuk gesture dan animasi

// Widget tombol tap utama Tapzo, berbentuk lingkaran besar dengan animasi scale saat ditekan
class CounterButton extends StatefulWidget {
  // Callback yang dipanggil setiap kali tombol selesai di-tap, dikirim dari CounterScreen
  final VoidCallback onTap;

  // Constructor menerima onTap sebagai parameter wajib
  const CounterButton({super.key, required this.onTap});

  @override
  State<CounterButton> createState() => _CounterButtonState(); // State terpisah untuk animasi lokal
}

class _CounterButtonState extends State<CounterButton> {
  // Variabel lokal penanda apakah tombol sedang ditekan, dipakai untuk memicu animasi scale
  bool _isPressed = false;

  // Dipanggil saat jari mulai menyentuh tombol
  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true); // set state ditekan, memicu animasi mengecil
  }

  // Dipanggil saat jari dilepas dari tombol
  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false); // kembalikan ke state normal, animasi membesar lagi
  }

  // Dipanggil saat gesture tap dibatalkan (misalnya jari digeser keluar area tombol)
  void _handleTapCancel() {
    setState(() => _isPressed = false); // pastikan tombol tetap kembali normal
  }

  @override
  Widget build(BuildContext context) {
    // Ambil skema warna aktif dari tema untuk gradient dan shadow tombol
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      // Pasang seluruh handler gesture agar tombol terasa responsif terhadap sentuhan
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap, // saat tap selesai, panggil callback dari parent untuk menambah counter
      child: AnimatedScale(
        // AnimatedScale meng-animasikan perubahan ukuran otomatis tanpa AnimationController manual
        scale: _isPressed ? 0.92 : 1.0, // mengecil sedikit saat ditekan, efek "tactile feedback"
        duration: const Duration(milliseconds: 120), // durasi animasi singkat agar terasa responsif
        curve: Curves.easeOut, // kurva animasi agar transisi terasa halus, bukan patah-patah
        child: Container(
          width: 180, // lebar tombol lingkaran besar, jadi fokus interaksi utama layar
          height: 180, // tinggi sama dengan lebar agar membentuk lingkaran sempurna
          decoration: BoxDecoration(
            shape: BoxShape.circle, // bentuk lingkaran penuh, khas desain "big tap button"
            gradient: LinearGradient(
              // gradient dari primary ke tertiary agar tombol terlihat premium, tidak flat
              colors: [colorScheme.primary, colorScheme.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                // withValues(alpha:) dipakai karena withOpacity() sudah deprecated
                color: colorScheme.primary.withValues(alpha: 0.35),
                blurRadius: 24, // blur besar agar shadow terasa lembut dan melayang
                offset: const Offset(0, 12), // offset ke bawah agar tombol terkesan "mengambang"
              ),
            ],
          ),
          child: Icon(
            Icons.touch_app_rounded, // ikon jari menyentuh sebagai penanda area interaksi
            color: colorScheme.onPrimary, // warna ikon kontras dengan gradient tombol
            size: 56, // ukuran ikon proporsional terhadap besar tombol
          ),
        ),
      ),
    );
  }
}