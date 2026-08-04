import 'package:flutter/material.dart'; // import widget dasar Material Design

// Widget dropdown generik untuk memilih satuan (dipakai dua kali: satuan asal & satuan tujuan)
class UnitDropdown extends StatelessWidget { // stateless, data & callback datang dari parent
  const UnitDropdown({ // constructor const
    super.key, // teruskan key ke parent
    required this.label, // label field, misal "Dari Satuan" atau "Ke Satuan"
    required this.units, // daftar nama satuan yang tersedia untuk kategori aktif
    required this.selected, // satuan yang sedang dipilih
    required this.onChanged, // callback saat user ganti satuan
  });

  final String label; // teks label field ini
  final List<String> units; // daftar opsi satuan
  final String selected; // nilai satuan terpilih saat ini
  final ValueChanged<String> onChanged; // fungsi callback ke parent

  @override
  Widget build(BuildContext context) { // render widget dropdown
    return DropdownButtonFormField<String>( // dropdown bergaya form field
      initialValue: selected, // nilai default sesuai state parent
      decoration: InputDecoration( // dekorasi visual dropdown
        labelText: label, // tampilkan label dinamis (asal/tujuan)
        border: const OutlineInputBorder(), // border kotak konsisten dengan dropdown kategori
      ),
      items: units.map((unit) { // ubah setiap nama satuan menjadi item dropdown
        return DropdownMenuItem<String>( // item dropdown untuk satu satuan
          value: unit, // nilai satuan yang dikirim saat dipilih
          child: Text(unit), // teks nama satuan yang ditampilkan
        );
      }).toList(), // konversi hasil map menjadi List
      onChanged: (value) { // handler saat user pilih satuan lain
        if (value != null) onChanged(value); // validasi non-null lalu teruskan ke parent
      },
    );
  }
}