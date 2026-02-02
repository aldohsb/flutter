import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class KeyboardShortcutService {
  static final KeyboardShortcutService _instance = KeyboardShortcutService._internal();
  factory KeyboardShortcutService() => _instance;
  KeyboardShortcutService._internal();

  HotKey? _playPauseHotKey;
  HotKey? _stopHotKey;
  bool _isInitialized = false;

  Future<void> initialize({
    required VoidCallback onPlayPause,
    required VoidCallback onStop,
  }) async {
    if (_isInitialized) return;
    
    try {
      // Play/Pause: Ctrl+Alt+Q
      _playPauseHotKey = HotKey(
        key: LogicalKeyboardKey.keyQ,
        modifiers: [HotKeyModifier.control, HotKeyModifier.alt],
        scope: HotKeyScope.system,
      );
      
      await hotKeyManager.register(
        _playPauseHotKey!,
        keyDownHandler: (hotKey) {
          debugPrint('Play/Pause pressed!');
          onPlayPause();
        },
      );

      // Stop: Ctrl+Alt+W
      _stopHotKey = HotKey(
        key: LogicalKeyboardKey.keyW,
        modifiers: [HotKeyModifier.control, HotKeyModifier.alt],
        scope: HotKeyScope.system,
      );
      
      await hotKeyManager.register(
        _stopHotKey!,
        keyDownHandler: (hotKey) {
          debugPrint('Stop pressed!');
          onStop();
        },
      );
      
      _isInitialized = true;
      debugPrint('✓ Shortcuts registered: Ctrl+Alt+Q & Ctrl+Alt+W');
    } catch (e) {
      debugPrint('Error initializing shortcuts: $e');
    }
  }

  Future<void> dispose() async {
    if (!_isInitialized) return;
    
    try {
      if (_playPauseHotKey != null) {
        await hotKeyManager.unregister(_playPauseHotKey!);
      }
      if (_stopHotKey != null) {
        await hotKeyManager.unregister(_stopHotKey!);
      }
      _isInitialized = false;
      debugPrint('Shortcuts unregistered');
    } catch (e) {
      debugPrint('Error disposing shortcuts: $e');
    }
  }

  bool get isSupported => defaultTargetPlatform == TargetPlatform.windows ||
                          defaultTargetPlatform == TargetPlatform.macOS ||
                          defaultTargetPlatform == TargetPlatform.linux;

  bool get isInitialized => _isInitialized;

  Map<String, String> getShortcutsDescription() {
    return {
      'Play/Pause Timer': 'Ctrl+Alt+Q',
      'Stop Timer': 'Ctrl+Alt+W',
    };
  }
}