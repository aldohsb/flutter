import 'package:flutter/material.dart';

String colorToHex(Color color) {
  final value = color.toARGB32() & 0xFFFFFF;
  return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

int channelToInt(double channel) {
  return (channel * 255).round().clamp(0, 255);
}

Color contrastColor(Color background) {
  final luminance = background.computeLuminance();
  return luminance > 0.5 ? Colors.black : Colors.white;
}