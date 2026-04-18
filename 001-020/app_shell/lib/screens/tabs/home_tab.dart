import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/tab_placeholder.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholder(
      icon: Icons.home_rounded,
      title: 'Home',
      description: 'Halaman utama aplikasi.\nKonten feed dan rekomendasi akan ditampilkan di sini.',
      accentColor: AppColors.primary,
    );
  }
}