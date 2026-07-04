import 'package:flutter/material.dart';
import '../models/color_item.dart';
import 'color_tile.dart';

class ColorGrid extends StatelessWidget {
  final List<ColorItem> colors;
  final ColorItem? selected;
  final ValueChanged<ColorItem> onSelect;

  const ColorGrid({
    super.key,
    required this.colors,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: colors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = colors[index];
        // ambil satu ColorItem sesuai posisi grid

        return ColorTile(
          item: item,
          isSelected: item.value == selected?.value,
          onTap: () => onSelect(item),
        );
      },
    );
  }
}