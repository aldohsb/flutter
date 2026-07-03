import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/color_palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final total = ColorPalette.colors.length;
    // jumlah warna yang tersedia di palette

    return Scaffold(
      appBar: AppBar(title: const Text('Chromato')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.palette_outlined,
              size: 64,
              color: AppColors.accent,
            ),
            const SizedBox(height: 16),
            Text(
              '$total warna siap dipilih',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}