import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';

class SystemTrayService {
  static final SystemTrayService _instance = SystemTrayService._internal();
  factory SystemTrayService() => _instance;
  SystemTrayService._internal();
  
  final SystemTray _systemTray = SystemTray();
  final AppWindow _appWindow = AppWindow();
  
  bool _initialized = false;
  
  Future<void> initialize({
    required VoidCallback onShowNormal,
    required VoidCallback onShowOverlay,
    required VoidCallback onExit,
  }) async {
    if (_initialized) return;
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;
    
    try {
      // Set icon
      String iconPath = Platform.isWindows
          ? 'assets/icons/tray_icon.ico'
          : 'assets/icons/tray_icon.png';
      
      await _systemTray.initSystemTray(
        title: "ZenTime",
        iconPath: iconPath,
        toolTip: "ZenTime - Time Tracker",
      );
      
      // Create menu
      final Menu menu = Menu();
      await menu.buildFrom([
        MenuItemLabel(
          label: 'Show Normal',
          onClicked: (_) => onShowNormal(),
        ),
        MenuItemLabel(
          label: 'Overlay Mode',
          onClicked: (_) => onShowOverlay(),
        ),
        MenuSeparator(),
        MenuItemLabel(
          label: 'Exit',
          onClicked: (_) => onExit(),
        ),
      ]);
      
      await _systemTray.setContextMenu(menu);
      
      // Register click handler
      _systemTray.registerSystemTrayEventHandler((eventName) {
        if (eventName == kSystemTrayEventClick) {
          onShowNormal();
        } else if (eventName == kSystemTrayEventRightClick) {
          _systemTray.popUpContextMenu();
        }
      });
      
      _initialized = true;
      debugPrint('✅ System tray initialized');
    } catch (e) {
      debugPrint('❌ System tray error: $e');
    }
  }
  
  Future<void> updateTooltip(String tooltip) async {
    if (!_initialized) return;
    try {
      await _systemTray.setToolTip(tooltip);
    } catch (e) {
      debugPrint('Error updating tooltip: $e');
    }
  }
  
  Future<void> showNotification(String title, String message) async {
    if (!_initialized) return;
    try {
      // System tray notification (fallback if flutter_local_notifications fails)
      debugPrint('Tray notification: $title - $message');
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }
  
  void dispose() {
    _systemTray.destroy();
  }
}