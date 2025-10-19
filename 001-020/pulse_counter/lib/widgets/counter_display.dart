import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

/// CounterDisplay - Widget untuk menampilkan angka counter dengan animasi
/// 
/// Widget ini menampilkan angka dengan:
/// - Heartbeat animation effect saat nilai berubah
/// - Typography brutalist dengan font tebal
/// - Border tegas dengan sudut tajam
class CounterDisplay extends StatefulWidget {
  /// Nilai counter yang akan ditampilkan
  final int count;

  /// Constructor dengan required parameter count
  /// const constructor untuk optimization
  const CounterDisplay({
    super.key,
    required this.count,
  });

  @override
  State<CounterDisplay> createState() => _CounterDisplayState();
}

/// State class dengan underscore = private class
/// Hanya bisa diakses dalam file ini
class _CounterDisplayState extends State<CounterDisplay>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin: mixin untuk animation controller
  // Diperlukan untuk membuat dan mengontrol animasi

  /// Animation controller - mengontrol timing dan status animasi
  /// late keyword: variable akan diinisialisasi sebelum digunakan
  /// underscore: private variable
  late AnimationController _animationController;

  /// Animation untuk scale effect - mengubah ukuran widget
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // initState dipanggil sekali saat widget pertama kali dibuat

    // Inisialisasi animation controller
    _animationController = AnimationController(
      // Duration: lamanya animasi (heartbeat singkat)
      duration: const Duration(milliseconds: 200),
      // vsync: this (dari SingleTickerProviderStateMixin)
      // Mengoptimalkan animasi dengan sync ke refresh rate layar
      vsync: this,
    );

    // Membuat tween animation untuk scale
    // Tween: interpolasi dari nilai awal ke nilai akhir
    _scaleAnimation = Tween<double>(
      begin: 1.0, // Ukuran normal
      end: 1.15, // Ukuran membesar 15%
    ).animate(
      // CurvedAnimation: menambahkan easing curve
      CurvedAnimation(
        parent: _animationController,
        // elasticOut: bouncing effect seperti heartbeat
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(CounterDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // didUpdateWidget: dipanggil saat widget di-rebuild dengan data baru

    // Cek apakah nilai count berubah
    if (widget.count != oldWidget.count) {
      // Trigger animasi heartbeat
      _animationController.forward(from: 0.0);
      // forward: menjalankan animasi dari awal (0.0) ke akhir (1.0)
    }
  }

  @override
  void dispose() {
    // dispose: cleanup saat widget dihapus dari tree
    // PENTING: selalu dispose controller untuk mencegah memory leak
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container dengan border tebal untuk brutalist design
      decoration: BoxDecoration(
        // Background putih
        color: AppColors.white,
        // Border hitam tebal
        border: Border.all(
          color: AppColors.black,
          width: 6, // Border sangat tebal
        ),
        // BorderRadius.zero: sudut tajam 90 derajat
        borderRadius: BorderRadius.zero,
      ),
      
      // Padding untuk spacing internal
      padding: const EdgeInsets.symmetric(
        horizontal: 48, // Horizontal padding
        vertical: 32, // Vertical padding
      ),
      
      // ScaleTransition: widget untuk animasi scale
      child: ScaleTransition(
        // scale: property yang di-animate
        scale: _scaleAnimation,
        
        child: Text(
          // Konversi int ke string untuk ditampilkan
          '${widget.count}',
          
          // Text style dari theme
          style: AppTheme.counterTextStyle,
          
          // Text align center
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}