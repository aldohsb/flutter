import 'dart:async';
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../core/constants/game_constants.dart';

enum GameState {
  menu,
  playing,
  paused,
  gameOver,
}

class GameController extends ChangeNotifier {
  late Player player;
  GameState state = GameState.menu;
  Timer? _gameLoop;
  DateTime _lastUpdate = DateTime.now();
  
  GameController() {
    _initializeGame();
  }
  
  void _initializeGame() {
    // Initialize player at center of screen
    player = Player(
      x: GameConstants.gameWidth / 2,
      y: GameConstants.gameHeight / 2,
    );
  }
  
  // Start game
  void startGame() {
    state = GameState.playing;
    _lastUpdate = DateTime.now();
    
    // Start game loop
    _gameLoop = Timer.periodic(GameConstants.frameDuration, (timer) {
      _update();
    });
    
    notifyListeners();
  }
  
  // Update game state
  void _update() {
    if (state != GameState.playing) return;
    
    DateTime now = DateTime.now();
    double dt = (now.difference(_lastUpdate).inMicroseconds / 1000000.0);
    _lastUpdate = now;
    
    // Update player
    player.update(dt);
    
    notifyListeners();
  }
  
  // Move player horizontally
  void movePlayer(double dx) {
    if (state != GameState.playing) return;
    
    player.x += dx;
    
    // Keep player within bounds
    double halfSize = player.size / 2;
    player.x = player.x.clamp(halfSize, GameConstants.gameWidth - halfSize);
    
    notifyListeners();
  }
  
  // Pause game
  void pauseGame() {
    if (state == GameState.playing) {
      state = GameState.paused;
      _gameLoop?.cancel();
      notifyListeners();
    }
  }
  
  // Resume game
  void resumeGame() {
    if (state == GameState.paused) {
      startGame();
    }
  }
  
  // Game over
  void gameOver() {
    state = GameState.gameOver;
    _gameLoop?.cancel();
    notifyListeners();
  }
  
  // Reset game
  void resetGame() {
    _gameLoop?.cancel();
    _initializeGame();
    state = GameState.menu;
    notifyListeners();
  }
  
  @override
  void dispose() {
    _gameLoop?.cancel();
    super.dispose();
  }
}