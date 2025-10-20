import 'package:flutter/material.dart';

// MainMenuScreen adalah widget untuk menampilkan menu utama game.
// Untuk Hari 1, kita menggunakan StatelessWidget karena tampilan menu ini 
// bersifat statis (tidak berubah seiring waktu tanpa interaksi eksternal).
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar sebuah halaman/screen di Flutter (tempat AppBar, body, dll).
    return Scaffold(
      // body adalah isi utama halaman. Kita gunakan Center agar semua isinya berada di tengah.
      body: Center(
        // Column menyusun widget-widget anaknya secara vertikal (atas ke bawah).
        child: Column(
          // mainAxisAlignment.center: Menempatkan widget di tengah sumbu vertikal.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1. Judul Game "MARYAMFALL"
            Text(
              'MARYAMFALL',
              style: TextStyle(
                // Ukuran font besar.
                fontSize: 48,
                fontWeight: FontWeight.w900, // Extra Bold
                color: Colors.pinkAccent.shade100, // Warna cerah sebagai aksen game
                // Tambahkan efek bayangan (shadow) agar terlihat seperti neon/glow.
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: Colors.pink.withOpacity(0.8),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            
            // Memberikan jarak (padding) vertikal sebesar 50.
            const SizedBox(height: 50),

            // 2. Tombol Utama "Mulai Main" (Play)
            ElevatedButton(
              // onPressed: Fungsi yang dipanggil saat tombol ditekan.
              // Untuk saat ini, kita hanya melakukan print (mencetak) ke konsol.
              // TODO: [Hari 2] Kita akan mengganti ini dengan fungsi navigasi ke layar Game.
              onPressed: () {
                debugPrint('Tombol Play ditekan! (Aksi akan ditambahkan besok)');
              },
              // style: Mengatur tampilan tombol.
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent.shade400, // Latar belakang tombol
                foregroundColor: Colors.white, // Warna teks tombol
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Sudut melengkung
                ),
                elevation: 10, // Bayangan tombol
              ),
              child: const Text(
                'Mulai Main',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5, // Jarak antar huruf
                ),
              ),
            ),

            // Jarak vertikal tambahan
            const SizedBox(height: 30),
            
            // 3. Tombol Placeholder untuk Menu Lain
            TextButton(
              onPressed: () {
                // TODO: [Hari 28] Tambahkan logika Leaderboard dan Settings.
                debugPrint('Tombol Leaderboard ditekan!');
              },
              child: Text(
                'Lihat Papan Skor & Pengaturan',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}