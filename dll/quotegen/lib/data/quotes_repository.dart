// quotes_repository.dart
// File ini bertanggung jawab atas SATU hal: menyediakan cara mengambil kutipan.
// Pola "Repository" ini memisahkan sumber data dari consumer-nya —
// nanti kalau data mau dipindah ke API/database, hanya file ini yang perlu diubah,
// widget lain tidak perlu tahu perubahan tersebut sama sekali.

import 'dart:math'; // Random class bawaan Dart SDK, tidak perlu package eksternal apapun
import '../models/quote.dart'; // import Quote untuk tipe kembalian method kita
import 'quotes_data.dart'; // import daftar kutipan mentah yang sudah kita buat

class QuotesRepository {
  // constructor default, class ini bisa di-instantiate langsung (dipakai di Controller nanti)
  QuotesRepository();

  // instance Random dibuat SEKALI sebagai field, bukan di dalam method
  // ini penting: kalau Random() dibuat ulang setiap kali dipanggil dalam waktu singkat,
  // seed-nya bisa mirip dan hasil random jadi kurang acak (best practice: reuse instance)
  final Random _random = Random();

  // method untuk mengambil satu kutipan secara acak dari daftar kQuotesData
  Quote getRandomQuote() {
    // _random.nextInt(n) menghasilkan integer acak dari 0 sampai (n-1)
    // kita pakai panjang list sebagai batas atas, supaya index selalu valid
    final int randomIndex = _random.nextInt(kQuotesData.length);

    // mengembalikan Quote pada index acak yang baru saja dihasilkan
    return kQuotesData[randomIndex];
  }

  // method tambahan untuk mengambil kutipan acak TAPI berbeda dari kutipan saat ini
  // berguna supaya user tidak mendapat kutipan yang sama dua kali berturut-turut
  Quote getRandomQuoteExcluding(Quote currentQuote) {
    // jika daftar kutipan cuma 1, tidak mungkin exclude apapun, langsung kembalikan saja
    if (kQuotesData.length <= 1) return currentQuote;

    // deklarasi variabel untuk menampung hasil kutipan baru
    Quote newQuote;

    // do-while loop: terus generate kutipan baru SELAMA hasilnya masih sama dengan yang lama
    do {
      newQuote = getRandomQuote(); // panggil method random pick yang sudah kita buat di atas
    } while (newQuote == currentQuote); // syarat berhenti: kutipan baru harus berbeda (pakai operator == dari Tahap 3)

    // kembalikan kutipan baru yang sudah dipastikan berbeda dari sebelumnya
    return newQuote;
  }
}