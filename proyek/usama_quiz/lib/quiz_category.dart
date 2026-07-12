/// Tiga kategori aksara yang tersedia di Usama Quiz.
enum QuizCategory { hiragana, katakana, kanji }

/// Jumlah level tetap untuk setiap kategori sesuai spesifikasi produk.
const int kLevelsPerCategory = 50;

/// Jumlah soal tetap untuk setiap level.
const int kQuestionsPerLevel = 10;

/// Nilai minimum jawaban benar agar sebuah level dianggap "lulus".
const int kPassThreshold = 7;

extension QuizCategoryX on QuizCategory {
  /// Nama tampilan dalam Bahasa Indonesia.
  String get displayName {
    switch (this) {
      case QuizCategory.hiragana:
        return 'Hiragana';
      case QuizCategory.katakana:
        return 'Katakana';
      case QuizCategory.kanji:
        return 'Kanji';
    }
  }

  /// Deskripsi singkat kategori, ditampilkan di kartu pemilihan kategori.
  String get subtitle {
    switch (this) {
      case QuizCategory.hiragana:
        return 'Aksara dasar untuk kata asli Jepang';
      case QuizCategory.katakana:
        return 'Aksara untuk kata serapan asing';
      case QuizCategory.kanji:
        return 'Aksara kanji dasar JLPT N5-N4';
    }
  }

  /// Contoh karakter representatif untuk kategori, dipakai sebagai ikon teks.
  String get sampleGlyph {
    switch (this) {
      case QuizCategory.hiragana:
        return 'あ';
      case QuizCategory.katakana:
        return 'ア';
      case QuizCategory.kanji:
        return '漢';
    }
  }

  /// Kunci unik yang stabil dipakai untuk penyimpanan lokal.
  String get storageKey {
    switch (this) {
      case QuizCategory.hiragana:
        return 'hiragana';
      case QuizCategory.katakana:
        return 'katakana';
      case QuizCategory.kanji:
        return 'kanji';
    }
  }
}
