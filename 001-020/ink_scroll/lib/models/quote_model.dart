// File: lib/models/quote_model.dart
// Penjelasan: File ini berisi model/struktur data untuk Quote
// Model adalah blueprint untuk data yang kita gunakan di aplikasi

/// Class Quote merepresentasikan satu kutipan
/// Bisa dibayangkan seperti "template" untuk setiap quote yang ada
class Quote {
  // Properti (variabel) yang dimiliki setiap Quote
  final String id;           // ID unik untuk setiap quote
  final String text;         // Isi kutipan
  final String author;       // Nama pembuat kutipan
  final String category;     // Kategori kutipan (misal: Motivasi, Cinta, dll)

  /// Constructor (method untuk membuat object Quote)
  /// Semua parameter diperlukan (tidak boleh null)
  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  /// Method copyWith untuk membuat copy Quote dengan beberapa nilai yang berubah
  /// Berguna untuk membuat variasi data tanpa mengubah original
  Quote copyWith({
    String? id,
    String? text,
    String? author,
    String? category,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      category: category ?? this.category,
    );
  }

  /// Method toString untuk debugging (menampilkan data Quote secara readable)
  @override
  String toString() => 'Quote(id: $id, author: $author, text: $text)';
}