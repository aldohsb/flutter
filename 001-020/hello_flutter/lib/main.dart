import 'package:flutter/material.dart'; // impor library material flutter

void main() {
  // titik masuk program
  runApp(
    // jalankan aplikasi
    MaterialApp(
      // shell aplikasi material design
      home: Scaffold(
        // halaman utama dengan struktur dasar
        appBar: AppBar(
          // bar di atas layar
          title: const Text('HelloFlutter'), // judul aplikasi di appbar
        ),
        body: const Center(
          // body halaman, Center = di tengah
          child: Text('Halo Dunia!!!!'), // teks yang ditampilkan di tengah
        ),
      ),
    ),
  );
}
