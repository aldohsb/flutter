import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Widget untuk membuat background dengan gradient synthwave
/// 
/// StatelessWidget karena background tidak perlu berubah state
/// Widget ini reusable dan bisa dipakai di berbagai screen
class GradientBackground extends StatelessWidget {
  /// Child widget yang akan ditampilkan di atas background
  final Widget child;

  /// Constructor dengan required parameter child
  /// 
  /// {required this.child} adalah named parameter yang wajib diisi
  /// super.key diteruskan ke parent class (StatelessWidget)
  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Container: widget dasar untuk styling dan layout
    return Container(
      // width: lebar container (double.infinity = selebar layar)
      width: double.infinity,
      
      // height: tinggi container (double.infinity = setinggi layar)
      height: double.infinity,
      
      // decoration: BoxDecoration untuk styling visual container
      decoration: const BoxDecoration(
        // gradient: menggunakan gradient yang sudah didefinisikan
        gradient: AppColors.backgroundGradient,
      ),
      
      // child: widget yang akan ditampilkan di dalam container
      // Widget ini akan ter-render di atas background gradient
      child: child,
    );
  }
}

/// Widget untuk membuat box dengan gradient dan glow effect
/// Cocok untuk card atau panel dengan tema neon
class NeonBox extends StatelessWidget {
  /// Widget yang akan ditampilkan di dalam box
  final Widget child;
  
  /// Padding di dalam box
  final EdgeInsetsGeometry? padding;
  
  /// Border radius untuk rounded corners
  final double borderRadius;

  /// Constructor dengan default values
  const NeonBox({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: jarak antara border dan child
      // ?? operator: jika padding null, gunakan default value
      padding: padding ?? const EdgeInsets.all(24.0),
      
      // decoration: styling untuk container
      decoration: BoxDecoration(
        // gradient: background gradient untuk box
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // withOpacity: mengatur transparansi warna
            // 0.1 = 10% opacity (sangat transparan)
            AppColors.neonPurple.withOpacity(0.1),
            AppColors.neonPink.withOpacity(0.05),
          ],
        ),
        
        // borderRadius: membuat sudut container rounded
        // BorderRadius.circular membuat semua sudut sama
        borderRadius: BorderRadius.circular(borderRadius),
        
        // border: garis tepi dengan gradient
        border: Border.all(
          // Warna border dengan opacity rendah
          color: AppColors.neonPurple.withOpacity(0.3),
          width: 2,
        ),
        
        // boxShadow: array of shadows untuk efek glow di luar box
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.neonPink.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      
      child: child,
    );
  }
}