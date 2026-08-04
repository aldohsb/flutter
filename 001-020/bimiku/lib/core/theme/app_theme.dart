import 'package:flutter/material.dart'; // widget dan ThemeData bawaan flutter
import 'package:google_fonts/google_fonts.dart'; // untuk mengambil font Poppins dari Google Fonts
import 'app_colors.dart'; // mengambil palet warna yang sudah kita definisikan

// class ini bertugas merakit satu ThemeData lengkap untuk seluruh aplikasi
class AppTheme {
  AppTheme._(); // constructor privat, class ini hanya berisi static member

  static ThemeData get light { // getter yang mengembalikan tema terang aplikasi
    final scheme = ColorScheme.fromSeed( // membuat skema warna Material 3 dari satu warna seed
      seedColor: AppColors.seed, // warna dasar yang dipakai untuk generate seluruh palet
      brightness: Brightness.light, // mode terang
    );

    return ThemeData( // merakit ThemeData final
      useMaterial3: true, // mengaktifkan desain Material 3 terbaru
      colorScheme: scheme, // memasang skema warna yang sudah dibuat
      scaffoldBackgroundColor: AppColors.backgroundBottom, // warna dasar scaffold
      textTheme: GoogleFonts.poppinsTextTheme(), // mengganti seluruh font default dengan Poppins
      inputDecorationTheme: InputDecorationTheme( // tema khusus untuk semua TextFormField
        filled: true, // mengaktifkan warna latar pada field
        fillColor: Colors.white, // warna latar field putih agar kontras dengan gradasi
        border: OutlineInputBorder( // bentuk border default field
          borderRadius: BorderRadius.circular(16), // sudut membulat agar terlihat modern
          borderSide: BorderSide.none, // tanpa garis tepi, mengandalkan warna fill saja
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18), // jarak dalam field
      ),
      sliderTheme: SliderThemeData( // tema khusus untuk semua Slider di aplikasi
        activeTrackColor: scheme.primary, // warna track yang sudah dilewati thumb
        inactiveTrackColor: scheme.primary.withValues(alpha: 0.15), // warna track belum dilewati
        thumbColor: scheme.primary, // warna bulatan thumb slider
        overlayColor: scheme.primary.withValues(alpha: 0.15), // warna riak saat thumb ditekan
        trackHeight: 8, // ketebalan track slider
      ),
    );
  }
}