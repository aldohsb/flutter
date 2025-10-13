import 'package:flutter/material.dart';

/// Widget untuk blob shape mengambang di background
/// Ini adalah StatelessWidget karena tidak perlu manage state
class FloatingBlob extends StatelessWidget {
  // Properties untuk customisasi blob
  final double size; // Ukuran blob
  final Color color; // Warna blob
  final double top; // Posisi dari atas
  final double left; // Posisi dari kiri
  final double right; // Posisi dari kanan
  final double bottom; // Posisi dari bawah

  // Constructor dengan named parameters
  const FloatingBlob({
    super.key,
    required this.size,
    required this.color,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // Positioning blob di layar
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      
      child: Container(
        // Ukuran blob
        width: size,
        height: size,
        
        // Decoration untuk liquid morphism effect
        decoration: BoxDecoration(
          // Gradient untuk efek liquid yang lebih hidup
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.3), // Warna di tengah (lebih transparan)
              color.withOpacity(0.1), // Warna di pinggir (sangat transparan)
            ],
            // Gradient dimulai dari tengah dan menyebar ke pinggir
            stops: const [0.0, 1.0],
          ),
          
          // Border radius ekstrem untuk blob shape
          // BorderRadius.circular(size / 2) membuat perfect circle
          // Tapi kita pakai lebih dari itu untuk organic blob effect
          borderRadius: BorderRadius.circular(size * 0.6),
          
          // Box shadow untuk depth dan floating effect
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 60, // Blur tinggi untuk soft shadow
              spreadRadius: 10, // Shadow menyebar
              offset: const Offset(0, 10), // Shadow sedikit ke bawah
            ),
          ],
        ),
      ),
    );
  }
}