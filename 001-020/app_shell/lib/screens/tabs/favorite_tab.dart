import 'package:flutter/material.dart';
import '../../widgets/tab_placeholder.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholder(
      icon: Icons.favorite_rounded,
      title: 'Favorite',
      description: 'Koleksi item favorit kamu.\nSimpan dan akses konten yang kamu sukai.',
      accentColor: Color(0xFFFF5252),
      // Warna merah — konsisten dengan warna tab di CustomNavBar
    );
  }
}