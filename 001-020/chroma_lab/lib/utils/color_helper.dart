import 'package:flutter/material.dart';

/// Helper class untuk konversi dan manipulasi warna
/// Memisahkan logika warna dari UI (separation of concerns)
class ColorHelper {
  
  /// Konversi HSVColor ke Color (RGB format)
  /// HSV lebih intuitif untuk mixing, tapi Flutter butuh RGB untuk render
  /// 
  /// Parameter:
  ///   - hsvColor: warna dalam format HSV
  /// Return: Color dalam format RGB
  static Color hsvToColor(HSVColor hsvColor) {
    // Method toColor() sudah disediakan Flutter
    // Ini mengkonversi HSV ke RGB secara otomatis
    return hsvColor.toColor();
  }
  
  /// Konversi Color (RGB) ke HSVColor
  /// Berguna kalau kita mau manipulasi warna yang sudah ada
  /// 
  /// Parameter:
  ///   - color: warna dalam format RGB
  /// Return: HSVColor
  static HSVColor colorToHSV(Color color) {
    // Method fromColor() mengkonversi RGB ke HSV
    return HSVColor.fromColor(color);
  }
  
  /// Konversi warna ke format Hex String (contoh: #FF5733)
  /// Berguna untuk display atau copy-paste ke design tool
  /// 
  /// Parameter:
  ///   - color: warna yang mau dikonversi
  /// Return: String format hex dengan # di depan
  static String colorToHex(Color color) {
    // Ambil nilai red, green, blue (0-255)
    // toRadixString(16) = konversi ke hexadecimal (base 16)
    // padLeft(2, '0') = pastikan 2 digit (contoh: 05 bukan 5)
    return '#${color.red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
  
  /// Cek apakah warna termasuk terang atau gelap
  /// Berguna untuk menentukan warna text (hitam/putih) di atas background
  /// 
  /// Parameter:
  ///   - color: warna yang mau dicek
  /// Return: true jika warna gelap, false jika terang
  static bool isDarkColor(Color color) {
    // Hitung luminance (kecerahan) warna
    // Luminance range: 0.0 (hitam) sampai 1.0 (putih)
    // Threshold 0.5: di bawah ini = gelap, di atas = terang
    return color.computeLuminance() < 0.5;
  }
  
  /// Generate warna text yang kontras dengan background
  /// Auto pilih hitam atau putih supaya mudah dibaca
  /// 
  /// Parameter:
  ///   - backgroundColor: warna background
  /// Return: Color putih atau hitam tergantung background
  static Color getContrastingTextColor(Color backgroundColor) {
    // Kalau background gelap, pakai text putih
    // Kalau background terang, pakai text hitam
    return isDarkColor(backgroundColor) ? Colors.white : Colors.black;
  }
  
  /// Generate nama deskriptif untuk warna
  /// Membantu user memahami warna yang mereka buat
  /// 
  /// Parameter:
  ///   - hsvColor: warna dalam format HSV
  /// Return: String deskripsi warna (contoh: "Vibrant Red")
  static String getColorDescription(HSVColor hsvColor) {
    // Ambil komponen HSV
    final hue = hsvColor.hue;
    final saturation = hsvColor.saturation;
    final value = hsvColor.value;
    
    // Tentukan nama warna dasar berdasarkan hue (0-360 derajat)
    String colorName;
    if (hue >= 0 && hue < 30) {
      colorName = 'Red';
    } else if (hue >= 30 && hue < 60) {
      colorName = 'Orange';
    } else if (hue >= 60 && hue < 90) {
      colorName = 'Yellow';
    } else if (hue >= 90 && hue < 150) {
      colorName = 'Green';
    } else if (hue >= 150 && hue < 210) {
      colorName = 'Cyan';
    } else if (hue >= 210 && hue < 270) {
      colorName = 'Blue';
    } else if (hue >= 270 && hue < 330) {
      colorName = 'Purple';
    } else {
      colorName = 'Red';
    }
    
    // Tambahkan modifier berdasarkan saturation dan value
    String modifier = '';
    
    // Cek value (brightness) dulu
    if (value < 0.3) {
      modifier = 'Dark';
    } else if (value > 0.7 && saturation > 0.6) {
      modifier = 'Vibrant';
    } else if (saturation < 0.3) {
      modifier = 'Pale';
    } else if (saturation < 0.6) {
      modifier = 'Soft';
    }
    
    // Gabungkan modifier dengan nama warna
    return modifier.isEmpty ? colorName : '$modifier $colorName';
  }
}