// Model untuk unit individual (contoh: Meter, Kilogram, dll)
// Setiap unit punya nama, simbol, dan faktor konversi

class UnitItem {
  final String name; // Nama unit (contoh: "Meter")
  final String symbol; // Simbol (contoh: "m")
  final double conversionFactor; // Faktor untuk konversi ke unit dasar
  
  // conversionFactor adalah angka pengali untuk convert ke base unit
  // Contoh untuk Length (base = meter):
  // - Meter: factor = 1 (karena dia base unit)
  // - Kilometer: factor = 1000 (1 km = 1000 m)
  // - Centimeter: factor = 0.01 (1 cm = 0.01 m)

  // Constructor dengan named parameters
  const UnitItem({
    required this.name,
    required this.symbol,
    required this.conversionFactor,
  });

  // Method untuk convert dari unit ini ke unit lain
  // Caranya: convert dulu ke base unit, baru ke target unit
  double convertTo(double value, UnitItem targetUnit) {
    // Step 1: Convert ke base unit (kalikan dengan factor sendiri)
    final baseValue = value * conversionFactor;
    
    // Step 2: Convert dari base unit ke target (bagi dengan factor target)
    final result = baseValue / targetUnit.conversionFactor;
    
    return result;
  }

  // Copy with - method untuk membuat salinan object dengan perubahan
  // Berguna ketika kita mau update sebagian property saja
  UnitItem copyWith({
    String? name,
    String? symbol,
    double? conversionFactor,
  }) {
    return UnitItem(
      name: name ?? this.name, // Kalau name null, pakai yang lama
      symbol: symbol ?? this.symbol,
      conversionFactor: conversionFactor ?? this.conversionFactor,
    );
  }

  // Operator == untuk membandingkan 2 unit
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnitItem && 
           other.name == name && 
           other.symbol == symbol;
  }

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode;

  @override
  String toString() => '$name ($symbol)';

  // Method untuk format tampilan unit dengan value
  // Contoh: formatValue(100, 'Meter') => "100 m"
  String formatValue(double value) {
    // Round ke 6 desimal untuk menghindari floating point error
    final rounded = (value * 1000000).round() / 1000000;
    
    // Kalau hasilnya integer (5.0), tampilkan tanpa desimal
    if (rounded == rounded.toInt()) {
      return '${rounded.toInt()} $symbol';
    }
    
    // Kalau ada desimal, tampilkan dengan format rapi
    return '${rounded.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '')} $symbol';
  }
}