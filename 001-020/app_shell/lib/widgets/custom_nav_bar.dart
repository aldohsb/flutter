import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';

class NavDestinationItem {
  // Class sederhana sebagai model satu item tab navigasi
  // Bukan Widget — hanya data: ikon, label, warna
  final IconData icon;
  final IconData selectedIcon;
  // selectedIcon: ikon yang tampil saat tab ini aktif (biasanya versi solid/filled)
  final String label;
  final Color color;
  // Setiap tab punya warna aksen tersendiri

  const NavDestinationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.color,
  });
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  // Index tab yang sedang aktif — dikontrol dari parent (ShellScreen)

  final void Function(int) onTabSelected;
  // void Function(int) = tipe fungsi yang menerima satu int dan tidak return nilai
  // Dipanggil saat user tap tab, mengirimkan index tab yang dipilih ke parent

  static const List<NavDestinationItem> destinations = [
    // Definisi keempat tab — static const agar tidak dibuat ulang setiap build
    NavDestinationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      // home_rounded: varian lebih tebal dan bulat untuk state aktif
      label: 'Home',
      color: AppColors.primary,
    ),
    NavDestinationItem(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search_rounded,
      label: 'Search',
      color: Color(0xFF00BCD4),
      // Cyan — berbeda dari primary untuk variasi visual antar tab
    ),
    NavDestinationItem(
      icon: Icons.favorite_outline_rounded,
      selectedIcon: Icons.favorite_rounded,
      label: 'Favorite',
      color: Color(0xFFFF5252),
      // Merah — universal untuk favorite/love
    ),
    NavDestinationItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
      color: Color(0xFFFFB300),
      // Amber — warna hangat untuk profil
    ),
  ];

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container pembungkus untuk memberi shadow dan warna background kustom
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
          // Hanya border atas — garis pemisah tipis antara body dan nav bar
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 20,
            offset: const Offset(0, -4),
            // Offset negatif Y = shadow ke ATAS — mengangkat nav bar dari bawah
          ),
        ],
      ),
      child: SafeArea(
        // SafeArea khusus untuk NavigationBar — penting di iPhone dengan home indicator
        // Tanpa ini, ikon tab bisa tertutup oleh home indicator bar iOS
        top: false,
        // top: false = SafeArea hanya berlaku di bawah (bottom), tidak di atas
        child: SizedBox(
          height: 60,
          // Tinggi nav bar yang diinginkan (sebelum SafeArea padding)
          child: Row(
            // Row berisi empat tab berjajar — tidak pakai NavigationBar widget bawaan
            // karena kita mau styling penuh dengan warna berbeda per tab
            children: List.generate(destinations.length, (index) {
              // List.generate: buat List berisi widget untuk setiap index
              // Alternatif .map() tapi lebih cocok saat butuh index
              return _buildNavItem(index);
              // Buat satu item tab untuk index ini
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final NavDestinationItem dest = destinations[index];
    // Ambil data tab berdasarkan index
    final bool isSelected = index == selectedIndex;
    // Cek apakah tab ini yang sedang aktif
    final Color itemColor = isSelected ? dest.color : AppColors.textMuted;
    // Warna ikon dan teks: warna aksen jika aktif, abu-abu jika tidak

    return Expanded(
      // Expanded: setiap tab mendapat lebar yang sama (total lebar / 4)
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        // onTap: panggil callback dengan index tab yang ditap
        // () => onTabSelected(index) adalah arrow function tanpa parameter
        behavior: HitTestBehavior.opaque,
        // opaque: area tap mencakup seluruh Expanded, termasuk ruang kosong
        // Tanpa ini, area yang bisa ditap hanya sekitar ikon/teks (kecil)
        child: AnimatedContainer(
          // AnimatedContainer: transisi smooth saat properti berubah
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                // AnimatedSwitcher: animasi saat child berubah (ikon outline → filled)
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  // transitionBuilder: tentukan jenis animasi transisi
                  return ScaleTransition(scale: animation, child: child);
                  // ScaleTransition: child baru muncul dengan efek membesar
                },
                child: Icon(
                  isSelected ? dest.selectedIcon : dest.icon,
                  // Pilih ikon berdasarkan state aktif/tidak
                  key: ValueKey(isSelected),
                  // ValueKey penting untuk AnimatedSwitcher!
                  // Tanpa key, AnimatedSwitcher tidak tahu bahwa child sudah berganti
                  // ValueKey(isSelected): key berubah saat isSelected berubah → animasi dipicu
                  size: 24,
                  color: itemColor,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                // AnimatedDefaultTextStyle: animasi perubahan style teks
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.poppins(
                  fontSize: isSelected ? 11 : 10,
                  // Teks sedikit lebih besar saat aktif — detail kecil yang terasa
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: itemColor,
                ),
                child: Text(dest.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                // Indikator titik di bawah teks — hanya muncul saat tab aktif
                duration: const Duration(milliseconds: 250),
                width: isSelected ? 16 : 0,
                // Width 16 jika aktif, 0 jika tidak — animasi "muncul dari nol"
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected ? itemColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}