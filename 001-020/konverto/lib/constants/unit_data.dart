import 'package:konverto/models/conversion_category.dart'; // import enum kategori untuk pengelompokan satuan

// Faktor konversi satuan panjang, semua relatif terhadap meter sebagai satuan dasar (base unit)
const Map<String, double> lengthUnits = {
  'Meter': 1.0, // 1 meter = 1 meter (basis)
  'Kilometer': 1000.0, // 1 kilometer = 1000 meter
  'Sentimeter': 0.01, // 1 sentimeter = 0.01 meter
  'Mil': 1609.34, // 1 mil (mile) = 1609.34 meter
  'Kaki': 0.3048, // 1 kaki (foot) = 0.3048 meter
  'Inci': 0.0254, // 1 inci (inch) = 0.0254 meter
};

// Faktor konversi satuan berat, semua relatif terhadap kilogram sebagai satuan dasar
const Map<String, double> weightUnits = {
  'Kilogram': 1.0, // 1 kilogram = 1 kilogram (basis)
  'Gram': 0.001, // 1 gram = 0.001 kilogram
  'Pon': 0.453592, // 1 pon (pound) = 0.453592 kilogram
  'Ons': 0.0283495, // 1 ons (ounce) = 0.0283495 kilogram
};

// Daftar nama satuan suhu, tidak pakai faktor karena rumusnya non-linear (mengandung offset)
const List<String> temperatureUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];

// Fungsi bantu untuk mengambil daftar nama satuan berdasarkan kategori yang aktif dipilih user
List<String> unitsForCategory(UnitCategory category) {
  switch (category) { // cek kategori mana yang sedang aktif
    case UnitCategory.length: // jika kategori panjang
      return lengthUnits.keys.toList(); // kembalikan semua nama satuan panjang
    case UnitCategory.weight: // jika kategori berat
      return weightUnits.keys.toList(); // kembalikan semua nama satuan berat
    case UnitCategory.temperature: // jika kategori suhu
      return temperatureUnits; // kembalikan daftar satuan suhu langsung
  }
}