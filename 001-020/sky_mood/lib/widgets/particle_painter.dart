// ============================================================================
// FILE: lib/widgets/particle_painter.dart
// FUNGSI: CustomPaint untuk menggambar animasi partikel di background
// ============================================================================
// KONSEP: CustomPaint memungkinkan kita menggambar bentuk custom di canvas
// ============================================================================

import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';

// ============================================================================
// PARTICLE CLASS - Model untuk satu partikel
// ============================================================================
// Setiap partikel adalah object yang memiliki posisi, ukuran, dan animasi
// sendiri. Kita akan membuat banyak partikel untuk efek background yang indah.

class Particle {
  // Posisi awal partikel (x, y)
  late double x;
  late double y;

  // Ukuran partikel (radius)
  late double size;

  // Kecepatan pergerakan partikel
  late double velocityX;  // Kecepatan horizontal
  late double velocityY;  // Kecepatan vertikal

  // Opacity (transparansi) - 0.0 = transparan, 1.0 = opaque
  late double opacity;

  // Maksimal x dan y untuk boundary
  late double maxX;
  late double maxY;

  // Constructor untuk membuat partikel dengan posisi random
  Particle({
    required double maxWidth,
    required double maxHeight,
  }) {
    // Gunakan Random() untuk membuat nilai random
    final random = Random();

    // Set posisi random di seluruh canvas
    x = random.nextDouble() * maxWidth;
    y = random.nextDouble() * maxHeight;

    // Set ukuran random antara min dan max
    size = ParticleSettings.minParticleSize +
        random.nextDouble() *
            (ParticleSettings.maxParticleSize -
                ParticleSettings.minParticleSize);

    // Set kecepatan random (bisa bergerak ke kiri/kanan, atas/bawah)
    // Nilai antara -2 sampai 2
    velocityX = (random.nextDouble() - 0.5) * 2;
    velocityY = (random.nextDouble() - 0.5) * 2;

    // Set opacity awal
    opacity = ParticleSettings.particleInitialAlpha;

    // Set boundary
    maxX = maxWidth;
    maxY = maxHeight;
  }

  // =========================================================================
  // METHOD UPDATE - Update posisi partikel setiap frame
  // =========================================================================
  void update() {
    // Update posisi dengan menambah velocity
    x += velocityX;
    y += velocityY;

    // Buat partikel wrap around (jika keluar kanan, muncul di kiri)
    if (x > maxX) {
      x = 0;
    } else if (x < 0) {
      x = maxX;
    }

    // Buat partikel wrap around vertikal
    if (y > maxY) {
      y = 0;
    } else if (y < 0) {
      y = maxY;
    }

    // Kurangi opacity untuk fade out effect
    opacity -= ParticleSettings.particleSpeed;

    // Jika opacity mencapai 0, reset ke awal
    if (opacity <= 0) {
      opacity = ParticleSettings.particleInitialAlpha;
      // Reset posisi ke atas
      y = -size;
    }
  }
}

// ============================================================================
// PARTICLE PAINTER CLASS - CustomPainter untuk menggambar partikel
// ============================================================================
// Ini adalah class yang digunakan CustomPaint untuk menggambar.
// Setiap frame, Flutter memanggil paint() untuk menggambar ulang.

class ParticlePainter extends CustomPainter {
  // List untuk menyimpan semua partikel
  final List<Particle> particles;

  // Animation value - nilai dari 0 ke 1 yang berubah seiring waktu
  final double animationValue;

  // Constructor
  ParticlePainter({
    required this.particles,
    required this.animationValue,
  });

  // =========================================================================
  // METHOD PAINT - Ini dipanggil setiap frame untuk menggambar
  // =========================================================================
  // Parameter:
  // - canvas: layar untuk menggambar
  // - size: ukuran area yang bisa digambar

  @override
  void paint(Canvas canvas, Size size) {
    // Update semua partikel berdasarkan animationValue
    for (var particle in particles) {
      particle.update();
    }

    // Buat Paint object untuk styling penggambaran
    final paint = Paint()
      // Warna partikel - biru lembut dari theme
      ..color = AppColors.primaryLight.withOpacity(0.3)
      // Style pengisian - fill (solid) atau stroke (garis)
      ..style = PaintingStyle.fill;

    // Gambar setiap partikel sebagai lingkaran (circle)
    for (var particle in particles) {
      // Set opacity untuk fade effect
      paint.color = AppColors.primaryLight.withOpacity(
        particle.opacity * 0.4,  // 0.4 adalah base opacity
      );

      // drawCircle menggambar lingkaran pada canvas
      // Parameter: center (Offset), radius (double), paint (Paint)
      canvas.drawCircle(
        Offset(particle.x, particle.y),  // Posisi pusat lingkaran
        particle.size,                    // Radius
        paint,                            // Styling
      );

      // Gambar glow effect yang lebih besar dan lebih transparan
      paint.color = AppColors.sunny.withOpacity(
        particle.opacity * 0.15,  // Lebih transparan untuk glow
      );

      // Glow adalah lingkaran dengan radius lebih besar
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size * 1.5,  // 1.5x lebih besar
        paint,
      );
    }

    // =====================================================================
    // GRADIENT BACKGROUND - Menambah gradient sebagai background
    // =====================================================================
    // Buat paint untuk gradient
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        // Arah gradient dari atas ke bawah
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // Warna di setiap posisi gradient
        colors: [
          // Warna atas - biru cerah
          AppColors.primaryLight.withOpacity(0.0),
          // Warna bawah - biru lebih gelap
          AppColors.primaryLight.withOpacity(0.15),
        ],
        // Posisi warna di gradient (0.0 = awal, 1.0 = akhir)
        stops: [0.0, 1.0],
      )
          // toShader menerapkan gradient ke ukuran canvas
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Gambar gradient background (opsional, bisa dihapus jika tidak perlu)
    // canvas.drawRect(
    //   Rect.fromLTWH(0, 0, size.width, size.height),
    //   gradientPaint,
    // );
  }

  // =========================================================================
  // METHOD SHOULDREPAINT - Kapan perlu repaint?
  // =========================================================================
  // Return true jika perlu repaint, false jika tidak perlu
  // Ini penting untuk performa - Flutter tidak perlu repaint jika tidak berubah

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    // Repaint jika animationValue berubah
    // animationValue adalah nilai 0-1 yang terus berubah seiring animasi
    return oldDelegate.animationValue != animationValue;
  }

  // =========================================================================
  // TAMBAHAN: shouldRebuild
  // =========================================================================
  // Ini dipanggil jika semantic/struktur berubah
  @override
  bool shouldRebuildSemantics(ParticlePainter oldDelegate) {
    return false;  // Tidak perlu rebuild semantics
  }
}