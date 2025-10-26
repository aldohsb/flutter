import 'dart:ui';

class GameConstants {
  // Game dimensions
  static const double gameWidth = 400.0;
  static const double gameHeight = 800.0;
  
  // Player constants
  static const double playerSize = 40.0;
  static const double playerInitialZ = 0.0; // Start at z=0
  static const double playerSpeed = 300.0; // pixels per second
  
  // Physics
  static const double fallSpeed = 200.0; // Z-axis fall speed (into screen)
  static const double maxFallSpeed = 500.0;
  static const double fallAcceleration = 50.0; // Accelerate as we fall deeper
  
  // Colors
  static const Color playerColor = Color(0xFFff6b9d);
  static const Color backgroundColor = Color(0xFF1a1a2e);
  static const Color tunnelColor = Color(0xFF16213e);
  
  // Game settings
  static const int targetFPS = 60;
  static const Duration frameDuration = Duration(milliseconds: 16); // ~60 FPS
}