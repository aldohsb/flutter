import 'package:flutter/material.dart'; // Slider dan widget dasar lainnya

// widget slider tinggi badan, tampil sebagai kartu dengan angka besar di atasnya
class HeightSlider extends StatelessWidget {
  const HeightSlider({ // constructor menerima nilai dan callback dari parent
    super.key,
    required this.heightCm, // nilai tinggi badan saat ini dalam cm
    required this.onChanged, // callback dipanggil setiap slider digeser
  });

  final double heightCm; // menyimpan nilai tinggi yang sedang aktif
  final ValueChanged<double> onChanged; // fungsi yang diberi tahu parent saat nilai berubah

  @override
  Widget build(BuildContext context) {
    return Container( // pembungkus kartu untuk slider
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // jarak dalam kartu
      decoration: BoxDecoration( // dekorasi visual kartu
        color: Colors.white, // latar putih agar kontras dengan gradasi background
        borderRadius: BorderRadius.circular(16), // sudut membulat senada dengan field lain
      ),
      child: Column( // menyusun label, angka, dan slider secara vertikal
        crossAxisAlignment: CrossAxisAlignment.start, // rata kiri untuk teks label
        children: [
          Row( // baris berisi label dan nilai angka besar
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // label kiri, angka kanan
            children: [
              const Text('Tinggi Badan', style: TextStyle(fontSize: 14, color: Colors.black54)), // label kecil
              Text( // menampilkan nilai tinggi dengan format custom
                '${heightCm.round()} cm', // membulatkan double ke integer lalu tambah satuan cm
                style: TextStyle( // gaya teks angka besar dan tebal
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary, // memakai warna primary tema aktif
                ),
              ),
            ],
          ),
          Slider( // komponen slider bawaan flutter, gaya visualnya diatur lewat SliderTheme
            value: heightCm, // nilai slider saat ini mengikuti state parent
            min: 100, // batas bawah tinggi badan yang wajar
            max: 220, // batas atas tinggi badan yang wajar
            divisions: 120, // jumlah langkah diskrit, membuat slider snap tiap 1 cm
            label: '${heightCm.round()} cm', // label bubble yang muncul saat thumb ditekan
            onChanged: onChanged, // meneruskan perubahan nilai ke parent lewat callback
          ),
        ],
      ),
    );
  }
}