import 'bmi_category.dart'; // mengimpor enum kategori untuk dipakai sebagai field

// class immutable yang membungkus hasil akhir perhitungan BMI
class BmiResult {
  const BmiResult({ // constructor const karena object ini tidak pernah berubah setelah dibuat
    required this.bmiValue, // nilai BMI mentah hasil rumus
    required this.category, // kategori yang sudah ditentukan dari nilai BMI
  });

  final double bmiValue; // menyimpan angka BMI, misal 22.86
  final BmiCategory category; // menyimpan kategori terkait, misal BmiCategory.normal
}