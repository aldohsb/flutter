// Import package Flutter Material Design
// Material adalah design system dari Google yang sudah include berbagai widget
import 'package:flutter/material.dart';

// Fungsi main() adalah entry point aplikasi
// Ini fungsi pertama yang dijalankan saat app dibuka
void main() {
  // runApp() menjalankan aplikasi Flutter
  // Parameter yang diberikan adalah widget root (widget paling atas)
  runApp(const LetterhannaApp());
}

// Class LetterhannaApp adalah widget root kita
// StatelessWidget = widget yang tidak punya state (data yang berubah)
// const = nilai tetap, tidak berubah, lebih efisien untuk performa
class LetterhannaApp extends StatelessWidget {
  const LetterhannaApp({super.key});

  // Method build() wajib ada di setiap widget
  // Method ini mengembalikan tampilan UI widget
  // BuildContext adalah informasi lokasi widget di widget tree
  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget pembungkus aplikasi Material Design
    return MaterialApp(
      // title muncul di task switcher (tidak terlihat di layar app)
      title: 'Letterhanna',
      
      // debugShowCheckedModeBanner: false menghilangkan banner "DEBUG" di pojok
      debugShowCheckedModeBanner: false,
      
      // theme mengatur tampilan global aplikasi (warna, font, dll)
      theme: ThemeData(
        // primarySwatch adalah warna utama aplikasi
        // Colors.brown cocok untuk tema elegant classic
        primarySwatch: Colors.brown,
        
        // useMaterial3: true menggunakan Material Design 3 (versi terbaru)
        useMaterial3: true,
      ),
      
      // home adalah halaman pertama yang ditampilkan saat app dibuka
      home: const HomePage(),
    );
  }
}

// Class HomePage adalah halaman utama aplikasi
// StatelessWidget karena untuk hari ini kita hanya tampil teks static
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah struktur dasar halaman Material Design
    // Scaffold punya AppBar, Body, FloatingActionButton, dll
    return Scaffold(
      // AppBar adalah bar di bagian atas aplikasi
      appBar: AppBar(
        // title menampilkan judul di AppBar
        title: const Text('Letterhanna'),
        
        // centerTitle: true membuat title berada di tengah
        centerTitle: true,
        
        // backgroundColor mengatur warna background AppBar
        // Colors.brown.shade800 adalah coklat tua (elegant)
        backgroundColor: Colors.brown.shade800,
        
        // foregroundColor mengatur warna teks & icon di AppBar
        foregroundColor: Colors.white,
        
        // elevation adalah bayangan/shadow di bawah AppBar
        // 0 = tidak ada shadow (flat design, lebih modern)
        elevation: 0,
      ),
      
      // body adalah konten utama halaman (di bawah AppBar)
      body: Center(
        // Center membuat child-nya berada di tengah layar
        child: Column(
          // mainAxisAlignment mengatur posisi children di axis utama (vertikal untuk Column)
          // MainAxisAlignment.center = semua children di tengah secara vertikal
          mainAxisAlignment: MainAxisAlignment.center,
          
          // children adalah list widget-widget yang ditampilkan di Column
          children: [
            // Icon menampilkan icon dari Material Icons
            Icon(
              Icons.font_download,
              size: 80,
              color: Colors.brown.shade700,
            ),
            
            // SizedBox memberi jarak vertikal 24 pixel
            const SizedBox(height: 24),
            
            // Text menampilkan teks
            const Text(
              'Welcome to Letterhanna',
              // style mengatur tampilan teks
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            
            const SizedBox(height: 12),
            
            const Text(
              'Handwriting Fonts Collection',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Container seperti div di HTML, bisa punya padding, margin, decoration
            Container(
              // padding adalah jarak dari tepi container ke content
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              
              // decoration mengatur tampilan container (warna, border, shadow, dll)
              decoration: BoxDecoration(
                color: Colors.brown.shade800,
                // borderRadius membuat sudut container melengkung
                borderRadius: BorderRadius.circular(30),
                // boxShadow memberi bayangan
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}