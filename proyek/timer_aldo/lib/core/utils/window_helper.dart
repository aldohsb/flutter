import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

class WindowHelper {
  static Future<void> setAlwaysOnTop(bool alwaysOnTop) async {
    await windowManager.setAlwaysOnTop(alwaysOnTop);
  }
  
  static Future<void> setOpacity(double opacity) async {
    final clampedOpacity = opacity.clamp(0.0, 1.0);
    await windowManager.setOpacity(clampedOpacity);
  }
  
  static Future<void> setSize(Size size) async {
    await windowManager.setSize(size);
  }
  
  static Future<void> setPosition(Offset position) async {
    await windowManager.setPosition(position);
  }
  
  static Future<void> center() async {
    await windowManager.center();
  }
  
  static Future<void> minimize() async {
    await windowManager.minimize();
  }
  
  static Future<void> restore() async {
    await windowManager.restore();
  }
  
  static Future<void> show() async {
    await windowManager.show();
  }
  
  static Future<void> hide() async {
    await windowManager.hide();
  }
  
  static Future<void> focus() async {
    await windowManager.focus();
  }
  
  static Future<bool> isAlwaysOnTop() async {
    return await windowManager.isAlwaysOnTop();
  }
  
  static Future<bool> isVisible() async {
    return await windowManager.isVisible();
  }
  
  static Future<bool> isMinimized() async {
    return await windowManager.isMinimized();
  }
  
  static Future<Size> getSize() async {
    return await windowManager.getSize();
  }
  
  static Future<Offset> getPosition() async {
    return await windowManager.getPosition();
  }
  
  static Future<void> setSkipTaskbar(bool skip) async {
    await windowManager.setSkipTaskbar(skip);
  }
  
  static Future<void> setTitle(String title) async {
    await windowManager.setTitle(title);
  }
  
  static Future<void> setFullScreen(bool fullScreen) async {
    await windowManager.setFullScreen(fullScreen);
  }
  
  static Future<void> setResizable(bool resizable) async {
    await windowManager.setResizable(resizable);
  }
  
  static Future<void> toggleFullScreen() async {
    final isFullScreen = await windowManager.isFullScreen();
    await windowManager.setFullScreen(!isFullScreen);
  }
}
