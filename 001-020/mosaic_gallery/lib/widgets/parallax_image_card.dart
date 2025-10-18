import 'package:flutter/material.dart';
import '../models/photo_item.dart';

/// ParallaxImageCard - Card dengan efek parallax saat scroll
/// Parallax effect membuat image bergerak lebih lambat dari container-nya
/// Memberikan sense of depth dan interaktivitas yang menarik
class ParallaxImageCard extends StatelessWidget {
  /// Data foto yang akan ditampilkan
  final PhotoItem photo;
  
  /// Global key untuk mendapatkan posisi widget di layar
  /// Diperlukan untuk menghitung parallax offset
  final GlobalKey imageKey;
  
  /// ScrollController dari parent untuk tracking scroll position
  final ScrollController scrollController;

  /// Constructor
  const ParallaxImageCard({
    super.key,
    required this.photo,
    required this.imageKey,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Gunakan clipBehavior untuk rounded corners
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // === PARALLAX IMAGE LAYER ===
          // AnimatedBuilder untuk rebuild saat scroll
          AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              // Hitung parallax offset berdasarkan posisi scroll
              final double parallaxOffset = _calculateParallaxOffset();
              
              return Transform.translate(
                // Offset vertical untuk parallax effect
                // Negative offset = gerak ke atas
                offset: Offset(0, parallaxOffset),
                child: child,
              );
            },
            child: _buildImageContent(),
          ),

          // === GRADIENT OVERLAY ===
          // Gradient dari transparent ke semi-transparent
          // Memberikan contrast untuk text di atas image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.5, 1.0], // Gradient mulai dari 50% ke bawah
                ),
              ),
            ),
          ),

          // === MEMPHIS DECORATION ===
          // Geometric shapes untuk Memphis design accent
          _buildMemphisDecoration(),

          // === TITLE OVERLAY ===
          // Text title di bagian bawah card
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Text(
              photo.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                shadows: [
                  // Text shadow untuk readability
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Build image content dengan AspectRatio
  /// AspectRatio memastikan proporsi gambar tetap terjaga
  Widget _buildImageContent() {
    return AspectRatio(
      // Aspect ratio dari photo model (default 1.0 untuk square)
      aspectRatio: photo.aspectRatio,
      child: Image.asset(
        photo.assetPath,
        // BoxFit.cover untuk fill container tanpa distortion
        // Image akan di-crop jika aspect ratio tidak match
        fit: BoxFit.cover,
        // Alignment saat image di-crop
        alignment: Alignment.center,
        // Error builder untuk handle missing image
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        // Frame builder untuk loading state
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          // Jika loading selesai, tampilkan image
          if (wasSynchronouslyLoaded) {
            return child;
          }
          // Jika masih loading, tampilkan dengan fade animation
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: child,
          );
        },
      ),
    );
  }

  /// Build placeholder untuk error atau loading state
  Widget _buildPlaceholder() {
    return Container(
      color: photo.accentColor.withOpacity(0.2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 48,
              color: photo.accentColor,
            ),
            const SizedBox(height: 8),
            Text(
              'Image not found',
              style: TextStyle(
                color: photo.accentColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Memphis decoration overlay
  /// Geometric shapes sebagai accent decoration
  Widget _buildMemphisDecoration() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: photo.accentColor,
          shape: BoxShape.circle,
          // Box shadow untuk depth
          boxShadow: [
            BoxShadow(
              color: photo.accentColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  /// Calculate parallax offset berdasarkan scroll position
  /// Formula parallax: (itemPosition - screenCenter) * parallaxStrength
  double _calculateParallaxOffset() {
    try {
      // Dapatkan RenderBox dari widget ini menggunakan imageKey
      final RenderBox? renderBox = 
          imageKey.currentContext?.findRenderObject() as RenderBox?;
      
      if (renderBox == null) return 0.0;

      // Dapatkan posisi global widget di layar
      final position = renderBox.localToGlobal(Offset.zero);
      
      // Dapatkan ukuran widget
      final size = renderBox.size;
      
      // Dapatkan ukuran layar
      final screenHeight = 
          imageKey.currentContext?.findRenderObject()?.paintBounds.height ?? 0;
      
      // Hitung center point widget
      final itemCenter = position.dy + (size.height / 2);
      
      // Hitung center point layar
      final screenCenter = screenHeight / 2;
      
      // Hitung distance dari center
      final distanceFromCenter = itemCenter - screenCenter;
      
      // Parallax strength - mengontrol seberapa kuat effect-nya
      // Nilai kecil = effect subtle, nilai besar = effect dramatic
      const parallaxStrength = 0.1;
      
      // Calculate offset dengan formula parallax
      // Negative multiplier membuat image bergerak berlawanan arah scroll
      return -distanceFromCenter * parallaxStrength;
      
    } catch (e) {
      // Return 0 jika terjadi error dalam calculation
      return 0.0;
    }
  }
}