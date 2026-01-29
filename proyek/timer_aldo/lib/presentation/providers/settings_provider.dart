import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../data/services/storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  final StorageService _storageService;
  
  // Settings
  double _opacity = AppConstants.defaultOpacity;
  bool _alwaysOnTop = true;
  int _idleThresholdSeconds = AppConstants.defaultIdleThresholdSeconds;
  String _pauseHotkey = AppConstants.defaultPauseHotkey;
  String _resetHotkey = AppConstants.defaultResetHotkey;
  double _fontSize = AppConstants.timerFontSizeMedium;
  
  SettingsProvider(this._storageService) {
    _loadSettings();
  }
  
  // Getters
  double get opacity => _opacity;
  bool get alwaysOnTop => _alwaysOnTop;
  int get idleThresholdSeconds => _idleThresholdSeconds;
  String get pauseHotkey => _pauseHotkey;
  String get resetHotkey => _resetHotkey;
  double get fontSize => _fontSize;
  
  // Load settings from storage
  Future<void> _loadSettings() async {
    _opacity = _storageService.getSetting(
      'opacity',
      defaultValue: AppConstants.defaultOpacity,
    );
    _alwaysOnTop = _storageService.getSetting(
      'alwaysOnTop',
      defaultValue: true,
    );
    _idleThresholdSeconds = _storageService.getSetting(
      'idleThresholdSeconds',
      defaultValue: AppConstants.defaultIdleThresholdSeconds,
    );
    _pauseHotkey = _storageService.getSetting(
      'pauseHotkey',
      defaultValue: AppConstants.defaultPauseHotkey,
    );
    _resetHotkey = _storageService.getSetting(
      'resetHotkey',
      defaultValue: AppConstants.defaultResetHotkey,
    );
    _fontSize = _storageService.getSetting(
      'fontSize',
      defaultValue: AppConstants.timerFontSizeMedium,
    );
    
    notifyListeners();
  }
  
  // Set opacity
  Future<void> setOpacity(double value) async {
    _opacity = value.clamp(
      AppConstants.minOpacity,
      AppConstants.maxOpacity,
    );
    await _storageService.saveSetting('opacity', _opacity);
    notifyListeners();
  }
  
  // Set always on top
  Future<void> setAlwaysOnTop(bool value) async {
    _alwaysOnTop = value;
    await _storageService.saveSetting('alwaysOnTop', _alwaysOnTop);
    notifyListeners();
  }
  
  // Set idle threshold
  Future<void> setIdleThreshold(int seconds) async {
    _idleThresholdSeconds = seconds;
    await _storageService.saveSetting('idleThresholdSeconds', _idleThresholdSeconds);
    notifyListeners();
  }
  
  // Set pause hotkey
  Future<void> setPauseHotkey(String hotkey) async {
    _pauseHotkey = hotkey;
    await _storageService.saveSetting('pauseHotkey', _pauseHotkey);
    notifyListeners();
  }
  
  // Set reset hotkey
  Future<void> setResetHotkey(String hotkey) async {
    _resetHotkey = hotkey;
    await _storageService.saveSetting('resetHotkey', _resetHotkey);
    notifyListeners();
  }
  
  // Set font size
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _storageService.saveSetting('fontSize', _fontSize);
    notifyListeners();
  }
  
  // Reset to defaults
  Future<void> resetToDefaults() async {
    _opacity = AppConstants.defaultOpacity;
    _alwaysOnTop = true;
    _idleThresholdSeconds = AppConstants.defaultIdleThresholdSeconds;
    _pauseHotkey = AppConstants.defaultPauseHotkey;
    _resetHotkey = AppConstants.defaultResetHotkey;
    _fontSize = AppConstants.timerFontSizeMedium;
    
    await _storageService.saveSetting('opacity', _opacity);
    await _storageService.saveSetting('alwaysOnTop', _alwaysOnTop);
    await _storageService.saveSetting('idleThresholdSeconds', _idleThresholdSeconds);
    await _storageService.saveSetting('pauseHotkey', _pauseHotkey);
    await _storageService.saveSetting('resetHotkey', _resetHotkey);
    await _storageService.saveSetting('fontSize', _fontSize);
    
    notifyListeners();
  }
}
