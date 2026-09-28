import 'package:flutter/material.dart'; // widget inti flutter
import '../core/theme/app_colors.dart'; // warna gradasi latar belakang
import '../utils/bmi_calculator.dart'; // engine perhitungan BMI
import '../widgets/weight_input_field.dart'; // field input berat badan
import '../widgets/height_slider.dart'; // slider tinggi badan
import '../widgets/calculate_button.dart'; // tombol hitung BMI
import '../widgets/bmi_result_dialog.dart'; // dialog hasil BMI, pengganti kartu inline Part 2

// halaman utama aplikasi, menyimpan seluruh state input (lifted state pattern)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // constructor const, tidak ada parameter dari luar

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // membuat objek state terpisah
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>(); // kunci untuk mengakses dan memvalidasi Form
  final _weightController = TextEditingController(); // controller untuk membaca input berat badan
  double _heightCm = 165; // nilai awal tinggi badan, tampil sebelum user menggeser slider

  @override
  void dispose() { // dipanggil otomatis saat widget dihancurkan dari tree
    _weightController.dispose(); // membersihkan controller agar tidak membocorkan memori
    super.dispose(); // memanggil dispose bawaan parent class
  }

  void _handleCalculate() { // dipanggil saat tombol "Hitung BMI" ditekan
    final isValid = _formKey.currentState?.validate() ?? false; // menjalankan semua validator field
    if (!isValid) return; // jika ada input tidak valid, hentikan proses di sini

    final weight = double.parse(_weightController.text.replaceAll(',', '.')); // parse teks jadi angka, aman karena sudah lolos validator
    final result = BmiCalculator.calculate(weightKg: weight, heightCm: _heightCm); // panggil engine perhitungan murni

    BmiResultDialog.show(context, result); // menampilkan hasil dalam AlertDialog beranimasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // struktur dasar halaman flutter
      body: Container( // pembungkus untuk memberi gradasi latar belakang
        decoration: const BoxDecoration( // dekorasi gradasi
          gradient: LinearGradient( // gradasi warna dari atas ke bawah
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundTop, AppColors.backgroundBottom], // dua warna gradasi kita
          ),
        ),
        child: SafeArea( // mencegah konten tertutup notch atau status bar
          child: SingleChildScrollView( // agar konten tetap bisa discroll di layar kecil
            padding: const EdgeInsets.all(24), // jarak konten dari tepi layar
            child: Form( // pembungkus form untuk validasi terpusat
              key: _formKey, // menghubungkan form dengan GlobalKey di atas
              child: Column( // menyusun semua elemen secara vertikal
                crossAxisAlignment: CrossAxisAlignment.stretch, // semua child melebar penuh
                children: [
                  const SizedBox(height: 12), // jarak dari atas layar
                  Text( // judul aplikasi
                    'Bimiku', // nama aplikasi
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith( // ambil style tema lalu modifikasi
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Text( // subjudul penjelas
                    'Hitung indeks massa tubuhmu dengan mudah',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 32), // jarak sebelum form input
                  WeightInputField(controller: _weightController), // field berat badan
                  const SizedBox(height: 20), // jarak antar elemen
                  HeightSlider( // slider tinggi badan
                    heightCm: _heightCm, // nilai tinggi saat ini dari state
                    onChanged: (value) => setState(() => _heightCm = value), // update state saat digeser
                  ),
                  const SizedBox(height: 32), // jarak sebelum tombol
                  CalculateButton(onPressed: _handleCalculate), // tombol pemicu perhitungan
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}