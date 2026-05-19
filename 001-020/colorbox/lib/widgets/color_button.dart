import 'package:flutter/material.dart'; // import widget Material Design

class ColorButton extends StatelessWidget {
  // StatelessWidget — tombol tidak punya state sendiri
  final VoidCallback onPressed; // fungsi yang dipanggil saat tombol ditekan
  final String label; // teks yang ditampilkan di dalam tombol
  final bool isSecondary;

  const ColorButton({
    // const constructor — bisa di-cache Flutter
    super.key,
    required this.onPressed, // wajib diisi dari luar
    required this.label, // wajib diisi dari luar
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // tombol Material Design bawaan Flutter
      onPressed: onPressed, // teruskan callback ke ElevatedButton
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.grey.shade200 : null,
  foregroundColor: isSecondary ? Colors.grey.shade700 : null,
        // kustomisasi tampilan tombol
        padding: const EdgeInsets.symmetric(
          // ukuran area dalam tombol
          horizontal: 32, // lebih lebar dari default
          vertical: 14, // lebih tinggi dari default
        ),
        shape: RoundedRectangleBorder(
          // bentuk tombol
          borderRadius: BorderRadius.circular(12), // sudut melengkung
        ),
      ),
      child: Text(
        // teks di dalam tombol
        label, // teks dari parameter — fleksibel, bisa diganti
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600, // sedikit tebal
          letterSpacing: 0.5, // spasi huruf sedikit
        ),
      ),
    );
  }
}
