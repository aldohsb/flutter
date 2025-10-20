// File: lib/widgets/ink_bleed_painter.dart
// Penjelasan: Custom Painter untuk menggambar efek tinta yang menyebar (ink bleed)
// CustomPainter adalah way untuk membuat grafis custom di Flutter

import 'package:flutter/material.dart';
import '../utils/theme_utils.dart';

/// Class InkBleedPainter extends CustomPainter untuk membuat custom drawing
/// CustomPainter memerlukan 2 method: paint() dan shouldRepaint()
class InkBleedPainter extends CustomPainter {
  /// Constructor
  InkBleedPainter();

  /// Method paint() adalah tempat kita menggambar custom graphics
  /// canvas: papan tempat kita menggambar
  /// size: ukuran area yang bisa kita gunakan untuk menggambar
  @override
  void paint(Canvas canvas, Size size) {
    // Buat Paint object (seperti "cat dan kuas" untuk menggambar)
    final paint = Paint()
      ..color = AppTheme.inkBleedColor.withOpacity(0.1) // Warna tinta dengan transparansi
      ..strokeWidth = 0 // Tidak ada stroke, hanya fill
      ..style = PaintingStyle.fill; // Isi dengan warna (bukan outline)

    // === EFEK INK BLEED ===
    // Simulasi tinta yang menyebar dengan beberapa lingkaran blur
    // Setiap lingkaran punya opacity berbeda untuk efek natural

    // Lingkaran blur pertama (area terbesar, paling transparan)
    // Ini dibuat dengan oval shape untuk efek organic
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2), // Tengah canvas
        width: size.width * 0.9, // 90% dari lebar
        height: size.height * 0.4, // 40% dari tinggi (elips, bukan lingkaran)
      ),
      paint..color = AppTheme.inkBleedColor.withOpacity(0.08), // Opacity sangat rendah
    );

    // Lingkaran blur kedua (lebih kecil, opacity sedang)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.5),
        width: size.width * 0.7,
        height: size.height * 0.3,
      ),
      paint..color = AppTheme.inkBleedColor.withOpacity(0.12),
    );

    // Lingkaran blur ketiga (paling kecil, opacity lebih terlihat)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.5),
        width: size.width * 0.5,
        height: size.height * 0.25,
      ),
      paint..color = AppTheme.inkBleedColor.withOpacity(0.15),
    );

    // === GARIS AKSENT BRUSH STROKE ===
    // Tambahkan garis vertikal di sisi untuk efek kaligrafi Jepang

    // Garis kiri
    final linePaint = Paint()
      ..color = AppTheme.accentColor.withOpacity(0.05)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Gambar garis vertikal di sisi kiri (efek brush stroke)
    canvas.drawLine(
      Offset(AppTheme.spacingSmall, size.height * 0.1),
      Offset(AppTheme.spacingSmall, size.height * 0.9),
      linePaint,
    );

    // Garis kanan (optional, untuk balance)
    canvas.drawLine(
      Offset(size.width - AppTheme.spacingSmall, size.height * 0.15),
      Offset(size.width - AppTheme.spacingSmall, size.height * 0.85),
      linePaint,
    );
  }

  /// Method shouldRepaint() menentukan kapan painter perlu digambar ulang
  /// Kembalikan true jika properties yang mempengaruhi gambar berubah
  /// Kembalikan false jika sama dengan sebelumnya (untuk optimization)
  @override
  bool shouldRepaint(InkBleedPainter oldDelegate) {
    // InkBleedPainter tidak punya properti yang berubah-ubah
    // Jadi selalu kembalikan false (tidak perlu repaint)
    return false;
  }

  /// Method shouldRebuildSemantics() untuk accessibility
  /// Biasanya kembalikan false jika tidak ada perubahan semantik
  @override
  bool shouldRebuildSemantics(InkBleedPainter oldDelegate) => false;
}