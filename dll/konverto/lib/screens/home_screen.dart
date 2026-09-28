import 'package:flutter/material.dart'; // import widget dasar Material Design
import 'package:konverto/constants/unit_data.dart'; // import daftar satuan per kategori
import 'package:konverto/models/conversion_category.dart'; // import enum kategori konversi
import 'package:konverto/utils/converter.dart'; // import fungsi logika konversi
import 'package:konverto/widgets/category_dropdown.dart'; // import dropdown kategori
import 'package:konverto/widgets/unit_dropdown.dart'; // import dropdown satuan
import 'package:konverto/widgets/value_input_field.dart'; // import field input angka
import 'package:konverto/widgets/result_display.dart'; // import widget tampilan hasil

// Halaman utama aplikasi, StatefulWidget karena banyak nilai yang berubah-ubah (kategori, satuan, hasil)
class HomeScreen extends StatefulWidget { // deklarasi kelas halaman utama
  const HomeScreen({super.key}); // constructor const standar

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // buat objek state terkait halaman ini
}

// Kelas State yang menyimpan seluruh data dinamis halaman konverter
class _HomeScreenState extends State<HomeScreen> { // kelas state privat untuk HomeScreen
  final _formKey = GlobalKey<FormState>(); // key untuk mengakses & memvalidasi Form
  final _valueController = TextEditingController(); // controller untuk membaca input angka user

  UnitCategory _category = UnitCategory.length; // kategori aktif, default ke Panjang
  late String _fromUnit = unitsForCategory(_category).first; // satuan asal default, ambil item pertama
  late String _toUnit = unitsForCategory(_category).last; // satuan tujuan default, ambil item terakhir
  String _resultText = ''; // teks hasil konversi, kosong sampai user menekan tombol konversi

  @override
  void dispose() { // method wajib untuk membersihkan resource saat widget dihapus
    _valueController.dispose(); // buang controller agar tidak bocor memori
    super.dispose(); // panggil dispose bawaan parent class
  }

  // Dipanggil saat user mengganti kategori, reset satuan asal & tujuan sesuai kategori baru
  void _onCategoryChanged(UnitCategory category) { // handler perubahan kategori
    final units = unitsForCategory(category); // ambil daftar satuan baru sesuai kategori
    setState(() { // setState memicu build ulang UI dengan data terbaru
      _category = category; // simpan kategori baru ke state
      _fromUnit = units.first; // reset satuan asal ke opsi pertama
      _toUnit = units.last; // reset satuan tujuan ke opsi terakhir
      _resultText = ''; // kosongkan hasil lama karena konteks sudah berubah
    });
  }

  // Dipanggil saat user menekan tombol "Konversi", memvalidasi lalu menghitung hasil
  void _onConvertPressed() { // handler tombol konversi
    if (!_formKey.currentState!.validate()) return; // hentikan jika validasi form gagal
    final double input = double.parse(_valueController.text.trim()); // parse teks input menjadi angka
    final double output = convertValue( // panggil fungsi logika konversi utama
      category: _category, // kategori aktif saat ini
      fromUnit: _fromUnit, // satuan asal terpilih
      toUnit: _toUnit, // satuan tujuan terpilih
      value: input, // nilai angka yang sudah divalidasi
    );
    setState(() { // perbarui UI dengan hasil baru
      _resultText = '${input.toStringAsFixed(2)} $_fromUnit = ${output.toStringAsFixed(4)} $_toUnit'; // format teks hasil
    });
  }

  @override
  Widget build(BuildContext context) { // method wajib merender seluruh halaman
    final units = unitsForCategory(_category); // ambil daftar satuan sesuai kategori aktif untuk dropdown
    return Scaffold( // struktur dasar halaman dengan AppBar & body
      appBar: AppBar( // bar judul di atas halaman
        title: const Text('Konverto'), // judul aplikasi di AppBar
        centerTitle: true, // posisikan judul di tengah agar terlihat rapi
      ),
      body: Form( // bungkus konten dengan Form agar validator TextFormField berfungsi
        key: _formKey, // hubungkan form dengan key untuk validasi
        child: ListView( // ListView agar konten bisa discroll di layar kecil (mobile/web sempit)
          padding: const EdgeInsets.all(16), // padding di sekeliling daftar
          children: [ // daftar widget yang disusun vertikal
            CategoryDropdown(selected: _category, onChanged: _onCategoryChanged), // dropdown pilih kategori
            const SizedBox(height: 16), // jarak antar elemen
            UnitDropdown( // dropdown satuan asal
              label: 'Dari Satuan', // label field
              units: units, // opsi satuan sesuai kategori
              selected: _fromUnit, // nilai terpilih saat ini
              onChanged: (value) => setState(() => _fromUnit = value), // update state saat berubah
            ),
            const SizedBox(height: 16), // jarak antar elemen
            UnitDropdown( // dropdown satuan tujuan
              label: 'Ke Satuan', // label field
              units: units, // opsi satuan sesuai kategori (sama dengan asal)
              selected: _toUnit, // nilai terpilih saat ini
              onChanged: (value) => setState(() => _toUnit = value), // update state saat berubah
            ),
            const SizedBox(height: 16), // jarak antar elemen
            ValueInputField(controller: _valueController), // field input angka dengan validasi
            const SizedBox(height: 24), // jarak lebih besar sebelum tombol
            FilledButton.icon( // tombol utama gaya Material 3, lebih modern dari ElevatedButton polos
              onPressed: _onConvertPressed, // aksi saat tombol ditekan
              icon: const Icon(Icons.calculate_rounded), // ikon kalkulator pada tombol
              label: const Text('Konversi'), // teks tombol
            ),
            const SizedBox(height: 24), // jarak sebelum hasil
            ResultDisplay(resultText: _resultText), // tampilkan hasil konversi jika sudah ada
          ],
        ),
      ),
    );
  }
}