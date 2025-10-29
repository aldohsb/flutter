import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../widgets/game_canvas.dart';
import '../core/constants/game_constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = GameController();
    _controller.addListener(() {
      setState(() {}); // Rebuild when game state changes
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game Canvas
          Container(
            color: GameConstants.backgroundColor,
            child: Center(
              child: AspectRatio(
                aspectRatio: GameConstants.gameWidth / GameConstants.gameHeight,
                child: _controller.state == GameState.playing ||
                        _controller.state == GameState.paused
                    ? GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _controller.movePlayer(details.delta.dx * 2);
                        },
                        onVerticalDragUpdate: (details) {
                          // Allow vertical swipe too
                          _controller.player.applyForce(0, details.delta.dy * 2);
                        },
                        child: GameCanvas(
                          player: _controller.player,
                          particles: _controller.particles,
                          cameraShake: _controller.getCameraShake(),
                        ),
                      )
                    : GameCanvas(
                        player: _controller.player,
                        particles: _controller.particles,
                      ),.playing ||
                        _controller.state == GameState.paused
                    ? GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _controller.movePlayer(details.delta.dx * 2);
                        },
                        child: GameCanvas(player: _controller.player),
                      )
                    : GameCanvas(player: _controller.player),
              ),
            ),
          ),
          
          // Menu Overlay
          if (_controller.state == GameState.menu)
            _buildMenuOverlay(),
          
          // Paused Overlay
          if (_controller.state == GameState.paused)
            _buildPausedOverlay(),
          
          // Game Over Overlay
          if (_controller.state == GameState.gameOver)
            _buildGameOverOverlay(),
          
          // Pause button (visible during gameplay)
          if (_controller.state == GameState.playing)
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.pause, color: Colors.white, size: 32),
                onPressed: () => _controller.pauseGame(),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMenuOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MaryamFall',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: GameConstants.playerColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tilt device or swipe to move\nAvoid obstacles\nFall deeper!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _controller.startGame(),
              style: ElevatedButton.styleFrom(
                backgroundColor: GameConstants.playerColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'START',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPausedOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PAUSED',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _controller.resumeGame(),
              style: ElevatedButton.styleFrom(
                backgroundColor: GameConstants.playerColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'RESUME',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _controller.resetGame(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'MENU',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildGameOverOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Depth: ${_controller.player.getScore()}',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _controller.resetGame();
                _controller.startGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GameConstants.playerColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'RETRY',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => _controller.resetGame(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 20,
                ),
              ),
              child: const Text(
                'MENU',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}