import 'package:flutter/material.dart';          // impor Material — diperlukan untuk ElevatedButton dan Color

class TimerButton extends StatelessWidget {      // StatelessWidget — tombol tidak punya state sendiri, semua dari luar
  final String label;                            // teks yang ditampilkan di tombol — wajib diisi saat pakai widget ini
  final Color color;                             // warna latar tombol — dioper dari luar agar fleksibel
  final VoidCallback onPressed;                  // fungsi yang dipanggil saat ditekan — VoidCallback = fungsi tanpa parameter dan return

  const TimerButton({                            // constructor dengan named parameters — semua required agar tidak lupa diisi
    super.key,
    required this.label,                         // required: harus diisi, tidak bisa null
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(                       // tombol dengan efek bayangan bawaan Material
      onPressed: onPressed,                      // teruskan callback ke tombol — widget ini hanya jembatan
      style: ElevatedButton.styleFrom(
        backgroundColor: color,                  // warna dari parameter — beda tombol beda warna
        foregroundColor: Colors.white,           // teks dan ikon selalu putih agar kontras
        padding: const EdgeInsets.symmetric(
          horizontal: 28,                        // padding horizontal cukup lebar agar tombol mudah ditekan
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // sudut membulat — konsisten di semua tombol
        ),
      ),
      child: Text(
        label,                                   // teks dari parameter
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,           // tebal agar label terbaca jelas
        ),
      ),
    );
  }
}