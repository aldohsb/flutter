// Utility untuk menghitung konversi
// Termasuk handle special case seperti temperature

import 'dart:math' as math;
import '../models/unit_item.dart';
import '../models/unit_category.dart';

class ConversionCalculator {
  // Private constructor
  ConversionCalculator._();

  // Method utama untuk convert unit
  // Menerima value, unit asal, unit tujuan, dan kategori
  static double convert({
    required double value,
    required UnitItem fromUnit,
    required UnitItem toUnit,
    required UnitCategoryType category,
  }) {
    // Kalau unit sama, return value asli
    if (fromUnit == toUnit) return value;

    // Temperature punya rumus special, bukan simple multiplication
    if (category == UnitCategoryType.temperature) {
      return _convertTemperature(value, fromUnit, toUnit);
    }

    // Untuk unit lain, gunakan conversion factor
    return fromUnit.convertTo(value, toUnit);
  }

  // Private method untuk convert temperature
  // Temperature tidak bisa pakai multiplication biasa karena ada offset
  static double _convertTemperature(
    double value,
    UnitItem fromUnit,
    UnitItem toUnit,
  ) {
    // Step 1: Convert ke Celsius dulu (sebagai base)
    double celsius;

    if (fromUnit.symbol == '°C') {
      celsius = value;
    } else if (fromUnit.symbol == '°F') {
      // Formula: C = (F - 32) × 5/9
      celsius = (value - 32) * 5 / 9;
    } else if (fromUnit.symbol == 'K') {
      // Formula: C = K - 273.15
      celsius = value - 273.15;
    } else {
      celsius = value; // Fallback
    }

    // Step 2: Convert dari Celsius ke target unit
    if (toUnit.symbol == '°C') {
      return celsius;
    } else if (toUnit.symbol == '°F') {
      // Formula: F = C × 9/5 + 32
      return celsius * 9 / 5 + 32;
    } else if (toUnit.symbol == 'K') {
      // Formula: K = C + 273.15
      return celsius + 273.15;
    }

    return celsius; // Fallback
  }

  // Method untuk format angka hasil konversi
  // Menghindari terlalu banyak desimal
  static String formatResult(double value, {int maxDecimals = 6}) {
    // Kalau value sangat kecil atau sangat besar, gunakan scientific notation
    if (value.abs() > 1e10 || (value.abs() < 1e-6 && value != 0)) {
      return value.toStringAsExponential(2);
    }

    // Round ke maxDecimals
    final multiplier = math.pow(10, maxDecimals);
    final rounded = (value * multiplier).round() / multiplier;

    // Kalau hasil integer, tampilkan tanpa desimal
    if (rounded == rounded.toInt()) {
      return rounded.toInt().toString();
    }

    // Hapus trailing zeros
    String result = rounded.toStringAsFixed(maxDecimals);
    result = result.replaceAll(RegExp(r'0+$'), ''); // Hapus 0 di belakang
    result = result.replaceAll(RegExp(r'\.$'), ''); // Hapus titik di belakang

    return result;
  }

  // Method untuk parse input string menjadi double
  // Handle koma dan titik sebagai decimal separator
  static double? parseInput(String input) {
    if (input.isEmpty) return null;

    // Replace koma dengan titik
    input = input.replaceAll(',', '.');

    // Coba parse
    try {
      return double.parse(input);
    } catch (e) {
      return null; // Return null jika gagal parse
    }
  }

  // Method untuk validasi input
  // Return true jika input valid
  static bool isValidInput(String input) {
    if (input.isEmpty) return false;

    // Cek apakah bisa di-parse jadi double
    final value = parseInput(input);
    if (value == null) return false;

    // Cek apakah bukan infinity atau NaN
    if (value.isInfinite || value.isNaN) return false;

    return true;
  }

  // Method untuk format angka dengan pemisah ribuan
  // Contoh: 1000000 => "1,000,000"
  static String formatWithThousandsSeparator(double value) {
    final formatted = formatResult(value);
    
    // Split jadi integer dan decimal part
    final parts = formatted.split('.');
    final intPart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Tambah koma sebagai thousand separator
    String result = '';
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) {
        result += ',';
      }
      result += intPart[i];
    }

    return result + decimalPart;
  }
}