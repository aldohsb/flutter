import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_nav_bar.dart';
import 'tabs/home_tab.dart';
import 'tabs/search_tab.dart';
import 'tabs/favorite_tab.dart';
import 'tabs/profile_tab.dart';

class ShellScreen extends StatefulWidget {
  // StatefulWidget karena menyimpan _currentIndex yang berubah saat user tap tab
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentIndex = 0;
  // State tunggal: index tab yang sedang aktif
  // 0 = Home, 1 = Search, 2 = Favorite, 3 = Profile

  static const List<Widget> _pages = [
    // static const: list halaman tidak dibuat ulang setiap rebuild
    // Urutan harus sama persis dengan urutan destinasi di CustomNavBar
    HomeTab(),
    SearchTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  static const List<String> _titles = [
    // Judul AppBar untuk setiap tab — index harus sesuai dengan _pages
    'Home',
    'Search',
    'Favorite',
    'Profile',
  ];

  void _onTabSelected(int index) {
    // void function — tidak mengembalikan nilai
    // Dipanggil oleh CustomNavBar saat user tap tab
    if (index == _currentIndex) return;
    // Early return: jika tap tab yang sama, tidak perlu setState
    // Optimisasi kecil tapi penting untuk menghindari rebuild yang tidak perlu

    HapticFeedback.lightImpact();
    // Feedback getaran ringan saat ganti tab — meningkatkan feel responsivitas
    // Hanya terasa di HP asli, tidak di emulator

    setState(() => _currentIndex = index);
    // setState: update _currentIndex dan trigger rebuild
    // Arrow function setState: untuk perubahan state satu baris
  }

  void _onNotificationTap() {
    // void function untuk handle tap ikon notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      // ScaffoldMessenger: cara standar menampilkan Snackbar di Flutter
      // .of(context): akses ScaffoldMessenger dari Scaffold terdekat di widget tree
      SnackBar(
        content: Text(
          'Tidak ada notifikasi baru',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: AppColors.backgroundCard,
        behavior: SnackBarBehavior.floating,
        // floating: Snackbar melayang di atas konten, tidak menempel di bawah layar
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Bentuk Snackbar: sudut melengkung
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onFabPressed() {
    // void function untuk handle tap FAB
    showModalBottomSheet(
      // showModalBottomSheet: tampilkan panel dari bawah layar
      context: context,
      backgroundColor: Colors.transparent,
      // transparent: hilangkan background default agar container kustom terlihat
      builder: (context) => _buildFabBottomSheet(),
      // builder: fungsi yang mengembalikan widget konten bottom sheet
    );
  }

  Widget _buildFabBottomSheet() {
    // Method yang mengembalikan Widget — bukan void function
    // Membangun konten bottom sheet saat FAB ditekan
    return Container(
      margin: const EdgeInsets.all(16),
      // margin dari tepi layar — memberikan jarak dari sisi kiri, kanan, bawah
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // min: Column hanya setinggi kontennya — penting di bottom sheet
        // Tanpa ini Column akan mencoba mengisi seluruh tinggi layar
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Handle bar — indikator visual bahwa panel ini bisa di-drag ke bawah

          const SizedBox(height: 20),

          Text(
            'Aksi Cepat',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Pilih aksi yang ingin dilakukan',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              _buildQuickAction(
                icon: Icons.add_photo_alternate_outlined,
                label: 'Upload',
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              _buildQuickAction(
                icon: Icons.edit_outlined,
                label: 'Tulis',
                color: const Color(0xFF00BCD4),
              ),
              const SizedBox(width: 12),
              _buildQuickAction(
                icon: Icons.share_outlined,
                label: 'Bagikan',
                color: const Color(0xFFFF5252),
              ),
              const SizedBox(width: 12),
              _buildQuickAction(
                icon: Icons.bookmark_outline_rounded,
                label: 'Simpan',
                color: const Color(0xFFFFB300),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    // Named parameters dengan {} — semua required karena tidak ada default value
    // Method membangun satu tombol aksi cepat di bottom sheet
    return Expanded(
      // Expanded: setiap tombol mendapat lebar yang sama
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        // Navigator.pop: tutup bottom sheet saat tombol aksi ditap
        // context diperlukan Navigator untuk menemukan Navigator terdekat di widget tree
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.12),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      // ── APP BAR ──────────────────────────────────────────────
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        // Judul berubah mengikuti tab yang aktif
        // _titles[0] = 'Home', _titles[1] = 'Search', dst.
        onNotificationTap: _onNotificationTap,
        // Teruskan fungsi handler ke CustomAppBar
      ),

      // ── BODY ─────────────────────────────────────────────────
      body: IndexedStack(
        // IndexedStack: tampilkan hanya child di index yang aktif
        // Semua child tetap di memori — state (scroll position, data) tidak hilang
        // Berbeda dari _pages[_currentIndex] yang dispose halaman tidak aktif
        index: _currentIndex,
        children: _pages,
        // _pages berisi keempat widget tab yang sudah dibuat
      ),

      // ── FLOATING ACTION BUTTON ────────────────────────────────
      floatingActionButton: _buildFab(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // centerFloat: FAB melayang di tengah bawah layar (di atas NavigationBar)
      // Alternatif lain:
      //   endFloat: pojok kanan bawah (default)
      //   centerDocked: tengah, menempel ke BottomAppBar dengan notch
      //   endDocked: pojok kanan, menempel ke BottomAppBar

      // ── BOTTOM NAVIGATION BAR ─────────────────────────────────
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _currentIndex,
        // Teruskan index aktif ke CustomNavBar agar tab yang benar di-highlight
        onTabSelected: _onTabSelected,
        // Teruskan fungsi handler — CustomNavBar memanggil ini saat user tap tab
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      // Bungkus FAB dalam Container untuk shadow kustom yang lebih dramatis
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryGlow,
            // Glow cyan sesuai warna FAB
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: _onFabPressed,
        // Panggil method _onFabPressed saat FAB ditap
        backgroundColor: AppColors.secondary,
        // Warna cyan — kontras dengan ungu untuk menonjol
        foregroundColor: Colors.white,
        // Warna ikon di dalam FAB
        elevation: 0,
        // elevation 0: kita sudah buat shadow sendiri di Container luar
        shape: const CircleBorder(),
        // CircleBorder: pastikan FAB berbentuk lingkaran sempurna
        // Material 3 kadang membuat FAB sedikit persegi panjang — ini menormalkannya
        child: const Icon(Icons.add_rounded, size: 28),
        // Icon lebih besar dari default (24) — FAB adalah focal point UI
      ),
    );
  }
}