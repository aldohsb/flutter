import 'package:flutter/material.dart'; // import class Color dari Flutter untuk definisi warna kustom

// Kelas berisi kumpulan warna khas brand Tapzo, dipakai sebagai seed color pembentuk tema
class AppColors {
  // Constructor privat, class ini hanya wadah konstanta statis, tidak perlu di-instantiate
  AppColors._();

  // Warna ungu khas brand Tapzo, jadi dasar generate seluruh palet ColorScheme
  static const Color seed = Color(0xFF6C4CE0);
}