import 'package:flutter/material.dart'; // import widget Flutter
import '../models/color_item.dart'; // import model ColorItem
import '../widgets/color_button.dart'; // import widget tombol custom

class ColorScreen extends StatefulWidget {
  // dipindah dari main.dart ke sini
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final List<ColorItem> _colors = [
    // diubah: List<ColorItem> gantikan List<Map>
    const ColorItem(color: Color(0xFFE8F4FD), name: 'Biru Muda'), // index 0
    const ColorItem(color: Color(0xFFE8FDF4), name: 'Hijau Muda'), // index 1
    const ColorItem(color: Color(0xFFFDF4E8), name: 'Kuning Muda'), // index 2
    const ColorItem(color: Color(0xFFFDE8F4), name: 'Pink Muda'), // index 3
    const ColorItem(color: Color(0xFFF4E8FD), name: 'Ungu Muda'), // index 4
  ];
  int _colorIndex = 0; // posisi warna aktif di dalam list
  int _tapCount = 0; // hitung berapa kali tombol sudah ditekan

  void _changeColor() {
    // fungsi yang dipanggil saat tombol ditekan
    setState(() {
      // bungkus perubahan agar Flutter rebuild
      _colorIndex =
          (_colorIndex + 1) %
          _colors.length; // maju satu, kembali ke 0 kalau habis
      _tapCount++; // tambah 1 setiap kali ditekan
    });
  }

  void _reset() {
    setState(() {
      _colorIndex = 0;
      _tapCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current =
        _colors[_colorIndex]; // ambil ColorItem aktif — lebih bersih dari akses langsung

    return Scaffold(
      backgroundColor: current
          .color, // akses .color langsung — lebih jelas dari ['color'] as Color
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
        color: current.color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'colorbox',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                current
                    .name, // akses .name langsung — lebih jelas dari ['name'] as String
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _tapCount ==
                        0 // cek apakah belum pernah ditekan
                    ? 'Belum pernah diganti'
                    : 'Diganti $_tapCount kali',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
              const SizedBox(height: 40),
              ColorButton(
                // pakai widget custom — bukan ElevatedButton langsung
                onPressed: _changeColor, // teruskan fungsi ke widget tombol
                label: 'Ganti Warna', // teks tombol
              ),
              const SizedBox(height: 12),
              ColorButton(onPressed: _reset, label: 'Reset', isSecondary: true),
            ],
          ),
        ),
      ),
    );
  }
}
