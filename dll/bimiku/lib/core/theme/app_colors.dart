import 'package:flutter/material.dart'; // mengimpor library material untuk tipe Color

// class ini menyimpan semua warna utama aplikasi Bimiku di satu tempat
class AppColors {
  AppColors._(); // constructor privat agar class ini tidak bisa di-instantiate

  static const Color seed = Color(0xFF00A896); // warna dasar bertema kesehatan, hijau tosca segar
  static const Color backgroundTop = Color(0xFFE8FFF8); // warna atas gradasi latar, hijau sangat muda
  static const Color backgroundBottom = Color(0xFFFFFFFF); // warna bawah gradasi latar, putih bersih
}