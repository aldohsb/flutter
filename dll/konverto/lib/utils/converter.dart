import 'package:konverto/constants/unit_data.dart'; // import tabel faktor konversi panjang & berat
import 'package:konverto/models/conversion_category.dart'; // import enum kategori konversi

// Fungsi utama konversi: menyatukan strategi linear (panjang/berat) & non-linear (suhu) dalam satu API
double convertValue({ // fungsi publik yang dipanggil langsung dari layer UI
  required UnitCategory category, // kategori konversi yang sedang dipilih user
  required String fromUnit, // nama satuan asal
  required String toUnit, // nama satuan tujuan
  required double value, // nilai angka yang ingin dikonversi
}) {
  if (category == UnitCategory.temperature) { // cabang khusus karena suhu tak bisa dikali satu faktor tunggal
    return _convertTemperature(fromUnit, toUnit, value); // delegasikan ke fungsi suhu privat
  }
  final Map<String, double> factors = category == UnitCategory.length // pilih tabel faktor sesuai kategori
      ? lengthUnits // pakai tabel panjang jika kategorinya panjang
      : weightUnits; // pakai tabel berat jika kategorinya berat
  final double baseValue = value * factors[fromUnit]!; // langkah 1: normalisasi nilai ke satuan dasar (hub)
  return baseValue / factors[toUnit]!; // langkah 2: denormalisasi dari satuan dasar ke satuan tujuan
}

// Fungsi privat konversi suhu, memakai Celsius sebagai "hub" perantara antar satuan
double _convertTemperature(String fromUnit, String toUnit, double value) {
  final double celsius = _toCelsius(fromUnit, value); // ubah nilai asal menjadi Celsius (basis suhu)
  return _fromCelsius(toUnit, celsius); // ubah dari Celsius ke satuan tujuan
}

// Mengubah nilai suhu dari satuan apapun menjadi Celsius
double _toCelsius(String unit, double value) {
  switch (unit) { // cek satuan asal input
    case 'Fahrenheit': // jika satuan asal Fahrenheit
      return (value - 32) * 5 / 9; // rumus konversi Fahrenheit ke Celsius
    case 'Kelvin': // jika satuan asal Kelvin
      return value - 273.15; // rumus konversi Kelvin ke Celsius
    default: // jika satuan asal sudah Celsius
      return value; // tidak perlu diubah
  }
}

// Mengubah nilai Celsius menjadi satuan suhu tujuan
double _fromCelsius(String unit, double celsius) {
  switch (unit) { // cek satuan tujuan
    case 'Fahrenheit': // jika tujuan Fahrenheit
      return celsius * 9 / 5 + 32; // rumus konversi Celsius ke Fahrenheit
    case 'Kelvin': // jika tujuan Kelvin
      return celsius + 273.15; // rumus konversi Celsius ke Kelvin
    default: // jika tujuan Celsius
      return celsius; // tidak perlu diubah
  }
}