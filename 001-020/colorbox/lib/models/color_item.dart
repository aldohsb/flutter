import 'package:flutter/material.dart'; // import Color dari Flutter
 
class ColorItem { // class pengganti Map — lebih aman dan jelas tipenya
  final Color color; // warna yang ditampilkan sebagai background
  final String name; // nama warna yang ditampilkan ke user
 
  const ColorItem({ // const karena semua data sudah pasti saat compile
    required this.color, // wajib diisi saat membuat ColorItem
    required this.name, // wajib diisi saat membuat ColorItem
  });
}