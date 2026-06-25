// lib/widgets/clay_button.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ClayButton extends StatefulWidget {
  // Teks yang ditampilkan di dalam tombol
  final String label;

  // Ikon opsional di sebelah kiri teks
  final IconData? icon;

  // Warna utama permukaan tombol (warna clay-nya)
  final Color color;

  // Warna shadow bawah — menciptakan efek "tebal" 3D
  final Color shadowColor;

  // Callback saat tombol ditekan; null = tombol nonaktif
  final VoidCallback? onPressed;

  // Lebar tombol; null = menyesuaikan konten
  final double? width;

  // Tinggi tombol; ada nilai default
  final double height;

  // Ukuran sudut melengkung tombol
  final double borderRadius;

  // Apakah tombol sedang dalam kondisi loading?
  final bool isLoading;

  const ClayButton({
    super.key,
    required this.label,
    required this.color,
    required this.shadowColor,
    this.icon,
    this.onPressed,
    this.width,
    this.height = 54,
    this.borderRadius = 20,
    this.isLoading = false,
  });

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin menyediakan "ticker" untuk animasi
  // Ticker = jantung animasi yang berdetak setiap frame (60fps)

  late AnimationController _controller;
  // 'late' = dijamin diisi sebelum dipakai, tapi tidak di konstruktor

  late Animation<double> _pressAnimation;
  // Animation<double> menghasilkan nilai desimal yang berubah seiring waktu

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 80),
      // Durasi sangat singkat = respons tap terasa instan dan snappy
      vsync: this,
      // vsync = sinkronisasi dengan refresh rate layar, hemat baterai
    );

    _pressAnimation = Tween<double>(begin: 0, end: 1).animate(
      // Tween = interpolasi nilai dari 'begin' ke 'end'
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      // CurvedAnimation memberi kurva (percepatan) pada animasi linear
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // dispose() WAJIB dipanggil untuk membebaskan resource animasi
    // Tanpa ini: memory leak (animasi terus berjalan di background)
    super.dispose();
  }

  // Dipanggil saat jari menekan tombol
  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed == null || widget.isLoading) return;
    // Guard: tidak ada aksi jika tombol nonaktif atau loading

    _controller.forward();
    // forward() = animasi dari begin (0) ke end (1) = tombol "tertekan ke bawah"

    HapticFeedback.lightImpact();
    // Getaran ringan di Android/iOS — memberi feedback fisik kepada user
  }

  // Dipanggil saat jari diangkat (dengan atau tanpa keluar area tombol)
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    // reverse() = animasi dari end (1) kembali ke begin (0) = tombol "naik lagi"
  }

  void _onTapCancel() {
    _controller.reverse();
    // Cancel = jari geser keluar sebelum lepas; tombol tetap kembali ke posisi awal
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;
    // Kondisi nonaktif: tidak ada callback ATAU sedang loading

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: isDisabled ? null : widget.onPressed,
      // onTap null = GestureDetector tidak merespons tap sama sekali

      child: AnimatedBuilder(
        animation: _pressAnimation,
        // AnimatedBuilder rebuild child setiap kali _pressAnimation berubah nilai

        builder: (context, child) {
          final press = _pressAnimation.value;
          // press = 0.0 (tidak ditekan) sampai 1.0 (ditekan penuh)

          return Container(
            width: widget.width,
            height: widget.height,

            decoration: BoxDecoration(
              color: isDisabled
                  ? AppColors.border
                  : widget.color,
              // Warna abu-abu saat nonaktif, warna clay saat aktif

              borderRadius: BorderRadius.circular(widget.borderRadius),

              boxShadow: isDisabled
                  ? []
                  // Tidak ada shadow saat nonaktif (terlihat "flat/datar")
                  : [
                      BoxShadow(
                        color: widget.shadowColor,
                        offset: Offset(0, 6 - (press * 5)),
                        // Saat ditekan (press=1): offset = 6-(1×5) = 1px → hampir hilang
                        // Saat lepas  (press=0): offset = 6-(0×5) = 6px → penuh
                        // Ini efek "tombol masuk ke dalam" saat ditekan!
                        blurRadius: 0,
                        // blurRadius 0 = shadow tegas, bukan blur — khas clay
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.85),
                        offset: Offset(0, -2 + (press * 2)),
                        // Highlight atas juga bergerak saat ditekan
                        blurRadius: 5,
                      ),
                    ],
            ),

            // Transform.translate menggeser posisi visual tanpa menggeser layout
            child: Transform.translate(
              offset: Offset(0, press * 5),
              // Saat ditekan, konten bergerak ke bawah sejauh shadownya mengecil
              // Ini menciptakan ilusi tombol "masuk ke permukaan"

              child: child,
              // child sudah di-build di luar builder (lebih efisien)
            ),
          );
        },

        // child di sini di-build SEKALI, tidak ikut rebuild setiap frame animasi
        child: _buildContent(isDisabled),
      ),
    );
  }

  Widget _buildContent(bool isDisabled) {
    return Center(
      child: widget.isLoading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: isDisabled
                    ? AppColors.textHint
                    : AppColors.textOnClay,
              ),
            )
          // Tampilkan spinner saat loading, teks saat tidak

          : Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisSize.min = Row hanya selebar kontennya, tidak full width

              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 20,
                    color: isDisabled
                        ? AppColors.textHint
                        : AppColors.textOnClay,
                  ),
                  const SizedBox(width: 8),
                ],
                // '...' spread: masukkan list [Icon, SizedBox] ke dalam list children

                Text(
                  widget.label,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isDisabled
                        ? AppColors.textHint
                        : AppColors.textOnClay,
                  ),
                ),
              ],
            ),
    );
  }
}