// File ini berisi semua definisi warna yang digunakan dalam aplikasi
// Dengan memusatkan warna di satu tempat, kita memastikan konsistensi visual
// dan memudahkan perubahan tema di masa depan

// Import package Flutter material untuk akses class Color dan MaterialColor
import 'package:flutter/material.dart';

// Class AppColors adalah class utility yang berisi konstanta warna
// Class ini menggunakan abstract class sehingga tidak bisa di-instantiate
// Semua property bersifat static sehingga bisa diakses langsung tanpa instance
abstract class AppColors {
  
  // === WARNA UTAMA (PRIMARY COLORS) ===
  // Warna hijau segar sebagai identitas tema "Grocery Fresh"
  // Angka 0xFF di awal adalah kode untuk opacity penuh (fully opaque)
  // Diikuti kode hex untuk warna RGB
  
  // Warna hijau utama - digunakan untuk elemen primer seperti app bar, button utama
  // 0xFF4CAF50 = hijau segar yang cerah, memberikan kesan fresh dan natural
  static const Color primaryGreen = Color(0xFF4CAF50);
  
  // Varian hijau lebih gelap - untuk hover state, active state, atau aksen
  // Memberikan kontras dan depth pada UI
  static const Color darkGreen = Color(0xFF388E3C);
  
  // Varian hijau lebih terang - untuk background subtle, highlight, atau disabled state
  // Memberikan variasi visual tanpa terlalu kontras
  static const Color lightGreen = Color(0xFF81C784);
  
  // Hijau sangat terang - untuk background card, section, atau area tertentu
  // Memberikan kesan segar tanpa terlalu mencolok
  static const Color paleGreen = Color(0xFFE8F5E9);

  // === WARNA SEKUNDER (SECONDARY COLORS) ===
  // Warna pendukung yang melengkapi palet hijau utama
  
  // Orange untuk aksen - memberikan kontras hangat dengan hijau
  // Digunakan untuk call-to-action atau elemen yang perlu attention
  static const Color accentOrange = Color(0xFFFF9800);
  
  // Kuning lembut - untuk highlight informasi penting tapi tidak urgent
  // Memberikan variasi warna yang tetap harmonis dengan tema
  static const Color softYellow = Color(0xFFFFF9C4);

  // === WARNA NETRAL (NEUTRAL COLORS) ===
  // Warna-warna netral untuk teks, background, border, dll
  
  // Putih murni - untuk background utama, card, atau elemen yang perlu stand out
  static const Color white = Color(0xFFFFFFFF);
  
  // Abu-abu sangat terang - untuk background alternatif, divider subtle
  // Memberikan separasi visual yang lembut
  static const Color lightGray = Color(0xFFF5F5F5);
  
  // Abu-abu medium - untuk teks sekunder, icon inactive, border
  // Memberikan hierarchy informasi visual
  static const Color mediumGray = Color(0xFF9E9E9E);
  
  // Abu-abu gelap - untuk teks utama, icon active, elemen penting
  // Memberikan kontras yang cukup untuk readability
  static const Color darkGray = Color(0xFF424242);
  
  // Hitam - untuk teks heading, emphasis, atau elemen dengan kontras maksimal
  static const Color black = Color(0xFF212121);

  // === WARNA STATUS (STATUS COLORS) ===
  // Warna untuk mengkomunikasikan status atau kondisi tertentu
  
  // Merah untuk error, warning, atau delete action
  // Mengkomunikasikan danger atau hal yang perlu perhatian serius
  static const Color error = Color(0xFFD32F2F);
  
  // Hijau success untuk konfirmasi, completed task, atau positive feedback
  // Menggunakan shade hijau yang berbeda dari primary untuk perbedaan fungsi
  static const Color success = Color(0xFF388E3C);
  
  // Biru info untuk informasi netral atau link
  // Memberikan variasi warna untuk komunikasi yang berbeda dari primary
  static const Color info = Color(0xFF1976D2);

  // === WARNA UNTUK CHECKBOX & ITEM STATE ===
  // Warna spesifik untuk state item belanja
  
  // Warna untuk item yang sudah dicentang/dibeli
  // Abu-abu terang mengindikasikan item sudah selesai/completed
  static const Color checkedItemBackground = Color(0xFFE0E0E0);
  
  // Warna teks untuk item yang sudah dibeli
  // Abu-abu medium untuk menunjukkan item tidak lagi aktif
  static const Color checkedItemText = Color(0xFF757575);
  
  // Warna untuk item yang belum dibeli (unchecked)
  // Putih untuk menunjukkan item masih aktif dan perlu perhatian
  static const Color uncheckedItemBackground = Color(0xFFFFFFFF);

  // === SHADOW & OVERLAY ===
  // Warna untuk efek shadow dan overlay
  
  // Shadow dengan opacity untuk memberikan depth pada card dan elevated elements
  // withOpacity(0.1) memberikan transparansi 10% untuk shadow yang subtle
  static Color shadowColor = Colors.black.withOpacity(0.1);
  
  // Overlay untuk modal, dialog, atau blocking UI
  // Opacity 50% memberikan efek dimming yang cukup tanpa terlalu gelap
  static Color overlayColor = Colors.black.withOpacity(0.5);

  // === GRADIENT COLORS ===
  // Definisi gradient untuk background atau decorative elements
  
  // Gradient hijau dari terang ke gelap - untuk header, banner, atau decorative background
  // LinearGradient memberikan transisi smooth antar warna
  static const LinearGradient primaryGradient = LinearGradient(
    // begin: Alignment.topLeft - gradient dimulai dari pojok kiri atas
    begin: Alignment.topLeft,
    // end: Alignment.bottomRight - gradient berakhir di pojok kanan bawah
    // Ini menciptakan diagonal gradient yang dinamis
    end: Alignment.bottomRight,
    // colors: daftar warna yang akan di-blend dalam gradient
    colors: [
      lightGreen,  // Warna awal: hijau terang
      primaryGreen, // Warna tengah: hijau utama
      darkGreen,    // Warna akhir: hijau gelap
    ],
  );
}