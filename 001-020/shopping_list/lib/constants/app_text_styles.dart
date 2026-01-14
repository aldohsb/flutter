// File ini berisi semua style text yang digunakan dalam aplikasi
// Dengan mendefinisikan text style di satu tempat, kita memastikan tipografi
// yang konsisten di seluruh aplikasi dan mudah untuk maintenance

// Import Flutter material untuk akses TextStyle, FontWeight, dll
import 'package:flutter/material.dart';
// Import app_colors untuk menggunakan warna yang sudah didefinisikan
import 'app_colors.dart';

// Class AppTextStyles adalah utility class untuk menyimpan semua text styles
// Abstract class mencegah instantiation, semua members bersifat static
abstract class AppTextStyles {
  
  // === FONT FAMILY ===
  // Mendefinisikan font family yang digunakan di seluruh aplikasi
  // 'Poppins' adalah font modern, clean, dan sangat readable
  // Font ini bagus untuk aplikasi yang ingin terlihat fresh dan profesional
  static const String fontFamily = 'Poppins';

  // === HEADING STYLES ===
  // Text styles untuk judul-judul besar dan penting
  
  // Heading 1 - Untuk judul utama halaman atau section penting
  // Ukuran besar (32px) dengan bold weight untuk maksimal impact
  static const TextStyle heading1 = TextStyle(
    // fontSize: ukuran font dalam logical pixels (32px sangat besar, untuk judul utama)
    fontSize: 32,
    // fontWeight: ketebalan font (FontWeight.bold = 700, sangat tebal)
    fontWeight: FontWeight.bold,
    // color: warna teks menggunakan darkGray untuk kontras yang baik
    color: AppColors.darkGray,
    // fontFamily: menggunakan font Poppins yang sudah didefinisikan
    fontFamily: fontFamily,
    // letterSpacing: jarak antar huruf (0.5 memberikan sedikit breathing room)
    letterSpacing: 0.5,
    // height: line height relative terhadap font size (1.2 = 120% dari font size)
    // Line height yang baik meningkatkan readability
    height: 1.2,
  );

  // Heading 2 - Untuk sub-judul atau judul section
  // Lebih kecil dari H1 tapi masih cukup prominent
  static const TextStyle heading2 = TextStyle(
    fontSize: 24, // Ukuran sedang untuk sub-heading
    fontWeight: FontWeight.w600, // Semi-bold (600) sedikit lebih ringan dari bold
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.3,
    height: 1.3,
  );

  // Heading 3 - Untuk judul kecil atau label section
  // Ukuran lebih kecil tapi masih menonjol
  static const TextStyle heading3 = TextStyle(
    fontSize: 18, // Ukuran kecil tapi masih terlihat sebagai heading
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.2,
    height: 1.4,
  );

  // === BODY TEXT STYLES ===
  // Text styles untuk konten utama dan paragraf
  
  // Body Large - Untuk paragraf penting atau konten utama
  // Ukuran nyaman untuk dibaca (16px adalah ukuran standar body text)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16, // Ukuran standar untuk body text yang nyaman dibaca
    fontWeight: FontWeight.normal, // Normal weight (400) untuk body text
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.5, // Line height 1.5 adalah standar untuk readability paragraf
  );

  // Body Medium - Untuk konten sekunder atau caption
  // Sedikit lebih kecil dari body large
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14, // Sedikit lebih kecil, cocok untuk konten pendukung
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Body Small - Untuk teks kecil, footnote, atau metadata
  // Ukuran terkecil yang masih comfortable untuk dibaca
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12, // Ukuran kecil untuk informasi tambahan
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray, // Warna lebih terang untuk menunjukkan hierarchy
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // === BUTTON TEXT STYLES ===
  // Text styles khusus untuk button
  
  // Button Large - Untuk primary button atau CTA utama
  // Bold dan cukup besar untuk menarik perhatian
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16, // Ukuran yang cukup besar untuk mudah di-tap
    fontWeight: FontWeight.w600, // Semi-bold untuk emphasis
    color: AppColors.white, // Putih untuk kontras dengan background button
    fontFamily: fontFamily,
    letterSpacing: 0.5, // Letter spacing lebih besar untuk button text
  );

  // Button Medium - Untuk button sekunder atau button dalam dialog
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );

  // Button Small - Untuk button kecil atau inline action
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: fontFamily,
    letterSpacing: 0.3,
  );

  // === SPECIALIZED TEXT STYLES ===
  // Text styles untuk penggunaan khusus
  
  // Item Title - Style untuk judul item belanja
  // Medium size dengan weight yang cukup untuk stand out
  static const TextStyle itemTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium weight (500) balance antara normal dan semi-bold
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.3,
  );

  // Item Title Checked - Style untuk item yang sudah dibeli
  // Sama seperti itemTitle tapi dengan warna lebih pudar dan strikethrough
  static const TextStyle itemTitleChecked = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.checkedItemText, // Warna abu-abu untuk menunjukkan completed
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.3,
    // decoration: TextDecoration.lineThrough memberikan garis coret
    // Ini visual cue universal untuk "completed" atau "deleted"
    decoration: TextDecoration.lineThrough,
    // decorationColor: warna garis coret, sama dengan warna teks
    decorationColor: AppColors.checkedItemText,
    // decorationThickness: ketebalan garis coret (1.5 cukup visible)
    decorationThickness: 1.5,
  );

  // Item Subtitle - Style untuk informasi tambahan item (quantity, category, dll)
  // Lebih kecil dan warna lebih terang untuk hierarchy
  static const TextStyle itemSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray, // Warna abu-abu untuk secondary info
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Caption - Style untuk caption, label, atau hint text
  // Sangat kecil dan subtle untuk informasi pelengkap
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.3,
  );

  // Overline - Style untuk label kecil di atas konten (seperti category label)
  // Uppercase dan spaced untuk emphasis subtle
  static const TextStyle overline = TextStyle(
    fontSize: 10, // Sangat kecil
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    fontFamily: fontFamily,
    // letterSpacing besar untuk overline memberikan kesan elegant
    letterSpacing: 1.5,
    height: 1.6,
  );

  // Error Text - Style untuk pesan error
  // Menggunakan warna error dan size yang cukup untuk noticed
  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.error, // Warna merah untuk error
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Success Text - Style untuk pesan sukses
  // Menggunakan warna success untuk positive feedback
  static const TextStyle successText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.success, // Warna hijau untuk success
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Link Text - Style untuk link atau clickable text
  // Biru dengan underline untuk menunjukkan interactivity
  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.info, // Warna biru untuk link
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
    decoration: TextDecoration.underline, // Underline untuk visual cue link
  );

  // === INPUT TEXT STYLES ===
  // Text styles untuk input fields
  
  // Input Text - Style untuk teks dalam text field
  static const TextStyle inputText = TextStyle(
    fontSize: 16, // Ukuran yang comfortable untuk typing
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Input Hint - Style untuk hint/placeholder text
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray, // Warna lebih terang untuk hint
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Input Label - Style untuk label di atas input field
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
    height: 1.3,
  );
}