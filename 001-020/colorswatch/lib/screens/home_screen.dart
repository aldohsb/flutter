import 'package:flutter/material.dart';
import '../models/color_swatch_model.dart';
import '../utils/color_utils.dart';
import '../widgets/rgb_slider.dart';
import '../widgets/color_preview.dart';
import '../widgets/palette_strip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _red = 120;
  double _green = 180;
  double _blue = 240;
  final List<ColorSwatchModel> _palette = [];

  Color get _currentColor => Color.fromARGB(
        255,
        _red.round(),
        _green.round(),
        _blue.round(),
      );

  void _updateChannel({double? r, double? g, double? b}) {
    setState(() {
      if (r != null) _red = r;
      if (g != null) _green = g;
      if (b != null) _blue = b;
    });
  }

  void _addToPalette() {
    setState(() {
      _palette.insert(
        0,
        ColorSwatchModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          color: _currentColor,
        ),
      );
    });
  }

  void _loadSwatch(ColorSwatchModel swatch) {
    setState(() {
      _red = channelToInt(swatch.color.r).toDouble();
      _green = channelToInt(swatch.color.g).toDouble();
      _blue = channelToInt(swatch.color.b).toDouble();
    });
  }

  void _deleteSwatch(ColorSwatchModel swatch) {
    setState(() {
      _palette.removeWhere((item) => item.id == swatch.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              _currentColor.withValues(alpha: 0.25),
              const Color(0xFF0E0E12),
            ],
            radius: 1.2,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'ColorSwatch',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                ),
                const SizedBox(height: 20),
                ColorPreview(color: _currentColor),
                const SizedBox(height: 24),
                _buildSliderCard(),
                const SizedBox(height: 20),
                _buildAddButton(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Palet Tersimpan',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 10),
                PaletteStrip(
                  swatches: _palette,
                  onSelect: _loadSwatch,
                  onDelete: _deleteSwatch,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          RgbSlider(
            label: 'R',
            value: _red,
            trackColor: const Color(0xFFFF5C5C),
            onChanged: (v) => _updateChannel(r: v),
          ),
          RgbSlider(
            label: 'G',
            value: _green,
            trackColor: const Color(0xFF5CFF8F),
            onChanged: (v) => _updateChannel(g: v),
          ),
          RgbSlider(
            label: 'B',
            value: _blue,
            trackColor: const Color(0xFF5C9CFF),
            onChanged: (v) => _updateChannel(b: v),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _addToPalette,
        icon: const Icon(Icons.add),
        label: const Text('Tambah ke Palet'),
        style: FilledButton.styleFrom(
          backgroundColor: _currentColor,
          foregroundColor: contrastColor(_currentColor),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}