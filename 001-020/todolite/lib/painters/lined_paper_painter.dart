import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Menggambar garis horizontal ala kertas buku catatan.
class LinedPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.paperLine
      ..strokeWidth = 1;

    const gap = 32.0;
    for (double y = 100; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}