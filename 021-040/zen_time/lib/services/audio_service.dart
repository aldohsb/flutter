import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();
  
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _hasAudioFile = true;
  
  Future<void> playAlarmSound() async {
    try {
      // Try to play custom bell sound
      if (_hasAudioFile) {
        try {
          await _audioPlayer.play(AssetSource('sounds/bell.mp3'));
          debugPrint('✅ Playing bell.mp3');
        } catch (e) {
          debugPrint('⚠️ bell.mp3 not found, using fallback');
          _hasAudioFile = false;
          await _playFallbackSound();
        }
      } else {
        await _playFallbackSound();
      }
    } catch (e) {
      debugPrint('❌ Error playing alarm sound: $e');
      await _playFallbackSound();
    }
  }
  
  Future<void> _playFallbackSound() async {
    try {
      // Play system notification sound as fallback
      await SystemSound.play(SystemSoundType.alert);
      debugPrint('✅ Playing system alert sound');
    } catch (e) {
      debugPrint('⚠️ System sound failed, using vibration');
      // If all fails, just vibrate
      try {
        await HapticFeedback.heavyImpact();
        debugPrint('✅ Vibration triggered');
      } catch (e2) {
        debugPrint('❌ Vibration also failed: $e2');
      }
    }
  }
  
  Future<void> stopSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping sound: $e');
    }
  }
  
  void dispose() {
    try {
      _audioPlayer.dispose();
    } catch (e) {
      debugPrint('Error disposing audio player: $e');
    }
  }
}

// CATATAN PENTING:
// Jika tidak ada file bell.mp3, app tetap akan jalan dengan:
// 1. System alert sound sebagai fallback
// 2. Vibration jika sound tidak tersedia
// 
// Untuk menambahkan bell.mp3:
// 1. Download dari https://pixabay.com/sound-effects/search/bell/
// 2. Letakkan di assets/sounds/bell.mp3
// 3. Pastikan pubspec.yaml sudah include assets/sounds/