import 'package:flutter/material.dart';

/// Model untuk merepresentasikan setiap mood/emosi
/// Class ini menyimpan data emoji dan label untuk setiap mood
class MoodModel {
  // Emoji yang merepresentasikan mood
  final String emoji;
  
  // Label/nama mood (contoh: "Happy", "Sad", dll)
  final String label;
  
  // Warna default untuk mood ini (akan di-override dengan random color)
  final Color defaultColor;

  // Constructor dengan named parameters untuk clarity
  MoodModel({
    required this.emoji,
    required this.label,
    required this.defaultColor,
  });

  /// Static list berisi semua mood yang tersedia
  /// Ini adalah data master yang akan ditampilkan di UI
  static List<MoodModel> getMoods() {
    return [
      MoodModel(
        emoji: '😊',
        label: 'Happy',
        defaultColor: Colors.amber,
      ),
      MoodModel(
        emoji: '😢',
        label: 'Sad',
        defaultColor: Colors.blue,
      ),
      MoodModel(
        emoji: '😡',
        label: 'Angry',
        defaultColor: Colors.red,
      ),
      MoodModel(
        emoji: '😰',
        label: 'Anxious',
        defaultColor: Colors.purple,
      ),
      MoodModel(
        emoji: '😴',
        label: 'Tired',
        defaultColor: Colors.indigo,
      ),
      MoodModel(
        emoji: '🤗',
        label: 'Loved',
        defaultColor: Colors.pink,
      ),
      MoodModel(
        emoji: '🤔',
        label: 'Thoughtful',
        defaultColor: Colors.teal,
      ),
      MoodModel(
        emoji: '😎',
        label: 'Cool',
        defaultColor: Colors.cyan,
      ),
    ];
  }
}