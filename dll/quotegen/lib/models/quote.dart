// quote.dart
// File ini mendefinisikan "bentuk" dari satu kutipan.
// Kita pakai class immutable (semua field final) — ini praktik terbaik
// karena objek Quote tidak boleh berubah isinya setelah dibuat (predictable & aman dari bug).

class Quote {
  // constructor const, memungkinkan Quote dibuat sebagai compile-time constant
  // ini penting untuk performa karena Flutter bisa cache instance-nya
  const Quote({
    required this.text, // teks kutipan, wajib diisi saat membuat objek Quote
    required this.author, // nama penulis/tokoh kutipan, wajib diisi juga
  });

  // field final berarti nilainya hanya bisa di-assign sekali (saat konstruksi)
  // ini yang membuat objek Quote bersifat immutable (tidak bisa diubah setelah dibuat)
  final String text; // menyimpan isi kutipan, contoh: "Hidup adalah perjalanan"

  final String author; // menyimpan nama pemilik kutipan, contoh: "Anonim"

  // override method toString() bawaan Dart, berguna saat debugging/print()
  // supaya saat kita print(quote), hasilnya rapi dan informatif, bukan "Instance of 'Quote'"
  @override
  String toString() {
    // mengembalikan format teks gabungan kutipan dan authornya
    return '"$text" - $author';
  }

  // override operator == untuk membandingkan dua objek Quote berdasarkan isinya
  // bukan berdasarkan referensi memori (default Dart) — berguna nanti untuk perbandingan state
  @override
  bool operator ==(Object other) {
    // jika objek yang dibandingkan adalah instance yang sama persis, langsung true
    if (identical(this, other)) return true;

    // membandingkan tipe dan isi field text & author untuk menentukan kesetaraan
    return other is Quote && other.text == text && other.author == author;
  }

  // override hashCode wajib disertakan setiap kali kita override operator ==
  // ini menjaga konsistensi objek saat dipakai di struktur data seperti Set atau Map
  @override
  int get hashCode => Object.hash(text, author); // menggabungkan hash dari kedua field
}