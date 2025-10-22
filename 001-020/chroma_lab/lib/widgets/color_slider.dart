import 'package:flutter/material.dart';

/// Widget untuk slider dengan label dan value display
/// Menggunakan Slider.adaptive untuk platform consistency
class ColorSlider extends StatelessWidget {
  // Label slider (contoh: "Hue", "Saturation")
  final String label;
  
  // Nilai saat ini dari slider
  final double value;
  
  // Nilai minimum slider
  final double min;
  
  // Nilai maksimum slider
  final double max;
  
  // Callback ketika nilai berubah
  final ValueChanged<double> onChanged;
  
  // Warna accent untuk slider (optional)
  final Color? accentColor;
  
  // Format display value (optional)
  // Contoh: untuk percentage bisa pakai (v) => '${(v * 100).toInt()}%'
  final String Function(double)? valueFormatter;

  const ColorSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.accentColor,
    this.valueFormatter,
  });

  @override
  Widget build(BuildContext context) {
    // Default formatter: tampilkan sebagai integer
    final formatter = valueFormatter ?? (v) => v.toInt().toString();
    
    return Container(
      // Padding di sekitar slider
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        // Background semi-transparent
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        // Border tipis
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === HEADER: Label dan Value ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label (HUE, SATURATION, dll)
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              
              // Value dalam container
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  // Background dengan accent color atau default
                  color: (accentColor ?? Colors.blue).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  // Border dengan accent color
                  border: Border.all(
                    color: (accentColor ?? Colors.blue).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  formatter(value),
                  style: TextStyle(
                    color: accentColor ?? Colors.blue.shade300,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // === SLIDER ===
          // Slider.adaptive akan otomatis pakai:
          // - Material Slider di Android
          // - Cupertino Slider di iOS
          SliderTheme(
            // Customize theme untuk slider
            data: SliderThemeData(
              // Warna track yang sudah terisi
              activeTrackColor: accentColor ?? Colors.blue.shade400,
              
              // Warna track yang belum terisi
              inactiveTrackColor: Colors.white.withOpacity(0.1),
              
              // Warna thumb (lingkaran slider)
              thumbColor: accentColor ?? Colors.blue.shade300,
              
              // Shape thumb
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12, // Ukuran thumb
                elevation: 4, // Shadow thumb
              ),
              
              // Warna overlay saat di-press
              overlayColor: (accentColor ?? Colors.blue).withOpacity(0.2),
              
              // Shape overlay
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 24,
              ),
              
              // Tinggi track
              trackHeight: 6,
              
              // Shape track (rounded)
              trackShape: const RoundedRectSliderTrackShape(),
              
              // Value indicator (angka yang muncul saat drag)
              valueIndicatorColor: accentColor ?? Colors.blue.shade700,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Slider.adaptive(
              value: value,
              min: min,
              max: max,
              // divisions membuat slider "snap" ke nilai tertentu
              // Untuk range 0-1, gunakan 100 divisions (setiap 1%)
              // Untuk range 0-360, gunakan 360 divisions (setiap 1 derajat)
              divisions: max > 10 ? (max - min).toInt() : 100,
              // Label yang muncul saat drag (di atas thumb)
              label: formatter(value),
              // Callback saat nilai berubah
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}