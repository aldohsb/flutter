import 'package:flutter/material.dart';
import '../../widgets/tab_placeholder.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabPlaceholder(
      icon: Icons.person_rounded,
      title: 'Profile',
      description: 'Halaman profil pengguna.\nPengaturan akun dan preferensi ada di sini.',
      accentColor: Color(0xFFFFB300),
      // Warna amber — konsisten dengan warna tab di CustomNavBar
    );
  }
}