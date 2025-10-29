import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/player.dart';
import '../models/particle.dart';
import '../core/constants/game_constants.dart';

enum GameState {
  menu,
  playing,
  paused,
  gameOver,
}

class GameController extends ChangeNotifier {
  late Player player;
  List<Particle> particles = [];
  GameState state = GameState.menu;
  Timer? _gameLoop;
  DateTime _lastUpdate = DateTime.now();
  StreamSubscription? _accelerometerSubscription;
  double _particleSpawnTimer = 0;
  double _cameraShakeX = 0;
  double _cameraShakeY = 0;
  bool _wasColliding = false;
  
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
    particles.clear();
    
    // Start game loop
    _gameLoop = Timer.periodic(GameConstants.frameDuration, (timer) {
      _update();
    });
    
    // Start accelerometer listening
    _startAccelerometer();
    
    notifyListeners();
  }
  
  // Start listening to accelerometer
  void _startAccelerometer() {
    _accelerometerSubscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        if (state != GameState.playing) return;
        
        // Apply tilt force (x = left/right, y = forward/backward)
        double tiltX = event.x;
        double tiltY = event.y;
        
        // Apply deadzone
        if (tiltX.abs() < GameConstants.tiltDeadzone) tiltX = 0;
        if (tiltY.abs() < GameConstants.tiltDeadzone) tiltY = 0;
        
        // Apply force based on tilt
        player.applyForce(
          -tiltX * GameConstants.tiltSensitivity,
          tiltY * GameConstants.tiltSensitivity,
        );
      },
    );
  }
  
  // Update game state
  void _update() {
    if (state != GameState.playing) return;
    
    DateTime now = DateTime.now();
    double dt = (now.difference(_lastUpdate).inMicroseconds / 1000000.0);
    _lastUpdate = now;
    
    // Update player
    bool isColliding = player.hasCollided();
    player.update(dt);
    
    // Spawn trail particles
    _particleSpawnTimer += dt;
    if (_particleSpawnTimer >= 0.05) { // Spawn every 50ms
      _particleSpawnTimer = 0;
      _spawnTrailParticle();
    }
    
    // Check for new collision (for burst effect)
    if (isColliding && !_wasColliding) {
      _spawnCollisionBurst();
      _applyCameraShake();
    }
    _wasColliding = isColliding;
    
    // Update particles
    particles.removeWhere((p) => p.isDead());
    for (var particle in particles) {
      particle.update(dt);
    }
    
    // Update camera shake
    if (_cameraShakeX != 0 || _cameraShakeY != 0) {
      _cameraShakeX *= 0.9;
      _cameraShakeY *= 0.9;
      if (_cameraShakeX.abs() < 0.1) _cameraShakeX = 0;
      if (_cameraShakeY.abs() < 0.1) _cameraShakeY = 0;
    }
    
    notifyListeners();
  }
  
  // Spawn trail particle behind player
  void _spawnTrailParticle() {
    if (particles.length < GameConstants.maxParticles) {
      particles.add(Particle.trail(
        x: player.x,
        y: player.y,
        z: player.z,
        color: GameConstants.playerColor,
      ));
    }
  }
  
  // Spawn collision burst particles
  void _spawnCollisionBurst() {
    for (int i = 0; i < 8; i++) {
      if (particles.length < GameConstants.maxParticles) {
        particles.add(Particle.burst(
          x: player.x,
          y: player.y,
          z: player.z,
          color: Colors.white,
        ));
      }
    }
  }
  
  // Apply camera shake effect
  void _applyCameraShake() {
    final random = Random();
    _cameraShakeX = (random.nextDouble() - 0.5) * 20;
    _cameraShakeY = (random.nextDouble() - 0.5) * 20;
  }
  
  // Get camera shake offset
  Offset getCameraShake() {
    return Offset(_cameraShakeX, _cameraShakeY);
  }
  
  // Move player horizontally (for swipe input)
  void movePlayer(double dx) {
    if (state != GameState.playing) return;
    
    // Apply force instead of direct movement
    player.applyForce(dx * 10, 0);
    
    notifyListeners();
  }
  
  // Pause game
  void pauseGame() {
    if (state == GameState.playing) {
      state = GameState.paused;
      _gameLoop?.cancel();
      _accelerometerSubscription?.cancel();
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
    _accelerometerSubscription?.cancel();
    _initializeGame();
    particles.clear();
    _cameraShakeX = 0;
    _cameraShakeY = 0;
    _wasColliding = false;
    state = GameState.menu;
    notifyListeners();
  }
  
  @override
  void dispose() {
    _gameLoop?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }
}