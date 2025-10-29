import 'package:flutter/material.dart';
import '../core/constants/game_constants.dart';

class Player {
  double x; // Horizontal position
  double y; // Vertical position
  double z; // Depth position (falling into screen)
  double velocityX; // Horizontal velocity
  double velocityY; // Vertical velocity
  double velocityZ; // Speed of falling
  double size;
  Color color;
  
  Player({
    required this.x,
    required this.y,
    this.z = GameConstants.playerInitialZ,
    this.velocityX = 0,
    this.velocityY = 0,
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
    
    // Apply air resistance to horizontal movement
    velocityX *= GameConstants.airResistance;
    velocityY *= GameConstants.airResistance;
    
    // Update positions
    x += velocityX * dt;
    y += velocityY * dt;
    z += velocityZ * dt;
    
    // Check boundaries and bounce
    _checkBoundaries();
  }
  
  // Apply force from tilt/swipe
  void applyForce(double forceX, double forceY) {
    velocityX += forceX;
    velocityY += forceY;
    
    // Clamp velocity
    velocityX = velocityX.clamp(-GameConstants.maxVelocityX, GameConstants.maxVelocityX);
    velocityY = velocityY.clamp(-GameConstants.maxVelocityX, GameConstants.maxVelocityX);
  }
  
  // Check and handle boundary collisions
  void _checkBoundaries() {
    double halfSize = size / 2;
    bool collided = false;
    
    // Left boundary
    if (x - halfSize < 0) {
      x = halfSize;
      velocityX = -velocityX * GameConstants.bounceMultiplier;
      collided = true;
    }
    
    // Right boundary
    if (x + halfSize > GameConstants.gameWidth) {
      x = GameConstants.gameWidth - halfSize;
      velocityX = -velocityX * GameConstants.bounceMultiplier;
      collided = true;
    }
    
    // Top boundary
    if (y - halfSize < 0) {
      y = halfSize;
      velocityY = -velocityY * GameConstants.bounceMultiplier;
      collided = true;
    }
    
    // Bottom boundary
    if (y + halfSize > GameConstants.gameHeight) {
      y = GameConstants.gameHeight - halfSize;
      velocityY = -velocityY * GameConstants.bounceMultiplier;
      collided = true;
    }
  }
  
  // Check if player collided with boundary (for effects)
  bool hasCollided() {
    double halfSize = size / 2;
    return x - halfSize <= 0 || 
           x + halfSize >= GameConstants.gameWidth ||
           y - halfSize <= 0 || 
           y + halfSize >= GameConstants.gameHeight;
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
    velocityX = 0;
    velocityY = 0;
    velocityZ = GameConstants.fallSpeed;
  }
}