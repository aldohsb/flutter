// ============================================================
// lib/theme/app_colors.dart
// Palet warna utama Moodly – Claymorphism Pastel System
//
// KONSEP: Design Token
// Daripada nulis warna langsung di setiap widget (hardcoded),
// kita simpan semua warna di satu tempat.
// Keuntungan: ganti 1 baris di sini = berubah di seluruh app.
// ============================================================

// 'package:flutter/material.dart' menyediakan kelas Color
import 'package:flutter/material.dart';

// abstract class = tidak bisa di-instansiasi (new AppColors())
// Dipakai murni sebagai "wadah" konstanta statis
abstract class AppColors {
  // ============================================================
  // BACKGROUND COLORS – warna latar halaman & permukaan
  // ============================================================

  // Latar utama seluruh app – krem sangat terang (bukan putih polos)
  static const Color background = Color(0xFFFFF5F7);

  // Latar kartu/surface – putih hangat
  static const Color surface = Color(0xFFFFFFFF);

  // Latar untuk elemen sekunder (misal: input field)
  static const Color surfaceSecondary = Color(0xFFFFF0F3);

  // ============================================================
  // CLAY COLORS – warna utama tombol & elemen 3D clay
  // Setiap warna punya 3 varian: main, shadow, highlight
  // Shadow (gelap) → efek "terangkat dari bawah"
  // Highlight (terang) → efek "terkena cahaya dari atas"
  // ============================================================

  // --- PINK (warna utama/primary) ---
  static const Color pink = Color(0xFFFFB3C6);
  static const Color pinkShadow = Color(0xFFE8758F);      // Lebih gelap
  static const Color pinkHighlight = Color(0xFFFFD6E0);   // Lebih terang

  // --- LAVENDER (secondary) ---
  static const Color lavender = Color(0xFFD4B8E0);
  static const Color lavenderShadow = Color(0xFFAB85C4);
  static const Color lavenderHighlight = Color(0xFFEBD9F5);

  // --- PEACH (accent/hangat) ---
  static const Color peach = Color(0xFFFFCBA4);
  static const Color peachShadow = Color(0xFFE8A06A);
  static const Color peachHighlight = Color(0xFFFFE4C8);

  // --- MINT (aksen dingin/segar) ---
  static const Color mint = Color(0xFFB5EAD7);
  static const Color mintShadow = Color(0xFF7DC4A8);
  static const Color mintHighlight = Color(0xFFD5F5EB);

  // --- BLUE (info/netral) ---
  static const Color skyBlue = Color(0xFFB5D5F0);
  static const Color skyBlueShadow = Color(0xFF7AA8D4);
  static const Color skyBlueHighlight = Color(0xFFD9ECFC);

  // --- YELLOW (ceria) ---
  static const Color lemon = Color(0xFFFFECA3);
  static const Color lemonShadow = Color(0xFFE8C854);
  static const Color lemonHighlight = Color(0xFFFFF6D4);

  // ============================================================
  // TEXT COLORS – warna teks berdasarkan hierarki
  // ============================================================

  // Teks utama – gelap tapi tidak hitam murni (lebih lembut)
  static const Color textPrimary = Color(0xFF4A2C3A);

  // Teks sekunder – lebih terang, untuk label/subtitle
  static const Color textSecondary = Color(0xFF9E7A8A);

  // Teks placeholder – sangat terang, untuk hint
  static const Color textHint = Color(0xFFCEB8C3);

  // Teks di atas clay button (kontras dengan pastel)
  static const Color textOnClay = Color(0xFF4A2C3A);

  // ============================================================
  // MOOD COLORS – warna spesifik per level mood
  // Dipakai di chart dan mood indicator
  // ============================================================

  // Urutan: sangat buruk → buruk → netral → baik → sangat baik
  static const List<Color> moodColors = [
    Color(0xFFFFB3B3), // Skor 1 – coral: sangat sedih
    Color(0xFFFFCBA4), // Skor 2 – peach: sedih
    Color(0xFFFFECA3), // Skor 3 – lemon: netral
    Color(0xFFB5EAD7), // Skor 4 – mint: senang
    Color(0xFFB5D5F0), // Skor 5 – blue: sangat senang
  ];

  // Shadow untuk setiap warna mood (index sama dengan moodColors)
  static const List<Color> moodShadowColors = [
    Color(0xFFE87575),
    Color(0xFFE8A06A),
    Color(0xFFE8C854),
    Color(0xFF7DC4A8),
    Color(0xFF7AA8D4),
  ];

  // ============================================================
  // UTILITY – warna fungsional
  // ============================================================

  // Warna divider/garis pemisah – sangat transparan
  static const Color divider = Color(0x1A4A2C3A);

  // Warna border input field
  static const Color border = Color(0xFFE8C8D0);

  // Warna shadow global untuk kartu
  static const Color cardShadow = Color(0x1AE87590);
}