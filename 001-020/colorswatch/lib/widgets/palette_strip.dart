import 'package:flutter/material.dart';
import '../models/color_swatch_model.dart';
import 'swatch_card.dart';

class PaletteStrip extends StatelessWidget {
  final List<ColorSwatchModel> swatches;
  final ValueChanged<ColorSwatchModel> onSelect;
  final ValueChanged<ColorSwatchModel> onDelete;

  const PaletteStrip({
    super.key,
    required this.swatches,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (swatches.isEmpty) {
      return const SizedBox(
        height: 64,
        child: Center(
          child: Text(
            'Palet masih kosong',
            style: TextStyle(color: Colors.white38),
          ),
        ),
      );
    }
    return SizedBox(
      height: 64,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: swatches.length,
        itemBuilder: (context, index) {
          final swatch = swatches[index];
          return SwatchCard(
            swatch: swatch,
            onTap: () => onSelect(swatch),
            onLongPress: () => onDelete(swatch),
          );
        },
      ),
    );
  }
}