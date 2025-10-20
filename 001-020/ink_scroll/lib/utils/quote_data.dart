// File: lib/utils/quote_data.dart
// Penjelasan: File ini berisi data dummy (data contoh) untuk quotes
// Kita tidak fetch dari server, tapi gunakan data lokal untuk pembelajaran
// Nanti bisa diganti dengan API real

import '../models/quote_model.dart';

/// Class QuoteData berisi method statis untuk mendapatkan data quotes
class QuoteData {
  /// List dummy quotes untuk demonstrasi
  /// Setiap Quote berisi: id, text, author, category
  static List<Quote> getDummyQuotes() {
    return [
      Quote(
        id: '1',
        text: 'Hidup adalah tentang menciptakan diri sendiri.',
        author: 'George Bernard Shaw',
        category: 'Motivasi',
      ),
      Quote(
        id: '2',
        text: 'Keindahan sejati ada dalam kesederhanaan.',
        author: 'Socrates',
        category: 'Filosofi',
      ),
      Quote(
        id: '3',
        text: 'Jangan takut untuk memulai yang baru. Kesempatan itu menunggu.',
        author: 'Tony Robbins',
        category: 'Motivasi',
      ),
      Quote(
        id: '4',
        text: 'Dalam kesunyian, kita menemukan kedamaian sejati.',
        author: 'Buddha',
        category: 'Spiritual',
      ),
      Quote(
        id: '5',
        text: 'Seni sejati terletak pada kesederhanaan yang indah.',
        author: 'Leonardo da Vinci',
        category: 'Seni',
      ),
      Quote(
        id: '6',
        text: 'Setiap hari adalah kesempatan untuk menjadi lebih baik.',
        author: 'Ralph Waldo Emerson',
        category: 'Motivasi',
      ),
      Quote(
        id: '7',
        text: 'Keheningan adalah bahasa Tuhan. Semua yang lain adalah penerjemahan yang buruk.',
        author: 'Rumi',
        category: 'Spiritual',
      ),
      Quote(
        id: '8',
        text: 'Imperfeksi adalah bagian dari kesempurnaan.',
        author: 'Anonymous',
        category: 'Filosofi',
      ),
      Quote(
        id: '9',
        text: 'Hidup yang sederhana, pikiran yang jernih, hati yang mulia.',
        author: 'Buddha',
        category: 'Spiritual',
      ),
      Quote(
        id: '10',
        text: 'Kreativitas adalah kecerdasan yang bersenang-senang.',
        author: 'Albert Einstein',
        category: 'Seni',
      ),
    ];
  }

  /// Method untuk mendapatkan quotes berdasarkan kategori
  static List<Quote> getQuotesByCategory(String category) {
    // Filter list quotes berdasarkan kategori yang diminta
    return getDummyQuotes()
        .where((quote) => quote.category == category)
        .toList();
  }

  /// Method untuk mendapatkan daftar kategori yang unik
  static List<String> getCategories() {
    // Ambil semua quotes
    final quotes = getDummyQuotes();
    
    // Ambil kategori dari setiap quote dan jadikan Set (untuk menghapus duplikat)
    final categories = quotes
        .map((quote) => quote.category)
        .toSet()
        .toList();
    
    return categories;
  }
}