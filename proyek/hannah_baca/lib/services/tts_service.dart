import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;
  bool _idAvailable = true;

  Future<void> _ensureInit() async {
    if (_initialized) return;

    final languages = await _tts.getLanguages;
    _idAvailable = languages is List && languages.contains('id-ID');

    await _tts.setLanguage(_idAvailable ? 'id-ID' : 'en-US');
    await _tts.setSpeechRate(0.4);
    await _tts.setPitch(1.1);
    _initialized = true;
  }

  Future<void> speak(String text) async {
    await _ensureInit();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<bool> isIndonesianAvailable() async {
    await _ensureInit();
    return _idAvailable;
  }
}