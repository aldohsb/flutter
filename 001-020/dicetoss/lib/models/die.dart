// ============================================================
// models/die.dart
// Tidak import package Flutter — murni data dan logika dadu.
// IconData dipindah ke widgets karena butuh package Flutter.
// ============================================================

import 'dart:math';

// Nilai minimum dan maksimum dadu standar.
// Konstanta agar tidak ada magic number tersebar di kode lain.
const int kDieMin = 1;
const int kDieMax = 6;

// Satu instance Random dibuat sekali dan dipakai ulang.
// Membuat Random() baru setiap lempar hasilnya kurang acak
// jika dibuat dalam waktu sangat berdekatan.
final Random _rng = Random();

// Model untuk satu dadu.
class Die {
  // Nilai dadu saat ini (1–6), default 1 sebelum dilempar.
  int value;

  Die({this.value = 1});

  // Lempar dadu: hasilkan angka acak 1–6.
  // nextInt(6) → 0,1,2,3,4,5 — ditambah 1 agar jadi 1–6.
  void roll() {
    value = _rng.nextInt(kDieMax) + kDieMin;
  }

  // Buat salinan Die dengan nilai baru, objek asli tidak berubah.
  // Dipakai agar setState dapat mendeteksi perubahan referensi.
  Die copyWith({int? value}) {
    return Die(value: value ?? this.value);
  }
}