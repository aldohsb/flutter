import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../core/constants/game_constants.dart';

class GameCanvas extends StatelessWidget {
  final Player player;
  final List<Particle> particles;
  final Offset cameraShake;
  
  const GameCanvas({
    super.key,
    required this.player,
    required this.particles,
    this.cameraShake = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GamePainter(
        player: player,
        particles: particles,
        cameraShake: cameraShake,
      ),
      size: Size.infinite,
    );
  }
}

class GamePainter extends CustomPainter {
  final Player player;
  final List<Particle> particles;
  final Offset cameraShake;
  
  GamePainter({
    required this.player,
    required this.particles,
    required this.cameraShake,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Apply camera shake
    canvas.save();
    canvas.translate(cameraShake.dx, cameraShake.dy);
    
    // Draw tunnel effect (perspective lines)
    _drawTunnel(canvas, size);
    
    // Draw particles (behind player)
    _drawParticles(canvas, size);
    
    // Draw player with perspective scaling
    _drawPlayer(canvas, size);
    
    // Draw score
    _drawScore(canvas, size);
    
    // Draw velocity indicator
    _drawVelocityIndicator(canvas, size);
    
    canvas.restore();
  }
  
  void _drawTunnel(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = GameConstants.tunnelColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    // Draw perspective grid lines
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    
    // Calculate vanishing point based on z depth
    double vanishingScale = 0.5 - (player.z / 4000.0).clamp(0.0, 0.4);
    
    // Draw multiple rectangles getting smaller (perspective effect)
    for (int i = 0; i < 5; i++) {
      double scale = 1.0 - (i * 0.15) - vanishingScale;
      if (scale <= 0.1) continue;
      
      double rectWidth = size.width * scale;
      double rectHeight = size.height * scale;
      
      Rect rect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: rectWidth,
        height: rectHeight,
      );
      
      paint.color = GameConstants.tunnelColor.withOpacity(0.3 + (i * 0.1));
      canvas.drawRect(rect, paint);
    }
    
    // Draw corner lines (tunnel depth lines)
    paint.color = GameConstants.tunnelColor.withOpacity(0.5);
    paint.strokeWidth = 1.5;
    
    double cornerOffset = size.width * vanishingScale * 0.5;
    
    // Top-left to center
    canvas.drawLine(
      const Offset(0, 0),
      Offset(centerX - cornerOffset, centerY - cornerOffset),
      paint,
    );
    
    // Top-right to center
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(centerX + cornerOffset, centerY - cornerOffset),
      paint,
    );
    
    // Bottom-left to center
    canvas.drawLine(
      Offset(0, size.height),
      Offset(centerX - cornerOffset, centerY + cornerOffset),
      paint,
    );
    
    // Bottom-right to center
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(centerX + cornerOffset, centerY + cornerOffset),
      paint,
    );
  }
  
  void _drawPlayer(Canvas canvas, Size size) {
    double scale = player.getScale();
    double scaledSize = player.size * scale;
    
    final paint = Paint()
      ..color = player.color
      ..style = PaintingStyle.fill;
    
    // Draw shadow (depth effect)
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3 * scale)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    
    canvas.drawCircle(
      Offset(player.x + 5, player.y + 5),
      scaledSize / 2,
      shadowPaint,
    );
    
    // Draw player circle
    canvas.drawCircle(
      Offset(player.x, player.y),
      scaledSize / 2,
      paint,
    );
    
    // Draw highlight (make it look 3D)
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(player.x - scaledSize * 0.15, player.y - scaledSize * 0.15),
      scaledSize / 4,
      highlightPaint,
    );
  }
  
  void _drawScore(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Depth: ${player.getScore()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(canvas, const Offset(20, 50));
  }
  
  void _drawParticles(Canvas canvas, Size size) {
    for (var particle in particles) {
      double scale = particle.getScale();
      double opacity = particle.getOpacity();
      double scaledSize = particle.size * scale;
      
      final paint = Paint()
        ..color = particle.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        scaledSize / 2,
        paint,
      );
    }
  }
  
  void _drawVelocityIndicator(Canvas canvas, Size size) {
    // Draw velocity vector (for debugging/feedback)
    double velocityMagnitude = (player.velocityX.abs() + player.velocityY.abs()) / 2;
    double barWidth = (velocityMagnitude / GameConstants.maxVelocityX) * 100;
    barWidth = barWidth.clamp(0, 100);
    
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    final fgPaint = Paint()
      ..color = GameConstants.playerColor
      ..style = PaintingStyle.fill;
    
    // Background bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 90, 100, 8),
        const Radius.circular(4),
      ),
      bgPaint,
    );
    
    // Foreground bar (velocity)
    if (barWidth > 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(20, 90, barWidth, 8),
          const Radius.circular(4),
        ),
        fgPaint,
      );
    }
    
    // Label
    final labelPainter = TextPainter(
      text: const TextSpan(
        text: 'Speed',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    labelPainter.layout();
    labelPainter.paint(canvas, const Offset(20, 105));
  }
  
  @override
  bool shouldRepaint(GamePainter oldDelegate) {
    return true; // Always repaint for smooth animation
  }
}