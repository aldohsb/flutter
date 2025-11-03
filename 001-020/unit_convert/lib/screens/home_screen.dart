// Home screen sebagai entry point aplikasi
// Bisa dikembangkan untuk menambahkan navigation atau features lain

import 'package:flutter/material.dart';
import 'converter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Untuk saat ini, langsung show converter screen
    // Nanti bisa dikembangkan dengan bottom navigation atau drawer
    return const ConverterScreen();
  }
}