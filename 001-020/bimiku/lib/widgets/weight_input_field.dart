import 'package:flutter/material.dart'; // widget TextFormField dan lainnya

// widget input berat badan, stateless karena data disimpan oleh parent (lifted state)
class WeightInputField extends StatelessWidget {
  const WeightInputField({ // constructor menerima semua yang dibutuhkan dari luar
    super.key,
    required this.controller, // controller untuk membaca dan mengatur teks input
  });

  final TextEditingController controller; // menyimpan referensi controller dari home_screen

  @override
  Widget build(BuildContext context) {
    return TextFormField( // field input teks dengan dukungan validasi form
      controller: controller, // menghubungkan field ini dengan controller dari parent
      keyboardType: const TextInputType.numberWithOptions(decimal: true), // keyboard angka dengan desimal
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // gaya teks yang diketik user
      decoration: const InputDecoration( // dekorasi visual field
        labelText: 'Berat Badan', // label yang mengambang di atas field
        suffixText: 'kg', // satuan yang muncul di kanan field
        prefixIcon: Icon(Icons.monitor_weight_outlined), // ikon timbangan di kiri field
      ),
      validator: (value) { // fungsi validasi, dipanggil saat form.validate() dijalankan
        if (value == null || value.trim().isEmpty) { // mengecek apakah field kosong
          return 'Berat badan wajib diisi'; // pesan error jika kosong
        }
        final parsed = double.tryParse(value.replaceAll(',', '.')); // ubah koma jadi titik lalu parse
        if (parsed == null) { // jika gagal parse, berarti bukan angka valid
          return 'Masukkan angka yang valid'; // pesan error format salah
        }
        if (parsed < 20 || parsed > 300) { // mengecek rentang berat badan yang masuk akal
          return 'Berat badan harus antara 20-300 kg'; // pesan error di luar rentang
        }
        return null; // null berarti input valid, tidak ada error
      },
    );
  }
}