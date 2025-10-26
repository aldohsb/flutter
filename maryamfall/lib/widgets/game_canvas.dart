import 'package:flutter/material.dart';
import '../models/player.dart';
import '../core/constants/game_constants.dart';

class GameCanvas extends StatelessWidget {
  final Player player;
  
  const GameCanvas({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GamePainter(player: player),
      size: Size.infinite,
    );
  }
}

class GamePainter extends CustomPainter {
  final Player player;
  
  GamePainter({required this.player});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Draw tunnel effect (perspective lines)
    _drawTunnel(canvas, size);
    
    // Draw player with perspective scaling
    _drawPlayer(canvas, size);
    
    // Draw score
    _drawScore(canvas, size);
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
  
  @override
  bool shouldRepaint(GamePainter oldDelegate) {
    return true; // Always repaint for smooth animation
  }
}