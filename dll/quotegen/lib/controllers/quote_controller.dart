// quote_controller.dart
// File ini adalah "otak" reaktif dari fitur kutipan.
// ChangeNotifier adalah class bawaan Flutter (dari package flutter/foundation)
// yang bisa memberi tahu "pendengar" (listener) kapanpun datanya berubah.

import 'package:flutter/foundation.dart'; // sumber class ChangeNotifier
import '../models/quote.dart'; // tipe data Quote dari Tahap 3
import '../data/quotes_repository.dart'; // sumber logic random pick dari Tahap 4

class QuoteController extends ChangeNotifier {
  // constructor: langsung mengisi _currentQuote dengan kutipan acak pertama
  // supaya begitu app dibuka, sudah ada kutipan yang tampil (bukan kosong)
  QuoteController({required QuotesRepository repository})
      : _repository = repository, // simpan repository yang di-inject dari luar
        _currentQuote = repository.getRandomQuote(); // ambil kutipan awal saat controller dibuat

  // repository final, di-inject lewat constructor (bukan dibuat sendiri di sini)
  // pola ini disebut "dependency injection" — memudahkan testing & mengurangi ketergantungan antar file
  final QuotesRepository _repository;

  // field private menyimpan kutipan yang sedang aktif ditampilkan
  Quote _currentQuote;

  // getter publik agar widget luar bisa BACA kutipan saat ini,
  // tapi tidak bisa mengubahnya langsung dari luar (encapsulation)
  Quote get currentQuote => _currentQuote;

  // method publik yang dipanggil widget (tombol) untuk pindah ke kutipan berikutnya
  void nextQuote() {
    // ambil kutipan baru yang dijamin berbeda dari kutipan saat ini (dari Tahap 4)
    _currentQuote = _repository.getRandomQuoteExcluding(_currentQuote);

    // notifyListeners() adalah method inti ChangeNotifier —
    // ini yang memberi tahu semua widget pendengar untuk rebuild dengan data terbaru
    notifyListeners();
  }
}