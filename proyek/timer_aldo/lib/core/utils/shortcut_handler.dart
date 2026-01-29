// Simplified shortcut handler - hotkey disabled for compatibility
// You can enable shortcuts manually later if needed

class ShortcutHandler {
  Function()? _onPause;
  Function()? _onReset;
  
  Future<void> registerPauseShortcut({
    required String shortcut,
    required Function() onPause,
  }) async {
    _onPause = onPause;
    // Hotkey registration disabled for now
    // Use system tray or right-click menu instead
    print('Pause shortcut registered (disabled): $shortcut');
  }
  
  Future<void> registerResetShortcut({
    required String shortcut,
    required Function() onReset,
  }) async {
    _onReset = onReset;
    // Hotkey registration disabled for now
    // Use system tray or right-click menu instead
    print('Reset shortcut registered (disabled): $shortcut');
  }
  
  Future<void> unregisterAll() async {
    // Nothing to unregister
  }
  
  void dispose() {
    // Nothing to dispose
  }
}