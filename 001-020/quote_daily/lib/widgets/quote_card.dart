// File: lib/widgets/quote_card.dart

import 'package:flutter/material.dart';
import '../models/quote_model.dart';

// Widget untuk menampilkan quote dengan style magazine editorial
class QuoteCard extends StatelessWidget {
  final QuoteModel quote; // Data quote
  final int totalQuotes;  // Total quote (untuk pagination)
  final int currentIndex; // Index saat ini

  const QuoteCard({
    super.key,
    required this.quote,
    this.totalQuotes = 365, // Default 365 (1 tahun)
    this.currentIndex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding = jarak dari pinggir
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        // Column = susun widget secara vertikal (atas-bawah)
        crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
        children: [
          // Spacer = widget kosong yang flexible (ambil space tersisa)
          Spacer(flex: 2),

          // Tags (kategori quote)
          if (quote.tags.isNotEmpty) ...[
            // if ... spread operator [...] = kalau condition true, masukkan widgets
            _buildTags(quote.tags),
            SizedBox(height: 24), // Jarak vertikal
          ],

          // Quote content - teks utama
          _buildQuoteContent(quote.content),
          
          SizedBox(height: 32),

          // Author name
          _buildAuthor(quote.author),

          Spacer(flex: 3),

          // Pagination indicator (1/365)
          _buildPagination(),
        ],
      ),
    );
  }

  // Widget untuk tags
  Widget _buildTags(List<String> tags) {
    return Wrap(
      // Wrap = susun widget horizontal, kalau ga cukup pindah ke baris baru
      spacing: 8, // Jarak horizontal antar item
      runSpacing: 8, // Jarak vertical antar baris
      children: tags.take(3).map((tag) { // take(3) = ambil max 3 tags
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            // Border putih transparan
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20), // Sudut melengkung
          ),
          child: Text(
            tag.toUpperCase(), // UPPERCASE untuk efek magazine
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5, // Jarak antar huruf
            ),
          ),
        );
      }).toList(),
    );
  }

  // Widget untuk quote content dengan typography magazine
  Widget _buildQuoteContent(String content) {
    // Split content jadi kata-kata
    final words = content.split(' ');
    
    // Ambil 2-3 kata pertama untuk dijadikan "drop cap" (huruf besar)
    final firstWords = words.take(2).join(' ');
    final restContent = words.skip(2).join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Opening quote mark
        Text(
          '"',
          style: TextStyle(
            fontSize: 120, // Super besar!
            height: 0.8, // Line height
            fontWeight: FontWeight.w900,
            color: Colors.white.withOpacity(0.3),
            fontFamily: 'serif', // Font serif klasik
          ),
        ),
        
        // First words - lebih besar dan bold
        Text(
          firstWords,
          style: TextStyle(
            fontSize: 42,
            height: 1.1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1, // Negative spacing = huruf lebih rapat
          ),
        ),
        
        SizedBox(height: 16),
        
        // Rest of content - ukuran normal
        Text(
          restContent,
          style: TextStyle(
            fontSize: 28,
            height: 1.4,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.95),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Widget untuk author name
  Widget _buildAuthor(String author) {
    return Container(
      // Decorative line di samping author
      child: Row(
        children: [
          // Line horizontal
          Container(
            width: 40,
            height: 2,
            color: Colors.white.withOpacity(0.5),
          ),
          
          SizedBox(width: 16),
          
          // Author name
          Expanded(
            child: Text(
              author.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk pagination (1/365)
  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page number
        Text(
          '$currentIndex/$totalQuotes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.6),
            letterSpacing: 1,
          ),
        ),
        
        // Decorative dots (seperti di majalah)
        Row(
          children: List.generate(
            3, // 3 dots
            (index) => Container(
              margin: EdgeInsets.only(left: 8),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle, // Bentuk lingkaran
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget alternatif untuk quote card dengan layout centered
class QuoteCardCentered extends StatelessWidget {
  final QuoteModel quote;

  const QuoteCardCentered({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Quote icon
            Icon(
              Icons.format_quote,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            
            SizedBox(height: 32),
            
            // Quote text - centered
            Text(
              quote.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: 32),
            
            // Author
            Text(
              '— ${quote.author}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}