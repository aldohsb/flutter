// File: lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quote_provider.dart';
import '../models/quote_model.dart';

// Favorites Screen - halaman untuk lihat semua quotes favorit
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan gradient background
      appBar: AppBar(
        title: Text(
          'MY FAVORITES',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
        // flexibleSpace = area AppBar yang bisa dikasih decoration
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          // Tombol clear all favorites
          Consumer<QuoteProvider>(
            builder: (context, provider, child) {
              if (provider.favorites.isEmpty) return SizedBox.shrink();
              
              return IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () => _showClearDialog(context, provider),
                tooltip: 'Clear all favorites',
              );
            },
          ),
        ],
      ),
      
      // Body dengan Consumer
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          // Kalau favorites kosong
          if (provider.favorites.isEmpty) {
            return _buildEmptyState();
          }

          // Kalau ada favorites, tampilkan list
          return _buildFavoritesList(context, provider);
        },
      ),
    );
  }

  // Widget untuk empty state (kalau belum ada favorites)
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon bookmark besar
            Icon(
              Icons.bookmark_border,
              size: 120,
              color: Colors.grey[300],
            ),
            
            SizedBox(height: 24),
            
            Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            SizedBox(height: 16),
            
            Text(
              'Start bookmarking quotes you love\nand they\'ll appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk list favorites
  Widget _buildFavoritesList(BuildContext context, QuoteProvider provider) {
    return ListView.builder(
      // ListView.builder = list yang di-build secara lazy (hemat memory)
      // Hanya build item yang visible di screen
      
      padding: EdgeInsets.all(16),
      
      // itemCount = jumlah item
      itemCount: provider.favorites.length,
      
      // itemBuilder = function untuk build setiap item
      itemBuilder: (context, index) {
        final quote = provider.favorites[index];
        return _buildFavoriteCard(context, provider, quote, index);
      },
    );
  }

  // Widget untuk card setiap favorite quote
  Widget _buildFavoriteCard(
    BuildContext context, 
    QuoteProvider provider, 
    QuoteModel quote,
    int index,
  ) {
    return Card(
      // Card = container dengan shadow dan rounded corners
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2, // Ketinggian shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      
      child: InkWell(
        // InkWell = widget untuk detect tap dengan ripple effect
        onTap: () {
          // Show detail dialog saat di-tap
          _showQuoteDetailDialog(context, provider, quote);
        },
        
        borderRadius: BorderRadius.circular(16),
        
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: number dan delete button
              Row(
                children: [
                  // Number badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '#${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Spacer(), // Spacer = ambil space tersisa (dorong widget ke kanan)
                  
                  // Share button
                  IconButton(
                    icon: Icon(Icons.share, size: 20),
                    onPressed: () => _shareQuote(quote.content, quote.author),
                    color: Colors.grey[600],
                  ),
                  
                  // Delete button
                  IconButton(
                    icon: Icon(Icons.delete_outline, size: 20),
                    onPressed: () => _showDeleteDialog(context, provider, quote),
                    color: Colors.red[400],
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Quote content
              Text(
                quote.content,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                // maxLines = maksimal baris yang ditampilkan
                maxLines: 4,
                // overflow = apa yang terjadi kalau teks terlalu panjang
                overflow: TextOverflow.ellipsis, // Kasih "..." di akhir
              ),
              
              SizedBox(height: 16),
              
              // Author dan tags
              Row(
                children: [
                  // Author
                  Expanded(
                    child: Text(
                      '— ${quote.author}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  
                  // Tags
                  if (quote.tags.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        quote.tags.first.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog untuk show detail quote
  void _showQuoteDetailDialog(
    BuildContext context, 
    QuoteProvider provider, 
    QuoteModel quote,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ukuran sesuai content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon quote
              Icon(
                Icons.format_quote,
                size: 48,
                color: Colors.grey[400],
              ),
              
              SizedBox(height: 16),
              
              // Quote content
              Text(
                quote.content,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              
              SizedBox(height: 24),
              
              // Author
              Text(
                '— ${quote.author}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              
              SizedBox(height: 16),
              
              // Tags
              if (quote.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: quote.tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
              
              SizedBox(height: 24),
              
              // Close button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'CLOSE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog untuk konfirmasi delete
  void _showDeleteDialog(
    BuildContext context, 
    QuoteProvider provider, 
    QuoteModel quote,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Favorite?'),
        content: Text('Are you sure you want to remove this quote from favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              provider.removeFavorite(quote.id);
              Navigator.pop(context);
              
              // Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Quote removed from favorites'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Text(
              'REMOVE',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog untuk konfirmasi clear all
  void _showClearDialog(BuildContext context, QuoteProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear All Favorites?'),
        content: Text('This will remove all quotes from your favorites. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              provider.clearFavorites();
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All favorites cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'CLEAR ALL',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Method untuk share quote
  void _shareQuote(String content, String author) {
    final text = '"$content"\n\n— $author\n\nShared from QuoteDaily';
    Share.share(text);
  }
}