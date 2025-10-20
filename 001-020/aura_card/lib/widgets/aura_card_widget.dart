// ============================================================================
// FILE: lib/widgets/aura_card_widget.dart
// FUNGSI: Widget utama untuk menampilkan kartu profil dengan glassmorphism
// KONSEP UTAMA:
// - Stack: Untuk layering (menumpuk) multiple widgets
// - ClipRRect: Untuk membuat sudut membulat
// - BackdropFilter: Untuk efek blur glassmorphism
// ============================================================================

import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Import dart.ui untuk BackdropFilter dan ImageFilter
import '../utils/constants.dart';

// ============================================================================
// AURA CARD WIDGET - Kartu Profil Holografik
// ============================================================================
class AuraCardWidget extends StatelessWidget {
  const AuraCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Stack digunakan untuk membuat beberapa layer/lapisan widget
    // Layer 1: Gradient background (lapisan paling bawah)
    // Layer 2: Blur effect dengan BackdropFilter
    // Layer 3: Konten kartu (teks, emoji, border)
    return Stack(
      // alignment: center membuat semua child widget di tengah
      alignment: Alignment.center,
      children: [
        // ====================================================================
        // LAYER 1: GRADIENT BACKGROUND - Latar belakang berwarna gradien
        // ====================================================================
        // Container adalah widget kotak dasar di Flutter
        // Kita gunakan untuk membuat background berwarna
        Container(
          width: AppSizes.cardWidth,
          height: AppSizes.cardHeight,
          decoration: BoxDecoration(
            // gradient membuat warna yang bertransisi dari satu ke warna lain
            // LinearGradient = gradien garis lurus dari atas ke bawah
            gradient: LinearGradient(
              // begin: Posisi awal gradien (atas-kiri)
              begin: Alignment.topLeft,
              // end: Posisi akhir gradien (bawah-kanan)
              end: Alignment.bottomRight,
              // colors: Warna-warna yang digunakan dalam gradien
              colors: [
                // Warna pertama (ungu terang)
                AppColors.primaryGradientStart,
                // Warna kedua (biru)
                AppColors.primaryGradientEnd,
              ],
              // stops: Kontrol di mana warna mulai dan berakhir (0-1)
              stops: const [0.0, 1.0],
            ),
          ),
        ),

        // ====================================================================
        // LAYER 2: BACKDROP FILTER - Efek blur untuk glassmorphism
        // ====================================================================
        // ClipRRect = "Clipping Rounded Rectangle" = Memotong widget menjadi
        // bentuk persegi panjang dengan sudut membulat
        // Gunanya: Supaya konten di dalamnya tidak keluar dari sudut yang bulat
        ClipRRect(
          // borderRadius: Seberapa besar sudut membulat
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          // Child: Widget yang akan dipotong sesuai bentuk ClipRRect
          child: BackdropFilter(
            // BackdropFilter = Menerapkan efek pada widget DI BELAKANGNYA
            // Dalam kasus ini, efek blur diterapkan pada gradient background
            // filter: ImageFilter menentukan jenis efek yang diterapkan
            filter: ui.ImageFilter.blur(
              // sigmaX dan sigmaY: Seberapa besar blur effect
              // Semakin besar, semakin blur tampilannya
              sigmaX: AppSizes.blurSigma,
              sigmaY: AppSizes.blurSigma,
            ),
            // child: Widget yang ditampilkan DI ATAS blur effect
            child: Container(
              // Container transparan (tidak ada warna solid)
              // Gunanya: Untuk menampung blur effect dan positioning
              width: AppSizes.cardWidth,
              height: AppSizes.cardHeight,
              // decoration: Styling untuk container
              decoration: BoxDecoration(
                // color: Warna dengan transparansi (semi-transparan)
                // RGBA: R=Red, G=Green, B=Blue, A=Alpha(transparansi)
                // 0xFF = 255 (warna penuh), jadi 0xFFFFFFFF = putih penuh
                color: AppColors.glassAccent.withOpacity(AppOpacity.glassOpacity),
                // border: Garis tepi untuk efek glass yang lebih jelas
                border: Border.all(
                  // color: Warna garis tepi (putih dengan transparansi)
                  color: AppColors.glassAccent.withOpacity(AppOpacity.borderOpacity),
                  // width: Tebal garis tepi
                  width: 2.0,
                ),
                // borderRadius: Sudut membulat untuk container
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
              ),
            ),
          ),
        ),

        // ====================================================================
        // LAYER 3: KONTEN KARTU - Teks, emoji, dan informasi profil
        // ====================================================================
        // Column = Widget untuk menyusun child secara vertikal (atas ke bawah)
        Column(
          // mainAxisAlignment: Mengatur posisi child di sepanjang sumbu vertikal
          // spaceEvenly = membagi ruang sama rata antar child
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: Mengatur posisi child di sumbu horizontal
          // center = center horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ------------------------------------------------------------------
            // SUB-LAYER: EMOJI/ICON PROFIL
            // ------------------------------------------------------------------
            // Text widget untuk menampilkan emoji atau icon
            Text(
              // Emoji yang ditampilkan (dari ProfileData)
              ProfileData.profileEmoji,
              // style: Mengatur tampilan teks
              style: const TextStyle(
                // fontSize: Ukuran emoji (besar)
                fontSize: 64.0,
              ),
            ),

            // SizedBox = Widget untuk membuat jarak/spacing
            const SizedBox(height: AppSizes.paddingMedium),

            // ------------------------------------------------------------------
            // SUB-LAYER: NAMA PROFIL
            // ------------------------------------------------------------------
            Text(
              // Nama dari ProfileData
              ProfileData.profileName,
              // style: Mengatur tampilan teks
              style: const TextStyle(
                // color: Warna teks (putih)
                color: AppColors.textPrimary,
                // fontSize: Ukuran teks (besar, untuk heading)
                fontSize: 28.0,
                // fontWeight: Ketebalan font (bold = tebal)
                fontWeight: FontWeight.bold,
                // letterSpacing: Jarak antar huruf (untuk efek elegant)
                letterSpacing: 1.2,
              ),
            ),

            // SizedBox: Jarak antar widget
            const SizedBox(height: AppSizes.paddingSmall),

            // ------------------------------------------------------------------
            // SUB-LAYER: BIO/DESKRIPSI PROFIL
            // ------------------------------------------------------------------
            // Padding = Widget untuk membuat ruang di sekitar child
            Padding(
              // padding: Berapa banyak ruang di sekeliling child
              padding: const EdgeInsets.symmetric(
                // horizontal: Ruang kiri-kanan
                horizontal: AppSizes.paddingLarge,
              ),
              // child: Widget yang diberi padding
              child: Text(
                // Bio dari ProfileData
                ProfileData.profileBio,
                // textAlign: Perataan teks (center = tengah)
                textAlign: TextAlign.center,
                // style: Tampilan teks
                style: const TextStyle(
                  // color: Warna teks (putih dengan transparansi)
                  color: AppColors.textSecondary,
                  // fontSize: Ukuran teks (lebih kecil dari nama)
                  fontSize: 14.0,
                  // height: Tinggi baris (untuk spacing antar baris)
                  height: 1.5,
                ),
              ),
            ),

            // SizedBox: Jarak di bawah untuk simetri visual
            const SizedBox(height: AppSizes.paddingSmall),
          ],
        ),
      ],
    );
  }
}