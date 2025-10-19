import 'package:audioplayers/audioplayers.dart';
import 'storage_service.dart';

class AudioService {
  static final AudioService instance = AudioService._init();
  AudioService._init();

  final AudioPlayer _player = AudioPlayer();
  bool _isInitialized = false;

  Future<void> init() async {
    _isInitialized = true;
  }

  Future<void> playCorrectSound() async {
    if (!_isInitialized) return;
    
    final soundEnabled = await StorageService.instance.isSoundEnabled();
    if (!soundEnabled) return;

    try {
      // Play from assets (you'll need to add sound files)
      await _player.play(AssetSource('sounds/correct.mp3'));
    } catch (e) {
      // Fallback: play system sound or do nothing
      // For demo, we'll use a simple beep frequency
      _playBeep(800, 200); // High pitch for correct
    }
  }

  Future<void> playWrongSound() async {
    if (!_isInitialized) return;
    
    final soundEnabled = await StorageService.instance.isSoundEnabled();
    if (!soundEnabled) return;

    try {
      await _player.play(AssetSource('sounds/wrong.mp3'));
    } catch (e) {
      _playBeep(400, 300); // Low pitch for wrong
    }
  }

  Future<void> playSuccessSound() async {
    if (!_isInitialized) return;
    
    final soundEnabled = await StorageService.instance.isSoundEnabled();
    if (!soundEnabled) return;

    try {
      await _player.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      _playBeep(1000, 500); // Celebration sound
    }
  }

  Future<void> playFailSound() async {
    if (!_isInitialized) return;
    
    final soundEnabled = await StorageService.instance.isSoundEnabled();
    if (!soundEnabled) return;

    try {
      await _player.play(AssetSource('sounds/fail.mp3'));
    } catch (e) {
      _playBeep(300, 600); // Sad sound
    }
  }

  Future<void> playClickSound() async {
    if (!_isInitialized) return;
    
    final soundEnabled = await StorageService.instance.isSoundEnabled();
    if (!soundEnabled) return;

    try {
      await _player.play(AssetSource('sounds/click.mp3'));
    } catch (e) {
      _playBeep(600, 50); // Quick click
    }
  }

  // Simple beep fallback (for demo purposes)
  void _playBeep(int frequency, int duration) {
    // This is a placeholder - in production you'd want actual sound files
    // or use a package that can generate tones
    print('Beep: ${frequency}Hz for ${duration}ms');
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}

// Note: You need to add sound files to assets/sounds/ folder:
// - correct.mp3
// - wrong.mp3
// - success.mp3
// - fail.mp3
// - click.mp3
// 
// Or you can download free sound effects from:
// - https://mixkit.co/free-sound-effects/
// - https://freesound.org/