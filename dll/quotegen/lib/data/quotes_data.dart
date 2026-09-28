// quotes_data.dart
// File ini menyimpan daftar mentah kutipan sebagai konstanta.
// Dipisah dari repository supaya "data" dan "logic pengambilan data" tidak bercampur —
// ini prinsip Single Responsibility yang penting dalam arsitektur modular.

import '../models/quote.dart'; // import class Quote yang sudah kita definisikan di Tahap 3

// list konstanta berisi seluruh kutipan yang tersedia di app
// dideklarasikan sebagai top-level const agar hanya dibuat sekali di memori (efisien)
const List<Quote> kQuotesData = [
  Quote(
    text: 'Hidup yang tidak diuji bukanlah hidup yang layak dijalani.', // isi kutipan pertama
    author: 'Socrates', // penulis kutipan pertama
  ),
  Quote(
    text: 'Kesederhanaan adalah bentuk kecanggihan tertinggi.',
    author: 'Leonardo da Vinci',
  ),
  Quote(
    text: 'Satu-satunya cara melakukan pekerjaan hebat adalah mencintai apa yang kamu kerjakan.',
    author: 'Steve Jobs',
  ),
  Quote(
    text: 'Kegagalan adalah kesempatan untuk memulai lagi dengan lebih cerdas.',
    author: 'Henry Ford',
  ),
  Quote(
    text: 'Imajinasi lebih penting daripada pengetahuan.',
    author: 'Albert Einstein',
  ),
  Quote(
    text: 'Waktu adalah satu-satunya modal yang benar-benar kita miliki.',
    author: 'Thomas Edison',
  ),
  Quote(
    text: 'Jangan menunggu kesempatan, ciptakanlah.',
    author: 'George Bernard Shaw',
  ),
  Quote(
    text: 'Kedisiplinan adalah jembatan antara tujuan dan pencapaian.',
    author: 'Jim Rohn',
  ),
  Quote(
    text: 'Keberanian bukan tidak adanya rasa takut, tapi kemampuan bertindak meski takut.',
    author: 'Nelson Mandela',
  ),
  Quote(
    text: 'Kualitas bukan tindakan, melainkan kebiasaan.',
    author: 'Aristoteles',
  ),
];