import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// ActionButton - Custom FloatingActionButton dengan Brutalist Design
/// 
/// Widget ini adalah custom FAB dengan:
/// - Shape persegi dengan border tebal
/// - Icon dan label yang jelas
/// - Customizable callback dan appearance
class ActionButton extends StatelessWidget {
  /// Icon yang ditampilkan di button
  final IconData icon;

  /// Label text di bawah icon
  final String label;

  /// Callback function saat button ditekan
  /// VoidCallback: function tanpa parameter dan return value
  final VoidCallback onPressed;

  /// Hero tag untuk animasi hero transition
  /// Setiap FAB dalam screen yang sama harus punya tag unik
  final String heroTag;

  /// Constructor dengan required parameters
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    // Column: menyusun children secara vertical
    return Column(
      // mainAxisSize.min: ukuran column sesuai children
      mainAxisSize: MainAxisSize.min,
      
      // crossAxisAlignment.center: children di tengah horizontal
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        // FloatingActionButton - button utama
        FloatingActionButton(
          // onPressed: callback saat button ditekan
          onPressed: onPressed,
          
          // heroTag: unique identifier untuk hero animation
          heroTag: heroTag,
          
          // backgroundColor: override default theme
          backgroundColor: AppColors.black,
          
          // foregroundColor: warna icon
          foregroundColor: AppColors.white,
          
          // elevation: ketinggian shadow (0 untuk flat design)
          elevation: 0,
          
          // highlightElevation: elevation saat pressed
          highlightElevation: 0,
          
          // shape: bentuk button dengan border
          shape: const RoundedRectangleBorder(
            // BorderRadius.zero: sudut tajam
            borderRadius: BorderRadius.zero,
            // Border hitam tebal
            side: BorderSide(
              color: AppColors.black,
              width: 4,
            ),
          ),
          
          // child: konten button (icon)
          child: Icon(
            icon,
            size: 32, // Ukuran icon besar
          ),
        ),
        
        // SizedBox: spacing vertical antara button dan label
        const SizedBox(height: 12),
        
        // Text label di bawah button
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800, // Extra bold
            color: AppColors.black,
            letterSpacing: 0.5, // Spacing untuk readability
          ),
          // Text align center
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}