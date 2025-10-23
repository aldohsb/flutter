import 'dart:async';
import 'package:flutter/material.dart';
import '../models/player.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Player player;
  Timer? gameLoop;
  DateTime lastUpdate = DateTime.now();
  bool isGameRunning = false;

  @override
  void initState() {
    super.initState();
    player = Player();
    _startGame();
  }

  void _startGame() {
    isGameRunning = true;
    lastUpdate = DateTime.now();
    
    // Game loop: 60 FPS
    gameLoop = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isGameRunning) return;
      
      final now = DateTime.now();
      final dt = now.difference(lastUpdate).inMilliseconds / 1000.0;
      lastUpdate = now;

      setState(() {
        player.update(dt);
        
        // Cek collision dengan ground
        final screenHeight = MediaQuery.of(context).size.height;
        final groundY = screenHeight - 100;
        
        if (player.isTouchingGround(groundY)) {
          player.y = groundY - player.size;
          player.velocityY = 0;
        }
      });
    });
  }

  void _handleTap(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tapX = details.localPosition.dx;
    
    setState(() {
      if (tapX < screenWidth / 2) {
        player.moveLeft();
      } else {
        player.moveRight();
      }
    });
  }

  @override
  void dispose() {
    gameLoop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // Sky blue
      body: GestureDetector(
        onTapDown: _handleTap,
        child: Stack(
          children: [
            // Ground
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                color: const Color(0xFF8B4513), // Brown ground
                child: const Center(
                  child: Text(
                    'TAP KIRI/KANAN UNTUK GERAK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            // Player (Maryam)
            Positioned(
              left: player.x * size.width - player.size / 2,
              top: player.y,
              child: Container(
                width: player.size,
                height: player.size,
                decoration: BoxDecoration(
                  color: player.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '👧',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
            
            // Debug Info
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HARI 1: Basic Physics',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Y: ${player.y.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'Velocity: ${player.velocityY.toStringAsFixed(1)}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}