import 'package:flutter/material.dart';
import '../../widgets/tab_placeholder.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholder(
      icon: Icons.search_rounded,
      title: 'Search',
      description: 'Temukan apa yang kamu cari.\nFitur pencarian dan filter akan hadir di sini.',
      accentColor: Color(0xFF00BCD4),
      // Warna cyan — konsisten dengan warna tab di CustomNavBar
    );
  }
}