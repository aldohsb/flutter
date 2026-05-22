// lib/data/models/page_model.dart

class SyllableItem {
  final String text;
  final int colorIndex; // indeks ke AppColors.syllableColors

  const SyllableItem({
    required this.text,
    required this.colorIndex,
  });
}

class ReadingPage {
  final int pageNumber;
  final List<SyllableItem> syllables; // 1-3 suku kata per halaman

  const ReadingPage({
    required this.pageNumber,
    required this.syllables,
  });

  /// Jumlah suku kata di halaman ini
  int get syllableCount => syllables.length;

  /// Teks gabungan semua suku kata (untuk preview)
  String get fullText => syllables.map((s) => s.text).join(' ');
}