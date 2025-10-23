// File: lib/screens/home_screen.dart
// Berisi widget HomeScreen untuk halaman utama LetterHanna.
// Hari 3: Ganti Column card dengan GridView untuk layout 2 kolom.
// Tambah Image widget untuk preview font dummy di setiap card.
// Nanti di Hari 11, GridView diganti GridView.builder untuk data dinamis.

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Struktur dasar halaman.
    return Scaffold(
      appBar: AppBar(
        title: const Text('LetterHanna'), // Title AppBar.
        backgroundColor: const Color(0xFFFFF8E1), // Warna krem untuk tema elegant.
        elevation: 2, // Shadow kecil.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding 16px di semua sisi.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align kiri untuk header.
          children: [
            // Header: Teks "Welcome to LetterHanna".
            const Text(
              'Welcome to LetterHanna',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16), // Jarak ke grid.
            // GridView: Susun card dalam grid 2 kolom.
            // crossAxisCount: 2 berarti 2 kolom.
            Expanded( // Expanded: Ambil sisa ruang vertikal.
              child: GridView.count(
                crossAxisCount: 2, // 2 kolom.
                crossAxisSpacing: 12, // Jarak horizontal antar card.
                mainAxisSpacing: 12, // Jarak vertikal antar card.
                childAspectRatio: 0.75, // Rasio lebar:tinggi card (lebih tinggi dari lebar).
                children: [
                  _buildFontCard(context, 'Font A', 'assets/images/font_preview1.png'),
                  _buildFontCard(context, 'Font B', 'assets/images/font_preview2.png'),
                  _buildFontCard(context, 'Font C', 'assets/images/font_preview3.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method helper: Buat card untuk satu font.
  // Parameter: context (untuk theme), name (nama font), imagePath (path gambar dummy).
  // Update dari Hari 2: Tambah Image widget untuk preview.
  Widget _buildFontCard(BuildContext context, String name, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(12), // Padding dalam card.
      decoration: BoxDecoration(
        color: Colors.white, // Latar putih.
        borderRadius: BorderRadius.circular(8), // Sudut membulat.
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align kiri untuk teks.
        children: [
          // Image: Tampilkan gambar dummy sebagai preview font.
          // Nanti di Hari 16, ganti dengan preview font asli.
          ClipRRect( // ClipRRect: Bulatkan sudut gambar.
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath, // Path ke gambar dummy di assets.
              height: 100, // Tinggi gambar.
              width: double.infinity, // Lebar penuh card.
              fit: BoxFit.cover, // Gambar menyesuaikan tanpa distorsi.
            ),
          ),
          const SizedBox(height: 8), // Jarak antara gambar dan teks.
          Text(
            name, // Nama font dummy (e.g., "Font A").
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}