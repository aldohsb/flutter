// File: lib/widgets/magazine_background.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Widget custom untuk background bergaya majalah
// StatelessWidget = widget yang tidak punya state yang berubah
class MagazineBackground extends StatelessWidget {
  final String imageUrl; // URL gambar background
  final Widget child; // Widget yang ditaroh di atas background

  // Constructor
  const MagazineBackground({
    Key? key,
    required this.imageUrl,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // Stack = tumpuk widget di atas widget lain
      // Seperti tumpukan kertas: yang paling bawah kelihatan di belakang
      children: [
        // Layer 1: Background image (paling bawah)
        Positioned.fill(
          // Positioned.fill = ambil semua space yang ada (full screen)
          child: CachedNetworkImage(
            // CachedNetworkImage = load gambar dari internet + cache
            imageUrl: imageUrl,
            
            // fit: BoxFit.cover = gambar menutupi seluruh area
            // Kalau gambar kepanjangan/kependekan, akan di-crop otomatis
            fit: BoxFit.cover,
            
            // placeholder = widget yang tampil pas lagi loading
            placeholder: (context, url) => Container(
              color: Colors.grey[900], // Background abu-abu gelap
              child: Center(
                child: CircularProgressIndicator(
                  // Loading indicator (lingkaran berputar)
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            
            // errorWidget = widget yang tampil kalau gambar gagal load
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[900],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image,
                      color: Colors.white.withOpacity(0.5),
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Image failed to load',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Layer 2: Gradient overlay (lapisan tengah)
        // Gradient = warna gradasi (dari gelap ke transparan)
        // Fungsinya: biar teks di atas gambar tetap terbaca
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // LinearGradient = gradasi garis lurus
                begin: Alignment.topCenter,    // Mulai dari atas
                end: Alignment.bottomCenter,   // Sampai bawah
                colors: [
                  // List warna gradasi
                  Colors.black.withOpacity(0.6),  // Atas: hitam 60%
                  Colors.black.withOpacity(0.3),  // Tengah: hitam 30%
                  Colors.black.withOpacity(0.7),  // Bawah: hitam 70%
                ],
                stops: [0.0, 0.5, 1.0], // Posisi setiap warna (0-1)
                // 0.0 = paling atas, 0.5 = tengah, 1.0 = paling bawah
              ),
            ),
          ),
        ),

        // Layer 3: Vignette effect (efek gelap di pinggir)
        // Seperti efek foto lama - pinggir lebih gelap
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                // RadialGradient = gradasi melingkar dari tengah
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Colors.transparent,            // Tengah: transparan
                  Colors.black.withOpacity(0.4), // Pinggir: hitam 40%
                ],
                stops: [0.5, 1.0],
              ),
            ),
          ),
        ),

        // Layer 4: Content (paling atas)
        // Widget yang dikirim lewat parameter 'child'
        child,
      ],
    );
  }
}

// Widget untuk noise texture effect (opsional, bikin background lebih "magazine-like")
class NoiseTexture extends StatelessWidget {
  const NoiseTexture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        // Opacity = transparansi (0.0 = invisible, 1.0 = solid)
        opacity: 0.03, // Sangat transparan, cuma subtle effect
        child: Container(
          decoration: BoxDecoration(
            // Bisa tambahin noise pattern image kalau ada
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}