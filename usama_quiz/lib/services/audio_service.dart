import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();

  late AudioPlayer _audioPlayer;
  bool _isMuted = false;

  factory AudioService() {
    return _instance;
  }

  AudioService._internal() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> init() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.release);
  }

  // Play correct answer sound
  Future<void> playCorrectSound() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.play(
        AssetSource('audio/correct.mp3'),
        volume: 0.8,
      );
    } catch (e) {
      print('Error playing correct sound: $e');
    }
  }

  // Play wrong answer sound
  Future<void> playWrongSound() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.play(
        AssetSource('audio/wrong.mp3'),
        volume: 0.8,
      );
    } catch (e) {
      print('Error playing wrong sound: $e');
    }
  }

  // Play level complete sound
  Future<void> playLevelCompleteSound() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.play(
        AssetSource('audio/level_complete.mp3'),
        volume: 0.8,
      );
    } catch (e) {
      print('Error playing level complete sound: $e');
    }
  }

  // Play button tap sound
  Future<void> playTapSound() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.play(
        AssetSource('audio/tap.mp3'),
        volume: 0.5,
      );
    } catch (e) {
      print('Error playing tap sound: $e');
    }
  }

  // Toggle mute
  void toggleMute() {
    _isMuted = !_isMuted;
  }

  bool get isMuted => _isMuted;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}