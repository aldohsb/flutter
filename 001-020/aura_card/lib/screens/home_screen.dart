// ============================================================================
// FILE: lib/screens/home_screen.dart
// FUNGSI: Layar utama yang menampilkan AuraCard
// ============================================================================

import 'package:flutter/material.dart';
import '../widgets/aura_card_widget.dart';
import '../utils/constants.dart';

// ============================================================================
// HOME SCREEN - Layar Utama
// ============================================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = Widget dasar untuk struktur halaman (AppBar, body, dll)
    return Scaffold(
      // backgroundColor: Warna latar belakang layar
      backgroundColor: AppColors.backgroundDark,
      
      // body: Konten utama layar
      body: Center(
        // Center = Widget untuk menempatkan child di tengah layar
        // child: Widget yang akan diposisikan di tengah
        child: SingleChildScrollView(
          // SingleChildScrollView: Membuat child bisa di-scroll jika terlalu besar
          // Gunanya: Untuk menghindari overflow error pada device kecil
          
          // child: Widget yang bisa di-scroll
          child: Padding(
            // padding: Ruang di sekitar child dari tepi layar
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            // child: Widget yang diberi padding
            child: Column(
              // mainAxisAlignment: Mengatur posisi child di sumbu vertikal
              // center = menempatkan di tengah vertikal
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: Mengatur posisi child di sumbu horizontal
              // center = menempatkan di tengah horizontal
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ==============================================================
                // JUDUL APLIKASI
                // ==============================================================
                Text(
                  // Judul aplikasi
                  'AuraCard',
                  // style: Mengatur tampilan teks
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    // color: Warna teks (putih)
                    color: AppColors.textPrimary,
                    // fontWeight: Ketebalan font (bold = tebal)
                    fontWeight: FontWeight.bold,
                    // letterSpacing: Jarak antar huruf (untuk efek elegant)
                    letterSpacing: 2.0,
                  ),
                ),

                // SizedBox: Jarak vertikal antara judul dan deskripsi
                const SizedBox(height: AppSizes.paddingMedium),

                // ==============================================================
                // DESKRIPSI SINGKAT
                // ==============================================================
                Text(
                  // Deskripsi aplikasi
                  'Holographic Profile Card',
                  // style: Tampilan teks
                  style: TextStyle(
                    // color: Warna teks (putih dengan transparansi)
                    color: AppColors.textSecondary,
                    // fontSize: Ukuran teks
                    fontSize: 16.0,
                    // fontStyle: Gaya font (italic = miring)
                    fontStyle: FontStyle.italic,
                  ),
                ),

                // SizedBox: Jarak besar sebelum kartu
                const SizedBox(height: AppSizes.paddingLarge * 2),

                // ==============================================================
                // AURA CARD WIDGET - Komponen Utama
                // ==============================================================
                // Container: Widget dasar untuk memberi efek/dekorasi
                Container(
                  // Gunanya: Membungkus AuraCard dengan efek shadow (bayangan)
                  // Bayangan membuat kartu terlihat lebih floating/melayang
                  
                  // decoration: Styling container (warna, shadow, dll)
                  decoration: BoxDecoration(
                    // boxShadow: Efek bayangan di sekitar container
                    boxShadow: [
                      // BoxShadow: Definisi satu bayangan
                      BoxShadow(
                        // color: Warna bayangan (ungu dengan transparansi)
                        color: AppColors.primaryGradientStart.withOpacity(AppOpacity.shadowOpacity),
                        // blurRadius: Seberapa besar blur pada bayangan
                        blurRadius: 30.0,
                        // spreadRadius: Seberapa jauh bayangan meluas
                        spreadRadius: 0.0,
                        // offset: Posisi bayangan (x, y)
                        offset: const Offset(0, 20),
                      ),
                      // Bayangan kedua untuk efek lebih dalam
                      BoxShadow(
                        // color: Warna bayangan kedua (biru dengan transparansi)
                        color: AppColors.primaryGradientEnd.withOpacity(AppOpacity.shadowOpacity * 0.5),
                        // blurRadius: Blur untuk bayangan kedua
                        blurRadius: 20.0,
                        // spreadRadius: Jangkauan bayangan kedua
                        spreadRadius: 0.0,
                        // offset: Posisi bayangan kedua
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  // child: Widget yang dibungkus dengan shadow
                  child: const AuraCardWidget(),
                ),

                // SizedBox: Jarak di bawah kartu
                const SizedBox(height: AppSizes.paddingLarge * 2),

                // ==============================================================
                // KETERANGAN TEKNIK
                // ==============================================================
                // Padding: Memberi ruang di sekitar teks keterangan
                Padding(
                  // padding: Ruang di kiri-kanan
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingLarge,
                  ),
                  // child: Widget yang diberi padding
                  child: Text(
                    // Teks keterangan tentang teknik yang digunakan
                    'Built with Glassmorphism Design\nStack • ClipRRect • BackdropFilter',
                    // textAlign: Perataan teks (center = tengah)
                    textAlign: TextAlign.center,
                    // style: Tampilan teks
                    style: TextStyle(
                      // color: Warna teks (abu-abu terang)
                      color: AppColors.textSecondary.withOpacity(0.7),
                      // fontSize: Ukuran teks (kecil)
                      fontSize: 12.0,
                      // height: Tinggi baris (untuk spacing antar baris)
                      height: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}