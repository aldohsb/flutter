import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class FoodCardShimmer extends StatelessWidget {
  // Widget placeholder "shimmer" — ditampilkan saat gambar sedang loading
  // Memberikan kesan konten sedang dimuat, lebih baik dari layar kosong

  const FoodCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container luar: card placeholder keseluruhan
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 120,
      // Tinggi sama dengan FoodCardWidget agar tidak ada "lompatan" layout saat diganti

      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowCard,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            // Placeholder kotak untuk area gambar
            width: 120,
            // Lebar sama persis dengan gambar di FoodCardWidget
            decoration: BoxDecoration(
              color: AppColors.backgroundChip,
              // Warna abu-abu muda sebagai placeholder
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                // Hanya sudut kiri yang melengkung — sisi kanan lurus
              ),
            ),
          ),

          Expanded(
            // Expanded mengisi sisa lebar setelah kotak gambar
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShimmerLine(width: 140, height: 14),
                  // Baris panjang untuk placeholder nama makanan

                  const SizedBox(height: 8),
                  _buildShimmerLine(width: 100, height: 10),
                  // Baris lebih pendek untuk placeholder kategori

                  const SizedBox(height: 12),
                  _buildShimmerLine(width: 80, height: 12),
                  // Baris untuk placeholder harga
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLine({required double width, required double height}) {
    // Helper: buat satu garis placeholder berwarna abu-abu
    // Dipanggil 3x dengan ukuran berbeda → DRY principle
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundChip,
        // Warna sama dengan placeholder gambar untuk konsistensi
        borderRadius: BorderRadius.circular(4),
        // Ujung sedikit rounded — terlihat lebih modern dari kotak tajam
      ),
    );
  }
}