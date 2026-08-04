import 'package:bimiku/models/bmi_category.dart'; // enum kategori BMI
import 'package:bimiku/models/bmi_result.dart'; // model hasil BMI

// class ini berisi rumus murni untuk menghitung BMI, tanpa ketergantungan UI sama sekali
class BmiCalculator {
  BmiCalculator._(); // constructor privat, class ini hanya berisi static method

  static BmiResult calculate({ // fungsi utama, menerima berat dan tinggi
    required double weightKg, // berat badan dalam kilogram
    required double heightCm, // tinggi badan dalam sentimeter
  }) {
    final heightM = heightCm / 100; // mengubah tinggi dari cm ke meter, rumus BMI butuh satuan meter
    final bmiValue = weightKg / (heightM * heightM); // rumus BMI standar: berat (kg) / tinggi^2 (m)
    final category = BmiCategory.fromBmi(bmiValue); // menentukan kategori dari nilai BMI yang didapat

    return BmiResult(bmiValue: bmiValue, category: category); // membungkus nilai dan kategori jadi satu object
  }
}