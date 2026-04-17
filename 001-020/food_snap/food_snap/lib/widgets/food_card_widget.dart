import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../models/food_item.dart';

class FoodCardWidget extends StatelessWidget {
  final FoodItem item;
  // FoodItem adalah model data yang berisi semua info satu makanan
  // Widget ini menerima satu FoodItem dan menampilkannya sebagai card

  const FoodCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: item.isAvailable ? 1.0 : 0.5,
      // Opacity: jika tidak tersedia, tampilkan card dengan transparansi 50%
      // item.isAvailable ? 1.0 : 0.5 — conditional expression (ternary operator)
      // Tanda tanya setelah kondisi: jika true pakai 1.0, jika false pakai 0.5

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        // margin horizontal 20px (kiri & kanan), vertikal 8px (atas & bawah)
        // Beda dengan padding: margin = ruang DI LUAR container

        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          // Sudut melengkung radius 16px untuk tampilan card modern

          boxShadow: [
            BoxShadow(
              color: AppColors.shadowCard,
              // Shadow sangat lembut (8% opacity hitam) — tidak mengganggu
              blurRadius: 12,
              // Semakin besar blurRadius, semakin kabur/lembut bayangannya
              offset: const Offset(0, 4),
              // Offset(horizontal, vertical): bayangan 4px ke bawah
              // Menciptakan efek "melayang" yang natural
            ),
          ],
        ),

        child: Row(
          // Layout card: gambar di KIRI, info di KANAN
          // Row horizontal — ini adalah pola card yang paling umum
          crossAxisAlignment: CrossAxisAlignment.start,
          // Atas gambar sejajar dengan atas teks — lebih rapi dari center

          children: [
            _buildFoodImage(),
            // Area gambar (lebar tetap 120px)

            Expanded(
              // Expanded: ambil semua sisa ruang horizontal setelah gambar
              // Tanpa Expanded, teks akan meluber keluar card
              child: _buildFoodInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodImage() {
    return ClipRRect(
      // ClipRRect: memotong child mengikuti border radius yang ditentukan
      // Tanpa ini, gambar tetap kotak meski sudah ada borderRadius di Container luar
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        // BorderRadius.only: hanya sudut kiri yang melengkung
        // topRight dan bottomRight dibiarkan tajam (0) karena menyatu dengan info
        // Radius.circular(16) harus sama dengan borderRadius Container luar
      ),

      child: SizedBox(
        // SizedBox memberi batas ukuran eksplisit pada gambar
        // Image.asset akan mengisi area ini sesuai BoxFit yang ditentukan
        width: 120,
        height: 120,
        // Lebar dan tinggi sama → area gambar berbentuk kotak

        child: Stack(
          // Stack untuk menumpuk gambar (bawah) + badge/overlay (atas)
          fit: StackFit.expand,
          // StackFit.expand: semua child tanpa Positioned mengisi seluruh Stack

          children: [
            Image.asset(
              item.imagePath,
              // item.imagePath → path gambar dari model FoodItem
              // Contoh: 'assets/images/food/nasi_goreng.jpg'
              fit: BoxFit.cover,
              // BoxFit.cover: gambar mengisi seluruh 120x120px
              // Bagian yang keluar dari area dipotong
              // Gambar tidak distorsi — proporsi asli dipertahankan
              errorBuilder: (context, error, stackTrace) {
                // errorBuilder: tampilkan ini jika gambar gagal dimuat
                // Sangat penting untuk development saat foto placeholder masih kosong
                return Container(
                  color: AppColors.backgroundChip,
                  // Background abu-abu sebagai fallback
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        // Ikon garpu-pisau sebagai representasi makanan
                        color: AppColors.textMuted,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No Image',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            if (!item.isAvailable)
              Container(
                // Overlay gelap di atas gambar jika makanan tidak tersedia
                // if (!item.isAvailable) → conditional rendering dalam list children
                color: Colors.black.withValues(alpha: 0.4),
                // Hitam 40% transparan — menggelapi gambar tapi masih terlihat
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'HABIS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildFoodInfo() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Semua teks rata kiri
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // spaceBetween: dorong nama ke atas dan harga ke bawah
        // Membuat tata letak info terlihat "berisi" dan tidak menumpuk

        children: [
          Column(
            // Column inner untuk nama + kategori + deskripsi (grup atas)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // Row: nama makanan di kiri + badge kategori di kanan
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      // Batasi maksimal 2 baris agar card tidak melar
                      overflow: TextOverflow.ellipsis,
                      // Teks yang terlalu panjang diakhiri dengan "..."
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildCategoryBadge(),
                  // Badge kategori di pojok kanan atas area info
                ],
              ),

              const SizedBox(height: 4),

              Text(
                item.description,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            // Row: rating di kiri + harga di kanan
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRating(),
              _buildPrice(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        // Background badge: oranye sangat transparan (12%)
        borderRadius: BorderRadius.circular(20),
        // Pill shape — radius besar pada container kecil = berbentuk pil
      ),
      child: Text(
        item.category,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // min: Row hanya selebar kontennya, tidak mengambil sisa ruang
      children: [
        Icon(
          Icons.star_rounded,
          // star_rounded: varian bintang dengan ujung bulat — lebih modern
          size: 14,
          color: AppColors.ratingYellow,
        ),
        const SizedBox(width: 3),
        Text(
          item.rating.toStringAsFixed(1),
          // .toStringAsFixed(1): konversi double ke String dengan 1 desimal
          // 4.8 → '4.8', 5.0 → '5.0'
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      item.formattedPrice,
      // formattedPrice adalah getter di FoodItem yang format angka ke 'Rp 25.000'
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        // Harga berwarna primary (oranye) — menonjol dan menarik perhatian
      ),
    );
  }
}