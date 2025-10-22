import 'package:flutter/material.dart';
import '../utils/color_helper.dart';
import '../widgets/color_preview.dart';
import '../widgets/color_slider.dart';

/// Screen utama untuk color mixing
/// Menggunakan ValueNotifier untuk reactive state management
class ColorMixerScreen extends StatefulWidget {
  const ColorMixerScreen({super.key});

  @override
  State<ColorMixerScreen> createState() => _ColorMixerScreenState();
}

class _ColorMixerScreenState extends State<ColorMixerScreen> {
  // === VALUE NOTIFIERS ===
  // ValueNotifier adalah cara simple untuk reactive programming
  // Ketika value berubah, semua listener akan otomatis ter-update
  
  // Hue: 0-360 derajat (warna: merah, kuning, hijau, biru, etc)
  late final ValueNotifier<double> _hueNotifier;
  
  // Saturation: 0.0-1.0 (kejenuhan: dari abu-abu ke warna penuh)
  late final ValueNotifier<double> _saturationNotifier;
  
  // Value/Brightness: 0.0-1.0 (kecerahan: dari hitam ke terang)
  late final ValueNotifier<double> _valueNotifier;

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi ValueNotifier dengan nilai default
    // Default: Vibrant Blue (Hue=220, Saturation=0.8, Value=0.9)
    _hueNotifier = ValueNotifier<double>(220.0);
    _saturationNotifier = ValueNotifier<double>(0.8);
    _valueNotifier = ValueNotifier<double>(0.9);
  }

  @override
  void dispose() {
    // PENTING: Selalu dispose ValueNotifier untuk avoid memory leak
    _hueNotifier.dispose();
    _saturationNotifier.dispose();
    _valueNotifier.dispose();
    super.dispose();
  }

  /// Method untuk reset warna ke default
  void _resetColors() {
    _hueNotifier.value = 220.0;
    _saturationNotifier.value = 0.8;
    _valueNotifier.value = 0.9;
  }

  /// Method untuk generate random color
  void _randomizeColors() {
    // Import dart:math untuk random
    final random = DateTime.now().millisecondsSinceEpoch % 360;
    _hueNotifier.value = random.toDouble();
    _saturationNotifier.value = 0.5 + (random % 50) / 100; // 0.5-1.0
    _valueNotifier.value = 0.5 + (random % 50) / 100; // 0.5-1.0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background dengan gradient dark
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade900,
              Colors.black,
            ],
          ),
        ),
        // SafeArea untuk avoid notch/status bar
        child: SafeArea(
          child: Column(
            children: [
              // === APP BAR CUSTOM ===
              _buildAppBar(),
              
              // === SCROLLABLE CONTENT ===
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // === COLOR PREVIEW ===
                      // ValueListenableBuilder akan rebuild ketika value berubah
                      // Kita listen ke 3 notifier sekaligus dengan nested builder
                      ValueListenableBuilder<double>(
                        valueListenable: _hueNotifier,
                        builder: (context, hue, child) {
                          return ValueListenableBuilder<double>(
                            valueListenable: _saturationNotifier,
                            builder: (context, saturation, child) {
                              return ValueListenableBuilder<double>(
                                valueListenable: _valueNotifier,
                                builder: (context, value, child) {
                                  // Buat HSVColor dari nilai saat ini
                                  final hsvColor = HSVColor.fromAHSV(
                                    1.0, // Alpha (opacity) selalu 1.0
                                    hue,
                                    saturation,
                                    value,
                                  );
                                  
                                  // Convert ke Color untuk preview
                                  final color = ColorHelper.hsvToColor(hsvColor);
                                  
                                  // Get deskripsi warna
                                  final description = ColorHelper.getColorDescription(hsvColor);
                                  
                                  return ColorPreview(
                                    color: color,
                                    colorDescription: description,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // === CONTROLS SECTION ===
                      _buildControlsSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build custom app bar dengan logo dan action buttons
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // === LOGO/ICON ===
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.purple.shade400,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.science_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // === TITLE ===
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ChromaLab',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Color Mixer Laboratory',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          
          // === RESET BUTTON ===
          IconButton(
            onPressed: _resetColors,
            icon: const Icon(Icons.refresh_rounded),
            color: Colors.white.withOpacity(0.7),
            tooltip: 'Reset to default',
            iconSize: 28,
          ),
          
          // === RANDOM BUTTON ===
          IconButton(
            onPressed: _randomizeColors,
            icon: const Icon(Icons.shuffle_rounded),
            color: Colors.white.withOpacity(0.7),
            tooltip: 'Random color',
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  /// Build controls section dengan semua sliders
  Widget _buildControlsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade900,
            Colors.grey.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === SECTION TITLE ===
          Row(
            children: [
              Icon(
                Icons.tune_rounded,
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'COLOR CONTROLS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // === HUE SLIDER ===
          ValueListenableBuilder<double>(
            valueListenable: _hueNotifier,
            builder: (context, hue, child) {
              return ColorSlider(
                label: 'Hue',
                value: hue,
                min: 0,
                max: 360,
                accentColor: HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor(),
                valueFormatter: (v) => '${v.toInt()}°',
                onChanged: (newValue) {
                  // Update ValueNotifier akan trigger rebuild otomatis
                  _hueNotifier.value = newValue;
                },
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // === SATURATION SLIDER ===
          ValueListenableBuilder<double>(
            valueListenable: _saturationNotifier,
            builder: (context, saturation, child) {
              return ValueListenableBuilder<double>(
                valueListenable: _hueNotifier,
                builder: (context, hue, child) {
                  return ColorSlider(
                    label: 'Saturation',
                    value: saturation,
                    min: 0,
                    max: 1,
                    accentColor: HSVColor.fromAHSV(1.0, hue, saturation, 1.0).toColor(),
                    valueFormatter: (v) => '${(v * 100).toInt()}%',
                    onChanged: (newValue) {
                      _saturationNotifier.value = newValue;
                    },
                  );
                },
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // === VALUE/BRIGHTNESS SLIDER ===
          ValueListenableBuilder<double>(
            valueListenable: _valueNotifier,
            builder: (context, value, child) {
              return ValueListenableBuilder<double>(
                valueListenable: _hueNotifier,
                builder: (context, hue, child) {
                  return ValueListenableBuilder<double>(
                    valueListenable: _saturationNotifier,
                    builder: (context, saturation, child) {
                      return ColorSlider(
                        label: 'Brightness',
                        value: value,
                        min: 0,
                        max: 1,
                        accentColor: HSVColor.fromAHSV(1.0, hue, saturation, value).toColor(),
                        valueFormatter: (v) => '${(v * 100).toInt()}%',
                        onChanged: (newValue) {
                          _valueNotifier.value = newValue;
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // === INFO TEXT ===
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Colors.blue.shade300,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Adjust sliders to mix your perfect color. Tap hex code to copy.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}