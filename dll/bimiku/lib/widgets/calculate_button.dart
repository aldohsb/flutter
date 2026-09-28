import 'package:flutter/material.dart'; // ElevatedButton dan widget dasar

// tombol utama untuk memicu perhitungan BMI, logikanya baru diisi penuh di Part 2
class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key, required this.onPressed}); // menerima callback dari parent

  final VoidCallback onPressed; // fungsi yang dijalankan saat tombol ditekan

  @override
  Widget build(BuildContext context) {
    return SizedBox( // membatasi ukuran tombol agar full width
      width: double.infinity,
      height: 56, // tinggi tombol yang nyaman disentuh
      child: ElevatedButton.icon( // tombol dengan ikon dan teks
        onPressed: onPressed, // memicu callback saat ditekan
        icon: const Icon(Icons.calculate_outlined), // ikon kalkulator
        label: const Text('Hitung BMI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), // teks tombol
        style: ElevatedButton.styleFrom( // gaya visual tombol
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // sudut membulat senada elemen lain
        ),
      ),
    );
  }
}