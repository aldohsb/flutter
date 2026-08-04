import 'package:flutter/material.dart'; // untuk tipe Color pada setiap kategori

// enum ini merepresentasikan 4 kategori BMI standar WHO
enum BmiCategory {
  underweight, // BMI di bawah 18.5
  normal, // BMI 18.5 - 24.9
  overweight, // BMI 25 - 29.9
  obese; // BMI 30 ke atas

  // factory method untuk menentukan kategori dari satu nilai BMI mentah
  static BmiCategory fromBmi(double bmi) { // menerima nilai BMI hasil perhitungan
    if (bmi < 18.5) return BmiCategory.underweight; // di bawah batas normal
    if (bmi < 25) return BmiCategory.normal; // rentang sehat
    if (bmi < 30) return BmiCategory.overweight; // kelebihan berat badan
    return BmiCategory.obese; // obesitas, BMI 30 ke atas
  }

  // label yang ditampilkan ke pengguna, dalam bahasa Indonesia
  String get label { // getter agar mudah dipanggil dari widget
    switch (this) { // mencocokkan enum value saat ini
      case BmiCategory.underweight:
        return 'Kekurangan Berat Badan';
      case BmiCategory.normal:
        return 'Berat Badan Normal';
      case BmiCategory.overweight:
        return 'Kelebihan Berat Badan';
      case BmiCategory.obese:
        return 'Obesitas';
    }
  }

  // warna representatif untuk tiap kategori, dipakai di dialog hasil pada Part 3
  Color get color { // getter warna sesuai tingkat risiko kategori
    switch (this) {
      case BmiCategory.underweight:
        return const Color(0xFF4FC3F7); // biru muda, menandakan perhatian ringan
      case BmiCategory.normal:
        return const Color(0xFF00A896); // hijau tosca, senada warna utama app = sehat
      case BmiCategory.overweight:
        return const Color(0xFFFFA726); // oranye, peringatan sedang
      case BmiCategory.obese:
        return const Color(0xFFEF5350); // merah, peringatan tinggi
    }
  }
}