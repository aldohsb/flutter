import 'package:flutter/material.dart'; // import widget dasar Material Design
import 'package:konverto/models/conversion_category.dart'; // import enum kategori & extension label

// Widget dropdown untuk memilih kategori konversi (Panjang/Berat/Suhu)
class CategoryDropdown extends StatelessWidget { // stateless, state disimpan di parent (HomeScreen)
  const CategoryDropdown({ // constructor const untuk performa optimal
    super.key, // teruskan key ke parent widget
    required this.selected, // kategori yang sedang aktif dipilih
    required this.onChanged, // callback saat user memilih kategori lain
  });

  final UnitCategory selected; // menyimpan nilai kategori terpilih saat ini
  final ValueChanged<UnitCategory> onChanged; // fungsi yang dipanggil parent saat nilai berubah

  @override
  Widget build(BuildContext context) { // method wajib untuk merender widget
    return DropdownButtonFormField<UnitCategory>( // dropdown bergaya form field standar (bukan API lama)
      initialValue: selected, // set nilai awal sesuai state parent
      decoration: const InputDecoration( // dekorasi visual dropdown
        labelText: 'Kategori Konversi', // label yang muncul di atas dropdown
        border: OutlineInputBorder(), // border kotak agar terlihat profesional
      ),
      items: UnitCategory.values.map((category) { // ubah setiap nilai enum menjadi item dropdown
        return DropdownMenuItem<UnitCategory>( // item dropdown untuk satu kategori
          value: category, // nilai yang dikirim saat item ini dipilih
          child: Text(category.label), // teks label yang ditampilkan ke user
        );
      }).toList(), // ubah hasil map menjadi List sesuai kebutuhan parameter items
      onChanged: (value) { // handler saat user memilih item baru
        if (value != null) onChanged(value); // pastikan tidak null lalu teruskan ke parent
      },
    );
  }
}