import 'package:flutter/material.dart';                            // import widget Flutter

class PreviewBox extends StatelessWidget {                         // StatelessWidget — semua nilai datang dari parent lewat constructor
  final double size;                                               // lebar dan tinggi kotak dalam px
  final double radius;                                             // sudut bulat dalam px
  final double opacity;                                            // opacity 10–100 (akan dibagi 100 sebelum dipakai)
  final double elevation;                                          // ketinggian bayangan

  const PreviewBox({                                               // const constructor — efisien jika nilai tidak berubah
    super.key,
    required this.size,
    required this.radius,
    required this.opacity,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.primary; // ambil warna aksen dari tema app — tidak hardcode

    return Center(                                                 // pusatkan kotak secara horizontal dan vertikal
      child: AnimatedContainer(                                    // AnimatedContainer — semua perubahan properti dianimasikan
        duration: const Duration(milliseconds: 200),               // durasi transisi 200ms — cukup cepat terasa responsif
        curve: Curves.easeOut,                                     // kurva melambat di akhir — terasa natural
        width: size,                                               // lebar kotak — bereaksi ke slider 'size'
        height: size,                                              // tinggi sama dengan lebar — selalu persegi
        decoration: BoxDecoration(
          color: accentColor.withOpacity(opacity / 100),           // bagi 100 karena opacity slider bernilai 10–100, bukan 0.0–1.0
          borderRadius: BorderRadius.circular(radius),             // radius bereaksi ke slider 'radius'
          boxShadow: elevation > 0                                 // hanya buat shadow jika elevation > 0 — nilai 0 = tidak ada bayangan
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.35),          // bayangan berwarna aksen — lebih menarik dari hitam
                    blurRadius: elevation * 2,                     // blur = 2x elevation — proporsi natural bayangan
                    spreadRadius: elevation * 0.25,                // spread kecil — bayangan tidak terlalu lebar
                    offset: Offset(0, elevation * 0.5),            // bayangan ke bawah — tinggi shadow = setengah elevation
                  ),
                ]
              : null,                                              // null = tidak ada shadow — lebih efisien dari list kosong
        ),
        child: Center(                                             // teks di tengah kotak
          child: Text(
            '${size.toInt()}px',                                   // tampilkan ukuran aktual — toInt() buang desimal
            style: TextStyle(
              color: Colors.white.withOpacity(                     // warna teks putih, opacity mengikuti opacity kotak
                (opacity / 100).clamp(0.5, 1.0),                  // clamp pastikan opacity teks minimal 0.5 agar tetap terbaca
              ),
              fontSize: (size * 0.14).clamp(11.0, 22.0),          // ukuran font proporsional — 14% dari lebar kotak, minimal 11 maksimal 22
              fontWeight: FontWeight.w700,                          // tebal agar kontras dengan latar kotak
            ),
          ),
        ),
      ),
    );
  }
}