// ============================================================
// lib/utils/mood_constants.dart
// Konstanta dan konfigurasi terkait mood
//
// KONSEP: Separation of Concerns
// File ini memisahkan "konfigurasi" dari "logika bisnis".
// Semua data statis yang berhubungan dengan mood ada di sini,
// bukan tersebar di berbagai widget.
// ============================================================

import 'package:flutter/material.dart';
import '../models/mood_entry.dart'; // Import model yang baru kita buat

// ============================================================
// CLASS MoodConfig – konfigurasi satu item mood
// Digunakan oleh EmojiPicker untuk menampilkan pilihan mood
// ============================================================
class MoodConfig {
  // final karena konfigurasi ini tidak berubah
  final MoodEmoji mood;       // Referensi ke enum MoodEmoji
  final Color color;          // Warna clay tombol emoji ini
  final Color shadowColor;    // Warna shadow clay-nya
  final String description;   // Deskripsi singkat untuk aksesibilitas

  // Constructor biasa (bukan factory) – semua field wajib
  const MoodConfig({
    required this.mood,
    required this.color,
    required this.shadowColor,
    required this.description,
  });

  // Shortcut getter langsung ke properti MoodEmoji
  String get emoji => mood.emoji;
  String get label => mood.label;
  int get score => mood.score;
}

// ============================================================
// CLASS MoodConstants – kumpulan konstanta statis
// Semua diakses via: MoodConstants.allMoods, MoodConstants.maxNote, dll
// ============================================================
abstract class MoodConstants {

  // ============================================================
  // LIST KONFIGURASI SEMUA MOOD
  // Urutan: 1 (paling buruk) → 5 (paling baik)
  // Warna diambil dari AppColors.moodColors sesuai index enum
  // ============================================================
  static const List<MoodConfig> allMoods = [
    MoodConfig(
      mood: MoodEmoji.verySad,
      // Index 0 = AppColors.moodColors[0] = coral
      color: Color(0xFFFFB3B3),
      shadowColor: Color(0xFFE87575),
      description: 'Hari ini terasa sangat berat',
    ),
    MoodConfig(
      mood: MoodEmoji.sad,
      // Index 1 = peach
      color: Color(0xFFFFCBA4),
      shadowColor: Color(0xFFE8A06A),
      description: 'Tidak terlalu menyenangkan',
    ),
    MoodConfig(
      mood: MoodEmoji.neutral,
      // Index 2 = lemon
      color: Color(0xFFFFECA3),
      shadowColor: Color(0xFFE8C854),
      description: 'Biasa saja, tidak istimewa',
    ),
    MoodConfig(
      mood: MoodEmoji.happy,
      // Index 3 = mint
      color: Color(0xFFB5EAD7),
      shadowColor: Color(0xFF7DC4A8),
      description: 'Hari yang cukup menyenangkan',
    ),
    MoodConfig(
      mood: MoodEmoji.veryHappy,
      // Index 4 = sky blue
      color: Color(0xFFB5D5F0),
      shadowColor: Color(0xFF7AA8D4),
      description: 'Hari yang luar biasa!',
    ),
  ];

  // ============================================================
  // BATAS KARAKTER CATATAN
  // User tidak bisa menulis catatan lebih dari ini
  // ============================================================
  static const int maxNoteLength = 300;

  // ============================================================
  // RENTANG DATA CHART
  // Berapa hari ke belakang yang ditampilkan di grafik
  // ============================================================
  static const int chartDaysRange = 7;

  // ============================================================
  // LABEL HARI (dipakai di sumbu X chart)
  // List pendek nama hari untuk tampilan compact
  // ============================================================
  static const List<String> shortDayNames = [
    'Sen', // Senin
    'Sel', // Selasa
    'Rab', // Rabu
    'Kam', // Kamis
    'Jum', // Jumat
    'Sab', // Sabtu
    'Min', // Minggu
  ];

  // ============================================================
  // LABEL BULAN (dipakai di header history)
  // ============================================================
  static const List<String> monthNames = [
    'Januari', 'Februari', 'Maret', 'April',
    'Mei', 'Juni', 'Juli', 'Agustus',
    'September', 'Oktober', 'November', 'Desember',
  ];

  // ============================================================
  // PESAN MOTIVASI – ditampilkan di HomeScreen berdasarkan mood
  // Map<MoodEmoji, String> = pasangan key-value
  // ============================================================
  static const Map<MoodEmoji, String> motivationalMessages = {
    MoodEmoji.verySad:
        'Hari berat pun akan berlalu. Kamu sudah cukup kuat. 💙',
    MoodEmoji.sad:
        'Tidak apa-apa merasa sedih. Besok pasti lebih baik. 🌤️',
    MoodEmoji.neutral:
        'Hari biasa juga bermakna. Syukuri hal kecil! ✨',
    MoodEmoji.happy:
        'Senang mendengarnya! Teruskan energi positifmu. 🌸',
    MoodEmoji.veryHappy:
        'Luar biasa! Simpan momen bahagia ini di hatimu. 🥰',
  };

  // ============================================================
  // HELPER METHOD: getMoodConfig()
  // Mengambil MoodConfig berdasarkan MoodEmoji
  // Berguna saat kita punya MoodEmoji tapi butuh warna/shadownya
  // ============================================================
  static MoodConfig getMoodConfig(MoodEmoji mood) {
    // .firstWhere = cari element pertama yang memenuhi kondisi
    return allMoods.firstWhere((config) => config.mood == mood);
  }

  // ============================================================
  // HELPER METHOD: getAverageMoodLabel()
  // Mengubah rata-rata skor float menjadi label teks
  // Dipakai di ringkasan statistik
  // ============================================================
  static String getAverageMoodLabel(double average) {
    if (average < 1.5) return MoodEmoji.verySad.label;
    if (average < 2.5) return MoodEmoji.sad.label;
    if (average < 3.5) return MoodEmoji.neutral.label;
    if (average < 4.5) return MoodEmoji.happy.label;
    return MoodEmoji.veryHappy.label;
  }

  // ============================================================
  // HELPER METHOD: getAverageMoodEmoji()
  // Sama tapi mengembalikan emoji (untuk preview kecil)
  // ============================================================
  static String getAverageMoodEmoji(double average) {
    if (average < 1.5) return MoodEmoji.verySad.emoji;
    if (average < 2.5) return MoodEmoji.sad.emoji;
    if (average < 3.5) return MoodEmoji.neutral.emoji;
    if (average < 4.5) return MoodEmoji.happy.emoji;
    return MoodEmoji.veryHappy.emoji;
  }
}