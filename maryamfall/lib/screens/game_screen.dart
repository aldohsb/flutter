import 'package:flutter/material.dart';
import '../widgets/character_widget.dart';

// GameScreen adalah layar utama game kita
// StatefulWidget digunakan karena screen ini akan berubah-ubah
// (misalnya posisi karakter, score, dll)
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // createState() membuat State object yang menyimpan data yang berubah
  State<GameScreen> createState() => _GameScreenState();
}

// State adalah class yang menyimpan data yang bisa berubah
// Underscore (_) di depan nama class berarti private (hanya bisa diakses di file ini)
class _GameScreenState extends State<GameScreen> {
  // Posisi karakter di layar
  // double adalah tipe data untuk angka desimal
  double characterX = 0; // Posisi horizontal (kiri-kanan)
  double characterY = 0; // Posisi vertikal (atas-bawah)
  
  // Ukuran karakter
  final double characterSize = 60;
  
  @override
  Widget build(BuildContext context) {
    // Scaffold adalah struktur dasar Material Design
    // Menyediakan AppBar, Body, FloatingActionButton, dll
    return Scaffold(
      // backgroundColor mengatur warna background
      // Color.fromARGB(alpha, red, green, blue)
      // Alpha: 255 = opaque, 0 = transparent
      backgroundColor: const Color.fromARGB(255, 135, 206, 235), // Warna langit biru
      
      // AppBar adalah bar di atas layar
      appBar: AppBar(
        title: const Text(
          'MaryamFall Game',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true, // Judul di tengah
        elevation: 0, // Hilangkan shadow
      ),
      
      // Body adalah konten utama
      // Stack widget memungkinkan kita menumpuk widget di atas satu sama lain
      // Cocok untuk game karena kita perlu posisikan karakter, obstacle, dll
      body: Stack(
        children: [
          // Positioned memungkinkan kita menaruh widget di koordinat spesifik
          Positioned(
            // left dan top adalah koordinat dari pojok kiri atas
            left: characterX,
            top: characterY,
            
            // Child adalah widget yang akan diposisikan
            child: CharacterWidget(size: characterSize),
          ),
          
          // Info text untuk debugging (akan kita hapus nanti)
          // Positioned.fill membuat widget mengisi seluruh area
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment mengatur alignment horizontal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container dengan background semi-transparent
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hari 1: Basic Setup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Posisi X: ${characterX.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Posisi Y: ${characterY.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // FloatingActionButton untuk testing
      // Nanti akan kita ganti dengan touch control
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tombol untuk gerak ke kiri
          FloatingActionButton(
            heroTag: 'left', // Unique tag untuk multiple FAB
            onPressed: () {
              // setState() memberitahu Flutter bahwa ada data yang berubah
              // Flutter akan rebuild widget dengan data baru
              setState(() {
                characterX -= 20; // Geser 20 pixel ke kiri
                // Pastikan tidak keluar layar kiri
                if (characterX < 0) characterX = 0;
              });
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 8),
          
          // Tombol untuk gerak ke kanan
          FloatingActionButton(
            heroTag: 'right',
            onPressed: () {
              setState(() {
                characterX += 20; // Geser 20 pixel ke kanan
                // Dapatkan lebar layar
                double screenWidth = MediaQuery.of(context).size.width;
                // Pastikan tidak keluar layar kanan
                if (characterX > screenWidth - characterSize) {
                  characterX = screenWidth - characterSize;
                }
              });
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}