// Model adalah blueprint/cetakan untuk data
// File ini mendefinisikan struktur data untuk kategori unit (length, weight, dll)

import 'package:flutter/material.dart';

// Enum adalah tipe data yang berisi pilihan tetap
// Seperti menu dropdown yang pilihan nya sudah ditentukan
enum UnitCategoryType {
  length, // Panjang (meter, kilometer, dll)
  weight, // Berat (kilogram, gram, dll)
  temperature, // Suhu (celsius, fahrenheit, dll)
  currency, // Mata uang (USD, IDR, dll)
  area, // Luas (meter persegi, dll)
  volume, // Volume (liter, mililiter, dll)
  speed, // Kecepatan (km/jam, m/s, dll)
  time, // Waktu (detik, menit, jam, dll)
}

// Class UnitCategory - cetakan untuk data kategori
class UnitCategory {
  final UnitCategoryType type; // Jenis kategori
  final String name; // Nama yang ditampilkan (contoh: "Length")
  final String nameBahasa; // Nama dalam bahasa Indonesia
  final IconData icon; // Icon yang ditampilkan
  final Color color; // Warna untuk kategori ini

  // Constructor - fungsi untuk membuat object UnitCategory baru
  // 'required' artinya parameter ini wajib diisi
  // 'this.name' adalah shorthand untuk assign parameter ke property
  const UnitCategory({
    required this.type,
    required this.name,
    required this.nameBahasa,
    required this.icon,
    required this.color,
  });

  // Getter - fungsi untuk mendapatkan nilai
  // Ini seperti computed property yang dihitung saat diakses
  String get displayName => nameBahasa;

  // Method untuk membandingkan 2 object UnitCategory
  // Berguna untuk cek apakah 2 kategori sama
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnitCategory && other.type == type;
  }

  // hashCode dibutuhkan ketika kita override operator ==
  // Ini untuk performa saat menyimpan object di collection (Set, Map)
  @override
  int get hashCode => type.hashCode;

  // toString berguna untuk debugging - print object jadi mudah dibaca
  @override
  String toString() => 'UnitCategory($name)';
}