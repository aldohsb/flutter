import 'package:flutter/material.dart';

// CharacterWidget adalah widget untuk menampilkan karakter game
// Untuk hari pertama, kita pakai simple shape dulu (kotak/lingkaran)
// Nanti akan kita ganti dengan sprite/gambar
class CharacterWidget extends StatelessWidget {
  // final berarti nilai tidak bisa diubah setelah di-set
  // required berarti parameter ini wajib diisi saat membuat widget
  final double size;
  
  // Constructor untuk menerima parameter
  const CharacterWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    // Container adalah widget serbaguna untuk styling
    return Container(
      // Width dan height menentukan ukuran
      width: size,
      height: size,
      
      // Decoration untuk styling visual
      decoration: BoxDecoration(
        // Gradient membuat warna gradasi
        gradient: const LinearGradient(
          // begin dan end menentukan arah gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFF6B9D), // Pink muda (warna Maryam)
            Color(0xFFFF1493), // Pink tua
          ],
        ),
        
        // borderRadius membuat sudut melengkung
        // circular(size/2) membuat bentuk lingkaran sempurna
        borderRadius: BorderRadius.circular(size / 2),
        
        // boxShadow membuat bayangan (depth effect)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Bayangan hitam transparan
            blurRadius: 10, // Seberapa blur bayangan
            offset: const Offset(0, 5), // Posisi bayangan (x, y)
          ),
        ],
      ),
      
      // Child adalah widget di dalam Container
      // Center memposisikan child di tengah
      child: Center(
        child: Icon(
          // Icon user untuk representasi karakter
          // Nanti akan diganti dengan sprite image
          Icons.person,
          size: size * 0.6, // 60% dari ukuran container
          color: Colors.white,
        ),
      ),
    );
  }
}