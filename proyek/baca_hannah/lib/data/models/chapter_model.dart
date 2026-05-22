// lib/data/models/chapter_model.dart

import 'page_model.dart';

class ChapterModel {
  final int id;           // 1-based
  final String title;    // "Bab 1"
  final String theme;    // "ba - ca"
  final String emoji;    // emoji representasi
  final List<ReadingPage> pages;

  const ChapterModel({
    required this.id,
    required this.title,
    required this.theme,
    required this.emoji,
    required this.pages,
  });

  int get totalPages => pages.length;
  int get index => id - 1; // 0-based index
}