import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Mengizinkan swipe/drag halaman lewat mouse & trackpad (web/windows)
// selain touch (android)
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}