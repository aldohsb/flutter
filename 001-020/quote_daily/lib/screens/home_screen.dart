// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/quote_provider.dart';
import '../widgets/magazine_background.dart';
import '../widgets/quote_card.dart';
import 'favorites_screen.dart';

// Home Screen - halaman utama aplikasi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer = widget yang "dengerin" perubahan dari Provider
    // Setiap kali QuoteProvider.notifyListeners() dipanggil,
    // Consumer ini akan rebuild (build ulang)
    return Consumer<QuoteProvider>(
      builder: (context, quoteProvider, child) {
        return Scaffold(
          // Scaffold = struktur dasar halaman (punya appBar, body, floatingButton, dll)
          
          // extendBodyBehindAppBar = body meluas sampai belakang AppBar
          // Jadi background image full dari atas sampai bawah
          extendBodyBehindAppBar: true,
          
          // AppBar transparan dengan tombol favorites
          appBar: _buildAppBar(context, quoteProvider),
          
          // Body = isi utama halaman
          body: _buildBody(context, quoteProvider),
          
          // Floating Action Button - tombol melayang berbentuk bookmark
          floatingActionButton: _buildFloatingButtons(context, quoteProvider),
        );
      },
    );
  }

  // Method untuk build AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context, QuoteProvider provider) {
    return AppBar(
      // backgroundColor transparan
      backgroundColor: Colors.transparent,
      elevation: 0, // Hilangkan shadow
      
      // Title dengan offline indicator
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'QUOTEDAILY',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          // Offline mode indicator (muncul kalau ada error)
          if (provider.error != null) ...[
            SizedBox(width: 8),
            Icon(
              Icons.cloud_off,
              size: 16,
              color: Colors.orange[300],
            ),
          ],
        ],
      ),
      
      // Tombol favorites di kanan
      actions: [
        // Badge untuk show jumlah favorites
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {
                // Navigate ke FavoritesScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              },
            ),
            
            // Badge (lingkaran merah dengan angka)
            if (provider.favorites.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${provider.favorites.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 8),
      ],
    );
  }

  // Method untuk build body
  Widget _buildBody(BuildContext context, QuoteProvider provider) {
    // Kalau lagi loading
    if (provider.isLoading && provider.currentQuote == null) {
      return MagazineBackground(
        imageUrl: provider.backgroundImageUrl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                'Loading your daily quote...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Kalau ada error
    if (provider.error != null && provider.currentQuote == null) {
      return MagazineBackground(
        imageUrl: provider.backgroundImageUrl,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off,
                  color: Colors.white.withOpacity(0.8),
                  size: 64,
                ),
                SizedBox(height: 24),
                Text(
                  'Offline Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Using local quotes. Connect to internet for more content.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => provider.fetchNewQuote(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text(
                    'TRY AGAIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Kalau ada quote, tampilkan
    if (provider.currentQuote != null) {
      return GestureDetector(
        // GestureDetector = widget untuk detect gesture (swipe, tap, dll)
        onHorizontalDragEnd: (details) {
          // details.primaryVelocity = kecepatan swipe
          // Kalau swipe ke kiri (negative) = fetch quote baru
          if (details.primaryVelocity! < 0) {
            provider.fetchNewQuote();
          }
        },
        
        child: MagazineBackground(
          imageUrl: provider.backgroundImageUrl,
          child: QuoteCard(
            quote: provider.currentQuote!,
            currentIndex: provider.currentIndex,
          ),
        ),
      );
    }

    // Fallback (seharusnya tidak sampai sini)
    return Container();
  }

  // Method untuk build floating buttons
  Widget _buildFloatingButtons(BuildContext context, QuoteProvider provider) {
    // Kalau tidak ada quote, jangan tampilkan button
    if (provider.currentQuote == null) return SizedBox.shrink();

    final quote = provider.currentQuote!;
    final isFav = provider.isFavorite(quote.id);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Tombol Share
        FloatingActionButton(
          heroTag: 'share', // heroTag untuk beda animasi kalau ada multiple FAB
          backgroundColor: Colors.white.withOpacity(0.9),
          onPressed: () => _shareQuote(quote.content, quote.author),
          child: Icon(Icons.share, color: Colors.black87),
        ),
        
        SizedBox(height: 16),
        
        // Tombol Bookmark (Add/Remove Favorite)
        FloatingActionButton(
          heroTag: 'favorite',
          backgroundColor: isFav 
              ? Colors.red.withOpacity(0.9) 
              : Colors.white.withOpacity(0.9),
          onPressed: () {
            provider.toggleFavorite(quote);
            
            // Show snackbar (notifikasi di bawah)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFav ? 'Removed from favorites' : 'Added to favorites',
                ),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Icon(
            isFav ? Icons.bookmark : Icons.bookmark_border,
            color: isFav ? Colors.white : Colors.black87,
          ),
        ),
        
        SizedBox(height: 16),
        
        // Tombol Next Quote
        FloatingActionButton.extended(
          heroTag: 'next',
          backgroundColor: Colors.black.withOpacity(0.8),
          onPressed: () => provider.fetchNewQuote(),
          label: Text(
            'NEXT QUOTE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          icon: Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ],
    );
  }

  // Method untuk share quote
  void _shareQuote(String content, String author) {
    // share_plus package untuk share ke app lain
    final text = '"$content"\n\n— $author\n\nShared from QuoteDaily';
    Share.share(text);
  }
}