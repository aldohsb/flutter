// Model untuk menyimpan hasil konversi
// Berguna untuk history dan menampilkan hasil

import 'unit_item.dart';

class ConversionResult {
  final double inputValue; // Nilai yang diinput user
  final double outputValue; // Nilai hasil konversi
  final UnitItem fromUnit; // Unit asal
  final UnitItem toUnit; // Unit tujuan
  final DateTime timestamp; // Waktu konversi dilakukan

  // Constructor
  const ConversionResult({
    required this.inputValue,
    required this.outputValue,
    required this.fromUnit,
    required this.toUnit,
    required this.timestamp,
  });

  // Getter untuk mendapatkan string representasi konversi
  // Contoh: "100 m = 0.1 km"
  String get displayText {
    return '${fromUnit.formatValue(inputValue)} = ${toUnit.formatValue(outputValue)}';
  }

  // Getter untuk format tanggal yang mudah dibaca
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    // Kalau baru beberapa detik yang lalu
    if (difference.inSeconds < 60) {
      return 'Baru saja';
    }
    // Kalau baru beberapa menit yang lalu
    else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    }
    // Kalau baru beberapa jam yang lalu
    else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    }
    // Kalau lebih dari sehari, tampilkan tanggal
    else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  // Convert object ke Map untuk disimpan di storage
  // Map seperti dictionary/object JavaScript
  Map<String, dynamic> toMap() {
    return {
      'inputValue': inputValue,
      'outputValue': outputValue,
      'fromUnitName': fromUnit.name,
      'fromUnitSymbol': fromUnit.symbol,
      'fromUnitFactor': fromUnit.conversionFactor,
      'toUnitName': toUnit.name,
      'toUnitSymbol': toUnit.symbol,
      'toUnitFactor': toUnit.conversionFactor,
      'timestamp': timestamp.millisecondsSinceEpoch, // Simpan sebagai angka
    };
  }

  // Factory constructor untuk membuat object dari Map
  // Berguna untuk load data dari storage
  factory ConversionResult.fromMap(Map<String, dynamic> map) {
    return ConversionResult(
      inputValue: map['inputValue'] as double,
      outputValue: map['outputValue'] as double,
      fromUnit: UnitItem(
        name: map['fromUnitName'] as String,
        symbol: map['fromUnitSymbol'] as String,
        conversionFactor: map['fromUnitFactor'] as double,
      ),
      toUnit: UnitItem(
        name: map['toUnitName'] as String,
        symbol: map['toUnitSymbol'] as String,
        conversionFactor: map['toUnitFactor'] as double,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  @override
  String toString() => displayText;
}