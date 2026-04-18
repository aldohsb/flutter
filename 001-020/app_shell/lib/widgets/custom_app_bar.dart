import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // implements PreferredSizeWidget — interface yang wajib diimplementasikan
  // agar widget ini bisa dipakai sebagai nilai 'appBar:' di Scaffold
  // Interface mengharuskan kita menyediakan getter 'preferredSize'

  final String title;
  final List<Widget>? actions;
  // actions opsional — tidak semua halaman butuh ikon di kanan AppBar
  final Widget? leading;
  // leading opsional — jika null, Scaffold akan isi sendiri (back button atau menu)
  final bool centerTitle;
  final VoidCallback? onNotificationTap;
  // VoidCallback = tipe fungsi yang tidak menerima parameter dan tidak return nilai
  // Dipakai untuk fungsi event handler seperti onTap, onPressed

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    // default value true — judul di tengah kecuali ada yang ubah
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // preferredSize — wajib diimplementasikan karena PreferredSizeWidget
  // Memberi tahu Scaffold seberapa tinggi AppBar ini
  // kToolbarHeight = 56.0 (konstanta standar Material Design)
  // Size.fromHeight(56) = lebar tak terbatas, tinggi 56px

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: centerTitle,
      leading: leading,
      // Jika leading null, Scaffold isi otomatis (ikon back jika ada halaman sebelumnya)
      actions: actions ?? [_buildNotificationButton()],
      // ?? = jika actions null, gunakan list default berisi ikon notifikasi
      // Jika caller menyediakan actions, pakai itu — jika tidak, pakai default
      backgroundColor: AppColors.backgroundCard,
      foregroundColor: AppColors.textPrimary,
      // foregroundColor: warna default untuk teks dan ikon di dalam AppBar
      elevation: 0,
      // elevation 0 = tidak ada shadow — AppBar menyatu dengan body
      scrolledUnderElevation: 4,
      // Elevation yang muncul saat konten body di-scroll ke bawah AppBar
      // Memberi kesan kedalaman yang dinamis
      surfaceTintColor: Colors.transparent,
      // surfaceTintColor Material 3 kadang menambahkan tint warna pada AppBar
      // transparent = matikan tint agar warna AppBar persis seperti yang kita set
      bottom: PreferredSize(
        // bottom: area di bawah AppBar (masih bagian dari AppBar, bukan body)
        // PreferredSize: wrapper yang mendefinisikan tinggi widget khusus ini
        preferredSize: const Size.fromHeight(1),
        // Tinggi 1px — hanya untuk garis tipis di bawah AppBar
        child: Container(height: 1, color: AppColors.divider),
        // Garis pemisah tipis antara AppBar dan body
      ),
    );
  }

  Widget _buildNotificationButton() {
    // Method private — hanya dipakai di dalam class ini
    // Membangun ikon notifikasi dengan badge merah
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      // Padding kanan 8px agar ikon tidak terlalu mepet ke tepi layar
      child: Stack(
        // Stack: ikon notifikasi (bawah) + badge merah (atas)
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            // notifications_outlined: varian outline — lebih ringan secara visual
            iconSize: 24,
            color: AppColors.textSecondary,
            onPressed: onNotificationTap,
            // Panggil callback yang diterima dari parameter constructor
          ),
          Positioned(
            // Badge titik merah di pojok kanan atas ikon
            top: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade400,
                // Merah — warna universal untuk notifikasi/badge yang perlu diperhatikan
                border: Border.all(
                  color: AppColors.backgroundCard,
                  width: 1.5,
                  // Border berwarna sama dengan background AppBar
                  // Menciptakan efek "gap" antara badge dan ikon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}