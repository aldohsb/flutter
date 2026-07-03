// lib/features/home/widgets/greeting_text.dart  [UPDATED — Part 3]
// ─────────────────────────────────────────────────────────
// KONSEP UTAMA: Implicit Animation dengan AnimatedSwitcher
//
// Perubahan dari Part 1:
//   → Upgrade dari StatelessWidget ke StatefulWidget
//   → Bungkus teks nama dengan AnimatedSwitcher
//   → Nama lama fade out + slide ke atas, nama baru fade in + slide dari bawah
//
// Mengapa butuh StatefulWidget sekarang?
//   → AnimatedSwitcher membutuhkan key unik per nilai agar tahu kapan ganti
//   → Tidak perlu AnimationController sendiri — AnimatedSwitcher mengurus semua
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

import 'package:hellow/core/theme/app_colors.dart';
import 'package:hellow/core/theme/app_text_styles.dart';

class GreetingText extends StatelessWidget {
  // Tetap StatelessWidget — AnimatedSwitcher mengurus state animasinya sendiri
  // Kita tidak perlu menyimpan state apapun di sini

  const GreetingText({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('HELLO,', style: AppTextStyles.label),

        const SizedBox(height: 4),

        AnimatedSwitcher(
          // AnimatedSwitcher: widget yang menganimasikan pergantian child-nya
          // Saat child berubah (detected via key), widget lama keluar dan baru masuk
          duration: const Duration(milliseconds: 400),
          // Durasi animasi transisi antar nama

          switchInCurve: Curves.easeOutBack,
          // Kurva untuk widget BARU masuk
          // easeOutBack: sedikit "overshoot" — melewati posisi akhir lalu balik
          // Memberi kesan "pop" yang menyenangkan

          switchOutCurve: Curves.easeIn,
          // Kurva untuk widget LAMA keluar
          // easeIn: lambat di awal, cepat di akhir — menghilang dengan cepat

          transitionBuilder: (Widget child, Animation<double> animation) {
            // transitionBuilder: kita definisikan sendiri bagaimana transisi terjadi
            // child: widget yang sedang dalam transisi (bisa yang masuk atau keluar)
            // animation: nilai 0.0–1.0 sesuai progress transisi

            return FadeTransition(
              opacity: animation,
              // Fade: opacity berubah dari 0 ke 1 saat masuk, 1 ke 0 saat keluar
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  // Masuk dari bawah (25% dari tinggi widget)
                  end: Offset.zero,
                ).animate(animation),
                // Tween langsung di-animate dengan animation dari transitionBuilder
                child: child,
              ),
            );
          },

          child: Text(
            name,
            key: ValueKey<String>(name),
            // ValueKey: key berdasarkan nilai
            // KRITIS: tanpa key, AnimatedSwitcher tidak tahu bahwa child berubah
            // Saat key berubah (nama baru) → AnimatedSwitcher trigger transisi
            // Dua Text dengan teks berbeda tapi tanpa key = dianggap widget sama
            style: AppTextStyles.greeting,
          ),
        ),

        const SizedBox(height: 8),

        AnimatedContainer(
          // AnimatedContainer: versi Container yang otomatis animasikan perubahan
          // property-nya (width, color, padding, dll) saat ada yang berubah
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          width: name.length * 4.5,
          // Lebar garis dekoratif proporsional dengan panjang nama
          // Nama pendek = garis pendek, nama panjang = garis lebih panjang
          // name.length * 4.5 adalah estimasi pixel per karakter
          height: 4,
          constraints: const BoxConstraints(minWidth: 40, maxWidth: 120),
          // Batasi lebar minimum dan maksimum agar tetap proporsional
          decoration: BoxDecoration(
            color: AppColors.coralLight,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Garis bawah yang lebarnya beranimasi mengikuti panjang nama
      ],
    );
  }
}