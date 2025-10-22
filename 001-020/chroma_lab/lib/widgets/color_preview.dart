import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_helper.dart';
import 'test_tube_illustration.dart';

/// Widget untuk menampilkan preview warna dengan test tube
/// Menunjukkan warna hasil mixing dalam bentuk visual yang menarik
class ColorPreview extends StatelessWidget {
  // Warna yang akan di-preview
  final Color color;
  
  // Deskripsi warna (contoh: "Vibrant Red")
  final String colorDescription;

  const ColorPreview({
    super.key,
    required this.color,
    required this.colorDescription,
  });

  /// Method untuk copy hex code ke clipboard
  /// Dipanggil ketika user tap pada hex code
  void _copyToClipboard(BuildContext context, String text) {
    // Copy text ke clipboard menggunakan Clipboard API
    Clipboard.setData(ClipboardData(text: text));
    
    // Tampilkan snackbar notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $text to clipboard'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Convert color ke hex untuk display
    final hexCode = ColorHelper.colorToHex(color);
    
    // Tentukan warna text berdasarkan background
    final textColor = ColorHelper.getContrastingTextColor(color);

    return Container(
      // Padding di sekitar preview area
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Gradient background untuk efek lab
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade900,
            Colors.grey.shade800,
          ],
        ),
        // Rounded corners
        borderRadius: BorderRadius.circular(20),
        // Shadow untuk depth
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // === LABEL "COLOR PREVIEW" ===
          Text(
            'COLOR PREVIEW',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 2, // Spacing antar huruf untuk efek modern
            ),
          ),
          
          const SizedBox(height: 20),
          
          // === TEST TUBE ILLUSTRATION ===
          TestTubeIllustration(
            liquidColor: color,
            height: 220,
            width: 90,
          ),
          
          const SizedBox(height: 24),
          
          // === COLOR INFO CARD ===
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              // Background dengan warna yang sedang di-preview
              color: color,
              borderRadius: BorderRadius.circular(15),
              // Border putih tipis
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
              // Shadow untuk elevated effect
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // === NAMA WARNA ===
                Text(
                  colorDescription,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // === DIVIDER ===
                Container(
                  height: 1,
                  width: 60,
                  color: textColor.withOpacity(0.3),
                ),
                
                const SizedBox(height: 8),
                
                // === HEX CODE (Bisa diklik untuk copy) ===
                GestureDetector(
                  // Ketika di-tap, copy hex code
                  onTap: () => _copyToClipboard(context, hexCode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      // Background semi-transparent
                      color: textColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      // Border
                      border: Border.all(
                        color: textColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon copy
                        Icon(
                          Icons.copy_rounded,
                          size: 16,
                          color: textColor.withOpacity(0.7),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Hex code text
                        Text(
                          hexCode,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'monospace', // Font monospace untuk code
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // === HINT TEXT ===
                const SizedBox(height: 8),
                Text(
                  'Tap to copy',
                  style: TextStyle(
                    color: textColor.withOpacity(0.5),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
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