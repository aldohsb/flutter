import 'package:flutter/material.dart';

/// Palet warna "Zen Garden Sage" - terinspirasi taman zen Jepang: dedaunan
/// sage yang tenang, pasir/batu krem lembut, dan aksen tanah liat.
abstract final class AppColors {
  // Hijau sage - warna utama identitas aplikasi.
  static const Color sage = Color(0xFF7C9070);
  static const Color sageDark = Color(0xFF56694C);
  static const Color sageDeep = Color(0xFF3C4B35);
  static const Color sageLight = Color(0xFFB9C9AC);
  static const Color sagePale = Color(0xFFE1E8D7);

  // Krem/pasir - latar & permukaan.
  static const Color sandBackground = Color(0xFFF5F1E7);
  static const Color sandSurface = Color(0xFFFCFAF3);
  static const Color stone = Color(0xFFDCD2BC);
  static const Color stoneDark = Color(0xFFB7AA88);

  // Aksen tanah liat - untuk CTA, highlight, sorotan.
  static const Color clay = Color(0xFFC17A54);
  static const Color clayDark = Color(0xFF9C5E3E);

  // Status.
  static const Color success = Color(0xFF5E8B57);
  static const Color error = Color(0xFFC1614F);
  static const Color warning = Color(0xFFD9A441);

  // Teks.
  static const Color ink = Color(0xFF33392E);
  static const Color inkSoft = Color(0xFF5C6553);
  static const Color inkFaint = Color(0xFF8B937E);

  // Bintang.
  static const Color starFilled = Color(0xFFD9A441);
  static const Color starEmpty = Color(0xFFDCD2BC);
}
