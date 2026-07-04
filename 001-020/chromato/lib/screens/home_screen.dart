import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/color_palette.dart';
import '../models/color_item.dart';
import '../widgets/color_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ColorItem? _selectedColor;
  // null berarti belum ada warna yang dipilih

  void _handleSelect(ColorItem item) {
    setState(() {
      _selectedColor = item;
    });
    // setState memberi tahu Flutter: "data berubah, gambar ulang UI"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chromato')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            _selectedColor?.name ?? 'Pilih warna di bawah',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ColorGrid(
              colors: ColorPalette.colors,
              selected: _selectedColor,
              onSelect: _handleSelect,
            ),
          ),
        ],
      ),
    );
  }
}