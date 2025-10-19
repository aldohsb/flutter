import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../config/app_colors.dart';

/// MemphisBackground - Widget untuk background dengan geometric shapes
/// Memphis design terkenal dengan penggunaan shapes geometric yang bold
/// Widget ini membuat pattern background yang dynamic dan colorful
class MemphisBackground extends StatelessWidget {
  /// Child widget yang akan ditampilkan di atas background
  final Widget child;

  /// Constructor
  const MemphisBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // === BASE BACKGROUND ===
        // Background putih bersih sebagai base
        Container(
          color: AppColors.background,
        ),

        // === GEOMETRIC SHAPES LAYER ===
        // Positioned untuk menempatkan shapes di berbagai posisi
        
        // Shape 1: Circle besar di kiri atas
        Positioned(
          top: -50,
          left: -50,
          child: _buildCircle(
            size: 200,
            color: AppColors.cyan.withOpacity(0.1),
          ),
        ),

        // Shape 2: Triangle di kanan atas
        Positioned(
          top: 100,
          right: 30,
          child: _buildTriangle(
            size: 80,
            color: AppColors.pink.withOpacity(0.1),
          ),
        ),

        // Shape 3: Square rotated di tengah kiri
        Positioned(
          top: 300,
          left: 20,
          child: Transform.rotate(
            angle: math.pi / 4, // Rotasi 45 derajat
            child: _buildSquare(
              size: 60,
              color: AppColors.yellow.withOpacity(0.1),
            ),
          ),
        ),

        // Shape 4: Circle kecil di kanan tengah
        Positioned(
          top: 400,
          right: 50,
          child: _buildCircle(
            size: 100,
            color: AppColors.purple.withOpacity(0.1),
          ),
        ),

        // Shape 5: Triangle terbalik di kiri bawah
        Positioned(
          bottom: 150,
          left: 40,
          child: Transform.rotate(
            angle: math.pi, // Rotasi 180 derajat (terbalik)
            child: _buildTriangle(
              size: 70,
              color: AppColors.mint.withOpacity(0.1),
            ),
          ),
        ),

        // Shape 6: Circle besar di kanan bawah
        Positioned(
          bottom: -80,
          right: -60,
          child: _buildCircle(
            size: 250,
            color: AppColors.orange.withOpacity(0.1),
          ),
        ),

        // Shape 7: Square kecil di tengah atas
        Positioned(
          top: 200,
          right: 150,
          child: Transform.rotate(
            angle: math.pi / 6, // Rotasi 30 derajat
            child: _buildSquare(
              size: 40,
              color: AppColors.coral.withOpacity(0.1),
            ),
          ),
        ),

        // === CHILD CONTENT ===
        // Widget child ditampilkan paling atas
        child,
      ],
    );
  }

  // === SHAPE BUILDERS ===
  // Private methods untuk membuat geometric shapes

  /// Build circle shape
  /// Parameter:
  /// - [size]: Diameter lingkaran
  /// - [color]: Warna lingkaran
  Widget _buildCircle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        // Shape circle menggunakan borderRadius maksimal
        shape: BoxShape.circle,
        color: color,
        // Border untuk outline effect
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }

  /// Build square shape
  /// Parameter:
  /// - [size]: Ukuran sisi square
  /// - [color]: Warna square
  Widget _buildSquare({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        // Rounded corners untuk soft Memphis look
        borderRadius: BorderRadius.circular(8),
        // Border untuk outline
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }

  /// Build triangle shape
  /// Triangle dibuat menggunakan CustomPaint dan Path
  /// Parameter:
  /// - [size]: Ukuran base triangle
  /// - [color]: Warna triangle
  Widget _buildTriangle({
    required double size,
    required Color color,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TrianglePainter(color: color),
    );
  }
}

/// _TrianglePainter - CustomPainter untuk menggambar triangle
/// Private class yang digunakan internal oleh MemphisBackground
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint untuk fill triangle
    final Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Paint untuk border triangle
    final Paint strokePaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Path untuk triangle shape
    // Triangle equilateral (sama sisi)
    final Path path = Path()
      // Start dari top center
      ..moveTo(size.width / 2, 0)
      // Line ke bottom right
      ..lineTo(size.width, size.height)
      // Line ke bottom left
      ..lineTo(0, size.height)
      // Close path kembali ke top center
      ..close();

    // Draw fill
    canvas.drawPath(path, fillPaint);
    
    // Draw border
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Tidak perlu repaint karena static shape
    return false;
  }
}