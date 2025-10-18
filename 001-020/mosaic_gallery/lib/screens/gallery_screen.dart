import 'package:flutter/material.dart';
import '../models/photo_item.dart';
import '../widgets/parallax_image_card.dart';
import '../widgets/memphis_background.dart';
import '../utils/grid_calculator.dart';
import '../config/app_colors.dart';

/// GalleryScreen - Main screen aplikasi dengan grid gallery
/// Menggunakan GridView.builder untuk performa optimal
/// Implements parallax scroll effect dan Memphis design
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // === STATE VARIABLES ===
  
  /// ScrollController untuk tracking scroll position
  /// Diperlukan untuk parallax effect
  late ScrollController _scrollController;
  
  /// List data photos
  late List<PhotoItem> _photos;
  
  /// Map untuk menyimpan GlobalKey setiap image
  /// Key: photo id, Value: GlobalKey
  /// Diperlukan untuk mendapatkan posisi setiap image di layar
  final Map<String, GlobalKey> _imageKeys = {};

  @override
  void initState() {
    super.initState();
    
    // Initialize scroll controller
    _scrollController = ScrollController();
    
    // Load photos data
    _photos = PhotoItem.getDummyPhotos();
    
    // Generate GlobalKey untuk setiap photo
    for (final photo in _photos) {
      _imageKeys[photo.id] = GlobalKey();
    }
  }

  @override
  void dispose() {
    // Dispose controller saat widget di-destroy
    // Penting untuk mencegah memory leak
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // === APP BAR ===
      // Custom app bar dengan gradient background
      appBar: _buildAppBar(context),
      
      // === BODY ===
      // Wrap dengan MemphisBackground untuk geometric shapes
      body: MemphisBackground(
        child: _buildGridGallery(context),
      ),
    );
  }

  /// Build custom app bar dengan gradient
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      // FlexibleSpace untuk custom background
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          // Gradient dari cyan ke purple (Memphis style)
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cyan,
              AppColors.purple,
            ],
          ),
        ),
      ),
      // Title dengan custom styling
      title: Row(
        children: [
          // Icon geometric sebagai accent
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              color: AppColors.purple,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Title text
          const Text(
            'MosaicGallery',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      // Actions - info button
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onPressed: () => _showInfoDialog(context),
          tooltip: 'Info',
        ),
      ],
      elevation: 0,
    );
  }

  /// Build grid gallery menggunakan GridView.builder
  Widget _buildGridGallery(BuildContext context) {
    // Calculate grid parameters menggunakan GridCalculator
    final int crossAxisCount = GridCalculator.calculateCrossAxisCount(context);
    final double spacing = GridCalculator.calculateSpacing(context);
    final double aspectRatio = GridCalculator.calculateChildAspectRatio(context);

    return GridView.builder(
      // === GRID CONFIGURATION ===
      
      // Controller untuk scroll tracking (parallax effect)
      controller: _scrollController,
      
      // Padding di sekeliling grid
      padding: GridCalculator.getResponsivePadding(context),
      
      // Grid delegate - mengatur layout grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Jumlah kolom (dinamis berdasarkan lebar layar)
        crossAxisCount: crossAxisCount,
        
        // Spacing horizontal antar items
        crossAxisSpacing: spacing,
        
        // Spacing vertical antar items
        mainAxisSpacing: spacing,
        
        // Aspect ratio setiap item (width/height)
        // 1.0 = square, >1.0 = landscape, <1.0 = portrait
        childAspectRatio: aspectRatio,
      ),
      
      // === ITEM BUILDER ===
      
      // Jumlah total items
      itemCount: _photos.length,
      
      // Builder function untuk setiap item
      // index: posisi item dalam list (0, 1, 2, ...)
      itemBuilder: (context, index) {
        // Ambil data photo berdasarkan index
        final photo = _photos[index];
        
        // Ambil GlobalKey untuk photo ini
        final imageKey = _imageKeys[photo.id]!;
        
        // Return ParallaxImageCard dengan animation
        return _buildAnimatedCard(
          photo: photo,
          imageKey: imageKey,
          index: index,
        );
      },
      
      // === PERFORMANCE OPTIMIZATION ===
      
      // Physics untuk smooth scrolling
      physics: const BouncingScrollPhysics(),
      
      // Cache extent - berapa banyak item di-cache di luar viewport
      // Meningkatkan performa saat scroll cepat
      cacheExtent: 500,
    );
  }

  /// Build card dengan entrance animation
  /// Staggered animation berdasarkan index untuk effect menarik
  Widget _buildAnimatedCard({
    required PhotoItem photo,
    required GlobalKey imageKey,
    required int index,
  }) {
    // Delay animation berdasarkan index
    // Item pertama muncul duluan, lalu item berikutnya
    final delay = Duration(milliseconds: 50 * index);
    
    return TweenAnimationBuilder<double>(
      // Tween dari 0 ke 1 (invisible ke visible)
      tween: Tween(begin: 0.0, end: 1.0),
      
      // Duration animation
      duration: const Duration(milliseconds: 500),
      
      // Delay berdasarkan index
      // Note: Delay hanya bekerja saat widget pertama kali dibuild
      curve: Curves.easeOutCubic,
      
      // Builder menerima animation value
      builder: (context, value, child) {
        return Transform.scale(
          // Scale dari 0.8 ke 1.0 (zoom in effect)
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            // Opacity dari 0 ke 1 (fade in effect)
            opacity: value,
            child: child,
          ),
        );
      },
      
      // Child adalah ParallaxImageCard
      child: ParallaxImageCard(
        photo: photo,
        imageKey: imageKey,
        scrollController: _scrollController,
      ),
    );
  }

  /// Show info dialog dengan penjelasan app
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Custom shape dengan rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // Title dengan gradient background
        title: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppColors.cyanPurpleGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'About MosaicGallery',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        // Content
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem(
              icon: Icons.grid_on,
              title: 'Responsive Grid',
              description: 'Grid menyesuaikan jumlah kolom berdasarkan ukuran layar',
            ),
            const SizedBox(height: 12),
            _buildInfoItem(
              icon: Icons.animation,
              title: 'Parallax Effect',
              description: 'Gambar bergerak dengan efek parallax saat scroll',
            ),
            const SizedBox(height: 12),
            _buildInfoItem(
              icon: Icons.palette,
              title: 'Memphis Design',
              description: 'Geometric shapes dan bold colors khas tahun 80an',
            ),
          ],
        ),
        // Action button
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  /// Build info item untuk dialog
  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.cyan, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}