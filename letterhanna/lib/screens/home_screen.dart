// File: lib/screens/home_screen.dart
// Berisi widget HomeScreen untuk halaman utama LetterHanna.
// Hari 2: Buat layout sederhana dengan Container, Column, Row, dan card dummy.
// Layout: Header "Welcome to LetterHanna" di atas, lalu 3 card dummy (teks statis).
// Nanti di hari berikutnya (Hari 11), card dummy diganti list dinamis dari data model.

import 'package:flutter/material.dart';

// HomeScreen: StatelessWidget karena layout statis (belum ada state seperti counter).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Struktur dasar halaman (AppBar, body).
    return Scaffold(
      appBar: AppBar(
        title: const Text('LetterHanna'), // Title di AppBar.
        backgroundColor: const Color(0xFFFFF8E1), // Warna krem untuk tema elegant.
        elevation: 2, // Shadow kecil untuk kesan klasik.
      ),
      // Body: Isi halaman.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding 16px di semua sisi.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align kiri untuk teks header.
          children: [
            // Header: Teks "Welcome to LetterHanna".
            const Text(
              'Welcome to LetterHanna',
              style: TextStyle(
                fontSize: 24, // Ukuran besar untuk header.
                fontWeight: FontWeight.bold, // Tebal untuk kesan kuat.
                color: Colors.black87, // Warna gelap untuk kontras.
              ),
            ),
            const SizedBox(height: 16), // Jarak 16px antara header dan card.
            // List card dummy: Simulasi produk font.
            // Nanti di Hari 11, kita ganti dengan ListView.builder untuk data dinamis.
            Column(
              children: [
                _buildFontCard(context, 'Font A'), // Card dummy 1.
                const SizedBox(height: 12), // Jarak antar card.
                _buildFontCard(context, 'Font B'), // Card dummy 2.
                const SizedBox(height: 12),
                _buildFontCard(context, 'Font C'), // Card dummy 3.
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method helper: Buat card untuk satu font.
  // Parameter: context (untuk akses theme), name (nama font dummy).
  // Mengapa dipisah? Modular, agar mudah reuse dan edit nanti.
  Widget _buildFontCard(BuildContext context, String name) {
    return Container(
      width: double.infinity, // Lebar penuh.
      padding: const EdgeInsets.all(12), // Padding dalam card.
      decoration: BoxDecoration(
        color: Colors.white, // Latar putih untuk card.
        borderRadius: BorderRadius.circular(8), // Sudut membulat.
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Shadow lembut untuk kesan elegant.
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        name, // Nama font dummy (e.g., "Font A").
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500, // Sedikit tebal untuk nama font.
        ),
      ),
    );
  }
}