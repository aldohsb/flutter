import 'package:flutter/material.dart';

enum MoodType { happy, neutral, sad }

class Mood {
  final MoodType type;
  final Color color;
  final String label;

  const Mood({required this.type, required this.color, required this.label});
}

const moods = [
  Mood(type: MoodType.happy, color: Color(0xFFFFD166), label: 'Senang'),
  Mood(type: MoodType.neutral, color: Color(0xFF06D6A0), label: 'Biasa'),
  Mood(type: MoodType.sad, color: Color(0xFFEF476F), label: 'Sedih'),
];
