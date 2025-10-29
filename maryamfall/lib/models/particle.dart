import 'dart:math';
import 'package:flutter/material.dart';
import '../core/constants/game_constants.dart';

class Particle {
  double x;
  double y;
  double z;
  double velocityX;
  double velocityY;
  double velocityZ;
  double lifetime; // Current lifetime
  double maxLifetime; // Max lifetime before disappearing
  double size;
  Color color;
  
  Particle({
    required this.x,
    required this.y,
    required this.z,
    this.velocityX = 0,
    this.velocityY = 0,
    this.velocityZ = 0,
    this.maxLifetime = GameConstants.particleLifetime,
    this.size = GameConstants.particleSize,
    required this.color,
  }) : lifetime = 0;
  
  // Update particle
  void update(double dt) {
    lifetime += dt;
    
    // Apply velocity with some random drift
    x += velocityX * dt;
    y += velocityY * dt;
    z += velocityZ * dt;
    
    // Slow down over time
    velocityX *= 0.95;
    velocityY *= 0.95;
    velocityZ *= 0.98;
  }
  
  // Check if particle should be removed
  bool isDead() {
    return lifetime >= maxLifetime;
  }
  
  // Get opacity based on lifetime (fade out)
  double getOpacity() {
    double lifeRatio = lifetime / maxLifetime;
    return (1.0 - lifeRatio).clamp(0.0, 1.0);
  }
  
  // Get scale based on Z depth
  double getScale() {
    double scale = 1.0 - (z / 2000.0);
    return scale.clamp(0.3, 1.0);
  }
  
  // Factory: Create trail particle from player
  factory Particle.trail({
    required double x,
    required double y,
    required double z,
    required Color color,
  }) {
    final random = Random();
    return Particle(
      x: x + (random.nextDouble() - 0.5) * 10,
      y: y + (random.nextDouble() - 0.5) * 10,
      z: z,
      velocityX: (random.nextDouble() - 0.5) * 50,
      velocityY: (random.nextDouble() - 0.5) * 50,
      velocityZ: -50, // Move backwards (relative to player)
      maxLifetime: 0.5 + random.nextDouble() * 0.5,
      size: 2 + random.nextDouble() * 4,
      color: color,
    );
  }
  
  // Factory: Create collision burst particle
  factory Particle.burst({
    required double x,
    required double y,
    required double z,
    required Color color,
  }) {
    final random = Random();
    double angle = random.nextDouble() * 2 * pi;
    double speed = 100 + random.nextDouble() * 200;
    
    return Particle(
      x: x,
      y: y,
      z: z,
      velocityX: cos(angle) * speed,
      velocityY: sin(angle) * speed,
      velocityZ: -100,
      maxLifetime: 0.3 + random.nextDouble() * 0.3,
      size: 3 + random.nextDouble() * 5,
      color: color,
    );
  }
}