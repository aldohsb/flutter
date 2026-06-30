// lib/core/utils/validators.dart
// ─────────────────────────────────────────────────────────
// Memisahkan logic validasi dari UI.
// Keuntungan: bisa dipakai ulang di form lain, mudah di-test.
// ─────────────────────────────────────────────────────────

abstract final class Validators {
  // Konstanta batas panjang nama
  static const int nameMinLength = 2;
  static const int nameMaxLength = 20;
  // Konstanta di sini agar nilai yang sama tidak tersebar di banyak file

  // ── Validator untuk nama pengguna ─────────────────────
  static String? validateName(String? value) {
    // String? (nullable): bisa berisi String atau null
    // Return null = valid; return String = pesan error

    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
      // Cek null terlebih dahulu (Dart null safety)
      // trim() memastikan spasi saja dianggap kosong
    }

    final String trimmed = value.trim();
    // Simpan versi trimmed agar tidak memanggil trim() berulang

    if (trimmed.length < nameMinLength) {
      return 'Name must be at least $nameMinLength characters';
      // String interpolation: $variabel langsung di dalam string
    }

    if (trimmed.length > nameMaxLength) {
      return 'Name must be at most $nameMaxLength characters';
    }

    final RegExp validChars = RegExp(r"^[a-zA-Z\s\-']+$");
    // RegExp: Regular Expression untuk mencocokkan pola teks
    // ^       = mulai dari awal string
    // [...]   = karakter yang diizinkan
    // a-zA-Z  = huruf a-z dan A-Z
    // \s      = spasi (whitespace)
    // \-      = tanda hubung (-)
    // '       = apostrof (untuk nama seperti O'Brien)
    // +       = satu atau lebih karakter
    // $       = sampai akhir string

    if (!validChars.hasMatch(trimmed)) {
      return 'Name can only contain letters, spaces, and hyphens';
      // hasMatch: cek apakah string cocok dengan pola RegExp
    }

    return null;
    // null = input valid, tidak ada error
  }
}