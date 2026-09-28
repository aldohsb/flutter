// quote_card.dart
// Widget ini adalah representasi visual dari satu Quote.
// Dipisah dari app.dart supaya reusable & mudah di-maintain — prinsip Single Responsibility:
// widget ini HANYA bertugas menampilkan data, tidak tahu-menahu soal state/logic random.

import 'package:flutter/material.dart'; // widget dasar Material Design (Card, Text, dll)
import '../models/quote.dart'; // tipe data Quote dari Tahap 3
import '../theme/app_colors.dart'; // palet warna kustom dari Tahap 2

class QuoteCard extends StatelessWidget {
  // constructor const, quote wajib diisi dari luar (widget ini "dumb" / tidak stateful)
  const QuoteCard({super.key, required this.quote});

  // field final menyimpan data kutipan yang akan ditampilkan
  final Quote quote;

  @override
  Widget build(BuildContext context) {
    // Card otomatis memakai styling dari CardThemeData yang kita set di Tahap 2
    // (radius 20, border tipis, warna surface) — konsisten tanpa perlu repeat kode
    return Card(
      // margin luar Card, memberi jarak dari tepi layar/parent
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        // padding dalam Card, ruang antara border dengan konten teks
        padding: const EdgeInsets.all(28),
        child: Column(
          // Column menyusun elemen secara vertikal: ikon kutip, teks, garis, author
          mainAxisSize: MainAxisSize.min, // Column hanya setinggi kontennya, tidak memaksa full height
          crossAxisAlignment: CrossAxisAlignment.center, // semua children rata tengah horizontal
          children: [
            // ikon tanda kutip besar sebagai elemen dekoratif khas app kutipan
            Icon(
              Icons.format_quote_rounded, // ikon quote bergaya rounded, lebih lembut dari sudut tajam
              size: 40, // ukuran cukup besar sebagai focal point visual
              color: AppColors.accent, // pakai warna aksen kuning keemasan dari Tahap 2
            ),

            const SizedBox(height: 16), // jarak vertikal antara ikon dan teks kutipan

            // teks utama kutipan, pakai style headlineSmall yang sudah kita definisikan di Tahap 2
            Text(
              quote.text, // konten teks kutipan dari data
              textAlign: TextAlign.center, // rata tengah agar simetris dalam Card
              style: Theme.of(context).textTheme.headlineSmall, // ambil style dari theme terpusat
            ),

            const SizedBox(height: 20), // jarak sebelum garis pemisah

            // garis aksen pendek sebagai pemisah visual antara kutipan dan nama author
            Container(
              width: 48, // lebar garis sengaja pendek, bukan full width (kesan elegan, bukan divider biasa)
              height: 3, // ketebalan garis
              decoration: BoxDecoration(
                color: AppColors.accent, // warna sama dengan ikon quote, menjaga konsistensi visual
                borderRadius: BorderRadius.circular(4), // ujung garis membulat, bukan kotak tajam
              ),
            ),

            const SizedBox(height: 20), // jarak antara garis dan nama author

            // nama author, pakai style bodyMedium (lebih kecil & redup) dari Tahap 2
            Text(
              '— ${quote.author}', // strip panjang di depan nama, konvensi penulisan sumber kutipan
              style: Theme.of(context).textTheme.bodyMedium, // style sekunder, kontras dengan judul
            ),
          ],
        ),
      ),
    );
  }
}