import 'package:flutter/material.dart';

class Player {
  double x; // Posisi horizontal (0.0 - 1.0, normalized)
  double y; // Posisi vertikal (pixel)
  double velocityY; // Kecepatan jatuh
  double size; // Ukuran karakter
  Color color; // Warna karakter (dummy)

  Player({
    this.x = 0.5, // Mulai di tengah
    this.y = 100.0,
    this.velocityY = 0.0,
    this.size = 40.0,
    this.color = Colors.pink,
  });

  // Update posisi berdasarkan gravitasi
  void update(double dt) {
    const double gravity = 800.0; // Pixel per detik kuadrat
    velocityY += gravity * dt;
    y += velocityY * dt;
  }

  // Pindah ke kiri
  void moveLeft() {
    x -= 0.15;
    if (x < 0.1) x = 0.1; // Batas kiri
  }

  // Pindah ke kanan
  void moveRight() {
    x += 0.15;
    if (x > 0.9) x = 0.9; // Batas kanan
  }

  // Cek apakah menyentuh ground
  bool isTouchingGround(double groundY) {
    return y + size >= groundY;
  }

  // Reset posisi ke atas
  void resetPosition() {
    y = 100.0;
    velocityY = 0.0;
  }
}