import 'dart:math';
import 'package:flutter/material.dart';

/// Utility class untuk generate warna random
/// Class ini menggunakan Math.Random untuk membuat warna-warna unik
class ColorGenerator {
  // Instance dari Random class untuk generate angka random
  static final Random _random = Random();

  /// Generate warna random dengan opacity penuh
  /// Returns: Color object dengan RGB random
  static Color generateRandomColor() {
    // Generate nilai Red (0-255)
    // _random.nextInt(256) menghasilkan angka 0 sampai 255
    final int red = _random.nextInt(256);
    
    // Generate nilai Green (0-255)
    final int green = _random.nextInt(256);
    
    // Generate nilai Blue (0-255)
    final int blue = _random.nextInt(256);

    // Return Color dengan RGB values random
    // fromARGB(alpha, red, green, blue)
    // Alpha 255 = opacity 100% (tidak transparan)
    return Color.fromARGB(255, red, green, blue);
  }

  /// Generate warna pastel random (warna lebih soft/lembut)
  /// Warna pastel dibuat dengan mixing warna dengan putih
  static Color generatePastelColor() {
    // Generate base color random
    final int red = _random.nextInt(256);
    final int green = _random.nextInt(256);
    final int blue = _random.nextInt(256);

    // Mix dengan putih (255) untuk mendapat efek pastel
    // Formula: (color + white) / 2
    final int pastelRed = ((red + 255) ~/ 2);
    final int pastelGreen = ((green + 255) ~/ 2);
    final int pastelBlue = ((blue + 255) ~/ 2);

    return Color.fromARGB(255, pastelRed, pastelGreen, pastelBlue);
  }

  /// Generate warna vibrant random (warna lebih cerah dan hidup)
  /// Warna vibrant punya saturation tinggi
  static Color generateVibrantColor() {
    // Pilih satu channel untuk dijadikan dominan (255)
    final int dominantChannel = _random.nextInt(3);
    
    List<int> rgb = [0, 0, 0];
    
    // Set channel dominan ke nilai maksimal
    rgb[dominantChannel] = 255;
    
    // Channel lain diisi dengan nilai random medium-high (128-255)
    for (int i = 0; i < 3; i++) {
      if (i != dominantChannel) {
        rgb[i] = 128 + _random.nextInt(128);
      }
    }

    return Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
  }

  /// Generate gradient colors untuk efek liquid morphism
  /// Returns: List of 2 colors untuk gradient
  static List<Color> generateGradientColors() {
    return [
      generateVibrantColor(),
      generateVibrantColor(),
    ];
  }
}