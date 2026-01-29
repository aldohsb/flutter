import 'package:flutter/material.dart';
import 'package:zentime/services/hive_service.dart';

class OverlayProvider extends ChangeNotifier {
  bool _isOverlayMode = false;
  bool _isClickThrough = false;
  
  bool get isOverlayMode => _isOverlayMode;
  bool get isClickThrough => _isClickThrough;
  
  OverlayProvider() {
    _loadOverlayMode();
  }
  
  void _loadOverlayMode() {
    _isOverlayMode = HiveService.getSetting('overlay_mode', defaultValue: false);
    _isClickThrough = HiveService.getSetting('click_through', defaultValue: false);
  }
  
  Future<void> toggleOverlayMode() async {
    _isOverlayMode = !_isOverlayMode;
    await HiveService.saveSetting('overlay_mode', _isOverlayMode);
    notifyListeners();
  }
  
  Future<void> setOverlayMode(bool value) async {
    _isOverlayMode = value;
    await HiveService.saveSetting('overlay_mode', _isOverlayMode);
    notifyListeners();
  }
  
  Future<void> toggleClickThrough() async {
    _isClickThrough = !_isClickThrough;
    await HiveService.saveSetting('click_through', _isClickThrough);
    notifyListeners();
  }
  
  Future<void> setClickThrough(bool value) async {
    _isClickThrough = value;
    await HiveService.saveSetting('click_through', _isClickThrough);
    notifyListeners();
  }
}