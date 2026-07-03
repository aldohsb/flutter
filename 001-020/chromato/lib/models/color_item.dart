import 'package:flutter/material.dart';

class ColorItem {
  final Color value;
  final String name;

  const ColorItem({
    required this.value,
    required this.name,
  });

  String get hex {
    final argb = value.toARGB32();
    // ambil representasi int 32-bit (A-R-G-B) dari Color

    return '#${argb.toRadixString(16).substring(2).toUpperCase()}';
    // buang 2 digit alpha di depan, sisanya adalah RGB
  }
}