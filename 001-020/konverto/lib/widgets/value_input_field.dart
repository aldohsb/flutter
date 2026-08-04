import 'package:flutter/material.dart'; // import widget dasar Material Design

// Widget input angka dengan validasi form bawaan Flutter (Form + TextFormField)
class ValueInputField extends StatelessWidget { // stateless, controller dikelola oleh parent
  const ValueInputField({super.key, required this.controller}); // constructor menerima controller teks

  final TextEditingController controller; // controller untuk membaca & mengontrol teks input

  @override
  Widget build(BuildContext context) { // render widget input
    return TextFormField( // field input teks yang terhubung ke validasi Form
      controller: controller, // hubungkan controller agar nilai bisa dibaca saat submit
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true), // keyboard angka desimal & negatif
      decoration: const InputDecoration( // dekorasi visual input
        labelText: 'Masukkan Nilai', // label field
        hintText: 'Contoh: 100', // teks bantuan contoh input
        border: OutlineInputBorder(), // border kotak konsisten
      ),
      validator: (value) { // fungsi validasi dipanggil saat formKey.currentState.validate()
        if (value == null || value.trim().isEmpty) { // cek jika input kosong
          return 'Nilai tidak boleh kosong'; // pesan error jika kosong
        }
        final parsed = double.tryParse(value.trim()); // coba parse teks menjadi angka
        if (parsed == null) { // jika gagal diparse berarti bukan angka valid
          return 'Masukkan angka yang valid'; // pesan error format salah
        }
        return null; // null berarti validasi lolos, tidak ada error
      },
    );
  }
}