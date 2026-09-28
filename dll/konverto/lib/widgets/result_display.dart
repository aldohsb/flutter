import 'package:flutter/material.dart'; // import widget dasar Material Design

// Widget untuk menampilkan hasil konversi dalam bentuk kartu yang menonjol secara visual
class ResultDisplay extends StatelessWidget { // stateless, hanya menampilkan nilai dari parent
  const ResultDisplay({super.key, required this.resultText}); // constructor menerima teks hasil

  final String resultText; // teks hasil konversi yang sudah diformat, kosong jika belum ada hasil

  @override
  Widget build(BuildContext context) { // render widget hasil
    if (resultText.isEmpty) return const SizedBox.shrink(); // sembunyikan widget jika belum ada hasil
    final scheme = Theme.of(context).colorScheme; // ambil skema warna tema aktif untuk konsistensi desain
    return Card( // bungkus hasil dalam kartu agar menonjol
      color: scheme.primaryContainer, // gunakan warna primary container agar kontras & elegan
      child: Padding( // beri jarak dalam kartu agar tidak sempit
        padding: const EdgeInsets.all(20), // padding 20 di semua sisi
        child: Column( // susun ikon & teks secara vertikal
          children: [ // daftar widget anak dalam kartu
            Icon(Icons.swap_horiz_rounded, color: scheme.onPrimaryContainer, size: 32), // ikon simbol konversi
            const SizedBox(height: 8), // jarak vertikal antara ikon dan teks
            Text( // teks hasil konversi
              resultText, // isi teks hasil yang sudah diformat
              style: Theme.of(context).textTheme.headlineSmall?.copyWith( // gaya teks besar & jelas
                color: scheme.onPrimaryContainer, // warna teks kontras dengan background kartu
                fontWeight: FontWeight.bold, // tebalkan teks agar hasil mudah dibaca
              ),
              textAlign: TextAlign.center, // rata tengah teks hasil
            ),
          ],
        ),
      ),
    );
  }
}