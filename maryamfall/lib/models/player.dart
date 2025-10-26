import 'package:flutter/material.dart';
import '../core/constants/game_constants.dart';

class Player {
  double x; // Horizontal position
  double y; // Vertical position
  double z; // Depth position (falling into screen)
  double velocityZ; // Speed of falling
  double size;
  Color color;
  
  Player({
    required this.x,
    required this.y,
    this.z = GameConstants.playerInitialZ,
    this.velocityZ = GameConstants.fallSpeed,
    this.size = GameConstants.playerSize,
    this.color = GameConstants.playerColor,
  });
  
  // Update player position based on time delta
  void update(double dt) {
    // Accelerate falling speed
    velocityZ += GameConstants.fallAcceleration * dt;
    if (velocityZ > GameConstants.maxFallSpeed) {
      velocityZ = GameConstants.maxFallSpeed;
    }
    
    // Move deeper into the screen
    z += velocityZ * dt;
  }
  
  // Get visual scale based on Z depth (perspective effect)
  double getScale() {
    // As z increases (falling deeper), object appears smaller
    // Scale from 1.0 (z=0) to 0.3 (z=1000)
    double scale = 1.0 - (z / 2000.0);
    return scale.clamp(0.3, 1.0);
  }
  
  // Get current score (distance fallen)
  int getScore() {
    return z.toInt();
  }
  
  // Reset player to initial state
  void reset() {
    z = GameConstants.playerInitialZ;
    velocityZ = GameConstants.fallSpeed;
  }
}