// File: lib/main.dart
// Hari 1: Splash Screen Sederhana

// Import package Flutter yang berisi widget-widget dasar
import 'package:flutter/material.dart';

// Fungsi main() adalah entry point aplikasi
// void main() artinya fungsi ini tidak mengembalikan nilai apapun
void main() {
  // runApp() adalah fungsi dari Flutter untuk menjalankan aplikasi
  // Parameter: widget root (widget paling atas) dari aplikasi
  runApp(const DeenlyApp());
}

// DeenlyApp adalah widget utama aplikasi kita
// StatelessWidget artinya widget ini tidak punya "state" yang berubah-ubah
// const artinya widget ini immutable (tidak bisa diubah)
class DeenlyApp extends StatelessWidget {
  // Constructor dengan super key untuk optimasi Flutter
  const DeenlyApp({super.key});

  // Method build() wajib ada di setiap widget
  // Fungsinya: mengembalikan widget apa yang mau ditampilkan
  // BuildContext adalah informasi tentang posisi widget di widget tree
  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi Material Design
    // Material Design = style guide dari Google untuk UI/UX
    return MaterialApp(
      // title: nama aplikasi (muncul di task manager)
      title: 'Deenly',
      
      // debugShowCheckedModeBanner: false menghilangkan banner "DEBUG" di pojok
      debugShowCheckedModeBanner: false,
      
      // theme: konfigurasi tema global aplikasi (warna, font, dll)
      theme: ThemeData(
        // primarySwatch: warna utama aplikasi (akan generate warna turunan)
        // Colors.green adalah warna hijau bawaan Flutter
        primarySwatch: Colors.green,
        
        // useMaterial3: pakai Material Design 3 (versi terbaru)
        useMaterial3: true,
      ),
      
      // home: widget yang ditampilkan pertama kali saat app dibuka
      home: const SplashScreen(),
    );
  }
}

// SplashScreen adalah halaman pertama yang user lihat
// StatelessWidget karena tidak ada perubahan data di halaman ini
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah struktur dasar halaman Material Design
    // Punya AppBar, Body, BottomNavigationBar, Drawer, dll
    return Scaffold(
      // backgroundColor: warna latar belakang seluruh halaman
      // Color(0xFFFEFCF8) adalah kode warna HEX untuk krem putih
      // 0xFF di depan artinya opacity 100% (FF dalam HEX)
      backgroundColor: const Color(0xFFFEFCF8),
      
      // body: isi utama halaman
      // Center: widget untuk menaruh child-nya di tengah-tengah
      body: Center(
        // child: widget anak yang ada di dalam Center
        // Column: widget untuk menata child secara vertikal (atas ke bawah)
        child: Column(
          // mainAxisAlignment: atur posisi children di sumbu utama (vertikal)
          // MainAxisAlignment.center: taruh di tengah-tengah secara vertikal
          mainAxisAlignment: MainAxisAlignment.center,
          
          // children: list widget-widget yang ditampilkan secara vertikal
          children: [
            // Icon: widget untuk menampilkan icon
            Icon(
              // Icons.menu_book: icon buku dari Material Icons
              Icons.menu_book,
              
              // size: ukuran icon dalam logical pixels
              size: 80,
              
              // color: warna icon menggunakan kode HEX hijau zaitun
              color: Color(0xFFB8C2A0),
            ),
            
            // SizedBox: widget untuk membuat jarak/spacing
            // height: jarak vertikal 24 pixels
            const SizedBox(height: 24),
            
            // Text: widget untuk menampilkan teks
            const Text(
              // String yang ditampilkan
              'Deenly',
              
              // style: styling untuk teks
              style: TextStyle(
                // fontSize: ukuran huruf dalam logical pixels
                fontSize: 32,
                
                // fontWeight: ketebalan huruf
                // FontWeight.bold: huruf tebal (700)
                fontWeight: FontWeight.bold,
                
                // color: warna teks (coklat lembut)
                color: Color(0xFF6B5744),
              ),
            ),
            
            // Jarak vertikal 8 pixels
            const SizedBox(height: 8),
            
            // Text untuk tagline/subtitle
            const Text(
              // \n adalah line break (enter/baris baru)
              'Belajar Islam\nSecara Interaktif',
              
              // textAlign: rata tengah
              textAlign: TextAlign.center,
              
              style: TextStyle(
                fontSize: 16,
                
                // color: warna dengan opacity 60%
                // .withOpacity(0.6) membuat warna transparan
                color: Color(0xFF6B5744),
              ),
            ),
          ],
        ),
      ),
    );
  }
}