import 'package:flutter/material.dart'; // MaterialApp dan widget dasar
import 'core/theme/app_theme.dart'; // tema aplikasi yang sudah kita rakit
import 'screens/home_screen.dart'; // halaman utama tempat kalkulator BMI berada

// widget root aplikasi, hanya bertugas memasang tema dan halaman awal
class BimikuApp extends StatelessWidget { // stateless karena root tidak punya state sendiri
  const BimikuApp({super.key}); // constructor const untuk optimasi rebuild

  @override
  Widget build(BuildContext context) { // method wajib untuk merender widget
    return MaterialApp( // widget pembungkus utama seluruh aplikasi
      title: 'Bimiku', // judul aplikasi, muncul di task switcher
      debugShowCheckedModeBanner: false, // menyembunyikan pita "debug" di pojok layar
      theme: AppTheme.light, // memasang tema terang yang sudah kita buat
      home: const HomeScreen(), // halaman pertama yang ditampilkan saat app dibuka
    );
  }
}