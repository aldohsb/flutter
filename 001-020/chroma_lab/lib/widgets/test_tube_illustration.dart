import 'package:flutter/material.dart';

/// Widget untuk menggambar ilustrasi test tube (tabung reaksi)
/// Menggunakan CustomPaint untuk gambar custom shape
class TestTubeIllustration extends StatelessWidget {
  // Warna cairan di dalam test tube
  final Color liquidColor;
  
  // Tinggi dari test tube
  final double height;
  
  // Lebar dari test tube
  final double width;
  
  // Constructor dengan parameter wajib dan optional
  const TestTubeIllustration({
    super.key,
    required this.liquidColor,
    this.height = 200,
    this.width = 80,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      // CustomPaint memungkinkan kita menggambar shape custom
      child: CustomPaint(
        // Painter class yang akan melakukan actual drawing
        painter: _TestTubePainter(liquidColor: liquidColor),
      ),
    );
  }
}

/// Custom painter untuk menggambar test tube
/// Extends CustomPainter untuk akses ke canvas drawing API
class _TestTubePainter extends CustomPainter {
  final Color liquidColor;

  _TestTubePainter({required this.liquidColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object untuk menentukan warna dan style
    final glassPaint = Paint()
      ..color = Colors.white.withOpacity(0.3) // Efek kaca transparan
      ..style = PaintingStyle.fill; // Fill shape dengan warna
    
    // Paint untuk outline (garis tepi)
    final outlinePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke // Hanya gambar garis tepi
      ..strokeWidth = 3; // Ketebalan garis
    
    // Paint untuk cairan di dalam tube
    final liquidPaint = Paint()
      ..color = liquidColor
      ..style = PaintingStyle.fill;
    
    // Paint untuk efek glossy/mengkilap
    final glossPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // === GAMBAR BODY TEST TUBE ===
    
    // Path untuk bentuk tabung utama (persegi panjang rounded)
    final tubePath = Path();
    
    // Lebar body tube (80% dari total width untuk kasih space)
    final tubeWidth = size.width * 0.8;
    // X position untuk center tube
    final tubeLeft = (size.width - tubeWidth) / 2;
    
    // Tinggi body tube (70% dari total, sisanya untuk neck)
    final tubeHeight = size.height * 0.7;
    final tubeTop = size.height * 0.3; // Mulai setelah neck
    
    // Gambar rounded rectangle untuk body
    tubePath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(tubeLeft, tubeTop, tubeWidth, tubeHeight),
        const Radius.circular(15), // Corner radius
      ),
    );
    
    // Gambar glass body
    canvas.drawPath(tubePath, glassPaint);
    
    // === GAMBAR NECK TEST TUBE (bagian atas yang lebih kecil) ===
    
    final neckWidth = size.width * 0.4;
    final neckLeft = (size.width - neckWidth) / 2;
    final neckHeight = size.height * 0.3;
    
    final neckPath = Path();
    neckPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(neckLeft, 0, neckWidth, neckHeight),
        const Radius.circular(8),
      ),
    );
    
    canvas.drawPath(neckPath, glassPaint);
    
    // === GAMBAR CAIRAN DI DALAM ===
    
    // Liquid fill 60% dari tube body
    final liquidHeight = tubeHeight * 0.6;
    final liquidTop = tubeTop + (tubeHeight - liquidHeight);
    
    final liquidPath = Path();
    
    // Gambar permukaan cairan yang melengkung (seperti meniskus)
    liquidPath.moveTo(tubeLeft, liquidTop + 10);
    
    // Curve di atas (permukaan cairan)
    liquidPath.quadraticBezierTo(
      tubeLeft + tubeWidth / 2, // Control point X (tengah)
      liquidTop, // Control point Y (atas)
      tubeLeft + tubeWidth, // End point X
      liquidTop + 10, // End point Y
    );
    
    // Line ke kanan bawah
    liquidPath.lineTo(tubeLeft + tubeWidth, tubeTop + tubeHeight);
    
    // Bottom curve
    liquidPath.lineTo(tubeLeft, tubeTop + tubeHeight);
    
    // Close path
    liquidPath.close();
    
    // Gambar cairan
    canvas.drawPath(liquidPath, liquidPaint);
    
    // === EFEK GLOSSY ===
    
    // Oval glossy di kiri atas untuk efek cahaya/kilap
    final glossRect = Rect.fromLTWH(
      tubeLeft + 10,
      tubeTop + 20,
      tubeWidth * 0.3,
      40,
    );
    
    canvas.drawOval(glossRect, glossPaint);
    
    // === GAMBAR OUTLINE TERAKHIR ===
    
    // Outline untuk body
    canvas.drawPath(tubePath, outlinePaint);
    
    // Outline untuk neck
    canvas.drawPath(neckPath, outlinePaint);
    
    // === GAMBAR CAP/TUTUP TUBE ===
    
    final capHeight = 8.0;
    final capRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        neckLeft - 5,
        -capHeight,
        neckWidth + 10,
        capHeight,
      ),
      const Radius.circular(4),
    );
    
    final capPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(capRect, capPaint);
    canvas.drawRRect(capRect, outlinePaint);
  }

  @override
  bool shouldRepaint(_TestTubePainter oldDelegate) {
    // Repaint kalau warna liquid berubah
    return oldDelegate.liquidColor != liquidColor;
  }
}