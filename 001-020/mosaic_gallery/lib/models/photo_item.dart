import 'package:flutter/material.dart';

/// PhotoItem - Model data untuk setiap item foto dalam gallery
/// Model ini merepresentasikan struktur data foto yang akan ditampilkan
/// Menggunakan immutable pattern untuk keamanan data
class PhotoItem {
  // === PROPERTIES ===
  
  /// ID unik untuk setiap foto
  /// Berguna untuk key pada ListView/GridView
  final String id;
  
  /// Path asset gambar (misalnya: 'assets/images/photo1.jpg')
  /// Pastikan path ini sesuai dengan file di pubspec.yaml
  final String assetPath;
  
  /// Judul atau nama foto
  final String title;
  
  /// Warna accent untuk Memphis design decoration
  /// Setiap foto bisa memiliki warna accent yang berbeda
  final Color accentColor;
  
  /// Aspect ratio foto (lebar / tinggi)
  /// Default 1.0 untuk square, bisa diubah untuk portrait/landscape
  final double aspectRatio;

  // === CONSTRUCTOR ===
  
  /// Constructor dengan named parameters
  /// Required: id, assetPath, title, accentColor
  /// Optional: aspectRatio (default 1.0)
  const PhotoItem({
    required this.id,
    required this.assetPath,
    required this.title,
    required this.accentColor,
    this.aspectRatio = 1.0, // Default square ratio
  });

  // === COPY WITH METHOD ===
  
  /// Method untuk membuat copy object dengan modifikasi tertentu
  /// Berguna untuk state management dan immutability
  PhotoItem copyWith({
    String? id,
    String? assetPath,
    String? title,
    Color? accentColor,
    double? aspectRatio,
  }) {
    return PhotoItem(
      id: id ?? this.id,
      assetPath: assetPath ?? this.assetPath,
      title: title ?? this.title,
      accentColor: accentColor ?? this.accentColor,
      aspectRatio: aspectRatio ?? this.aspectRatio,
    );
  }

  // === EQUALITY & HASH CODE ===
  
  /// Override equality untuk comparison
  /// Dua PhotoItem dianggap sama jika id-nya sama
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is PhotoItem && other.id == id;
  }

  /// Override hashCode untuk konsistensi dengan equality
  @override
  int get hashCode => id.hashCode;

  // === TO STRING ===
  
  /// Override toString untuk debugging
  @override
  String toString() {
    return 'PhotoItem(id: $id, title: $title, assetPath: $assetPath)';
  }

  // === FACTORY METHODS ===
  
  /// Factory method untuk membuat list dummy photos
  /// Berguna untuk testing dan development
  /// Di production, data ini bisa berasal dari API atau database
  static List<PhotoItem> getDummyPhotos() {
    return [
      // Row 1 - Warna warm
      const PhotoItem(
        id: '1',
        assetPath: 'assets/images/photo1.jpg',
        title: 'Sunset Vibes',
        accentColor: Color(0xFFFF006E), // Pink
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '2',
        assetPath: 'assets/images/photo2.jpg',
        title: 'Urban Dreams',
        accentColor: Color(0xFFFFBE0B), // Yellow
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '3',
        assetPath: 'assets/images/photo3.jpg',
        title: 'Nature Calm',
        accentColor: Color(0xFF06FFA5), // Mint
        aspectRatio: 1.0,
      ),
      
      // Row 2 - Warna cool
      const PhotoItem(
        id: '4',
        assetPath: 'assets/images/photo4.jpg',
        title: 'Ocean Breeze',
        accentColor: Color(0xFF00D9FF), // Cyan
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '5',
        assetPath: 'assets/images/photo5.jpg',
        title: 'Mountain High',
        accentColor: Color(0xFF8338EC), // Purple
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '6',
        assetPath: 'assets/images/photo6.jpg',
        title: 'City Lights',
        accentColor: Color(0xFFFF6B35), // Orange
        aspectRatio: 1.0,
      ),
      
      // Row 3 - Mix colors
      const PhotoItem(
        id: '7',
        assetPath: 'assets/images/photo7.jpg',
        title: 'Desert Mirage',
        accentColor: Color(0xFF3A86FF), // Electric Blue
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '8',
        assetPath: 'assets/images/photo8.jpg',
        title: 'Forest Path',
        accentColor: Color(0xFFFF5A5F), // Coral
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '9',
        assetPath: 'assets/images/photo9.jpg',
        title: 'Sky Above',
        accentColor: Color(0xFFFF006E), // Pink
        aspectRatio: 1.0,
      ),
      
      // Tambahan untuk scrolling
      const PhotoItem(
        id: '10',
        assetPath: 'assets/images/photo1.jpg', // Reuse
        title: 'Dawn Light',
        accentColor: Color(0xFFFFBE0B), // Yellow
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '11',
        assetPath: 'assets/images/photo2.jpg', // Reuse
        title: 'Night Sky',
        accentColor: Color(0xFF8338EC), // Purple
        aspectRatio: 1.0,
      ),
      const PhotoItem(
        id: '12',
        assetPath: 'assets/images/photo3.jpg', // Reuse
        title: 'River Flow',
        accentColor: Color(0xFF06FFA5), // Mint
        aspectRatio: 1.0,
      ),
    ];
  }
}