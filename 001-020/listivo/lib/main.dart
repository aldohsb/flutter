// lib/main.dart
// Entry point aplikasi Flutter, titik paling awal semua eksekusi dimulai

import 'package:flutter/material.dart'; // dibutuhkan oleh runApp
import 'app.dart'; // widget root ListivoApp

void main() {
  runApp(const ListivoApp()); // menempelkan widget root ke layar perangkat
}