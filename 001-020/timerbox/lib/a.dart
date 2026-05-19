import 'dart:async';                              // impor library async — diperlukan untuk kelas Timer
import 'package:flutter/material.dart';          // impor Material Design — wajib ada di setiap app Flutter

void main() => runApp(const TimerBoxApp());      // titik masuk app — langsung jalankan TimerBoxApp

enum TimerState { idle, running, paused }        // tiga kemungkinan status timer — idle=belum mulai, running=jalan, paused=dijeda

class TimerBoxApp extends StatelessWidget {
  const TimerBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimerBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;                              // jumlah detik yang sudah berjalan
  Timer? _timer;                                 // objek timer — null saat idle atau paused
  TimerState _state = TimerState.idle;           // status awal: belum mulai — menentukan tombol mana yang muncul

  @override
  void initState() {
    super.initState();                           // initState sekarang kosong — timer tidak auto-start
  }

  @override
  void dispose() {
    _timer?.cancel();                            // pastikan timer berhenti saat widget dihancurkan
    super.dispose();
  }

  void _start() {                                // dipanggil saat tombol Start atau Resume ditekan
    setState(() => _state = TimerState.running); // ubah status ke running — UI akan rebuild dan tampilkan tombol Pause
    _timer = Timer.periodic(                     // mulai timer baru
      const Duration(seconds: 1),
      (timer) {
        setState(() => _seconds++);              // naikkan detik setiap tick — setState agar UI ikut update
      },
    );
  }

  void _pause() {                                // dipanggil saat tombol Pause ditekan
    _timer?.cancel();                            // hentikan timer — tapi _seconds tidak direset, jadi bisa dilanjut
    setState(() => _state = TimerState.paused);  // ubah status ke paused — UI rebuild, tombol Resume muncul
  }

  void _reset() {                                // dipanggil saat tombol Reset ditekan
    _timer?.cancel();                            // hentikan timer dulu sebelum reset
    setState(() {
      _seconds = 0;                              // kembalikan angka ke 0
      _state = TimerState.idle;                  // kembalikan status ke idle — tombol Start muncul lagi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'TimerBox',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(                              // susun angka dan tombol secara vertikal
        mainAxisAlignment: MainAxisAlignment.center, // pusatkan seluruh kolom ke tengah layar
        children: [
          Text(
            '$_seconds',                         // tampilkan detik yang sudah berjalan
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 48),            // jarak vertikal antara angka dan tombol
          Row(                                   // susun tombol secara horizontal
            mainAxisAlignment: MainAxisAlignment.center, // pusatkan baris tombol
            children: [
              if (_state == TimerState.idle) ...[          // idle: hanya tampilkan tombol Start
                _buildButton('Start', Colors.green, _start),
              ],
              if (_state == TimerState.running) ...[       // running: tampilkan Pause dan Reset
                _buildButton('Pause', Colors.orange, _pause),
                const SizedBox(width: 16),                // jarak antar tombol
                _buildButton('Reset', Colors.red, _reset),
              ],
              if (_state == TimerState.paused) ...[        // paused: tampilkan Resume dan Reset
                _buildButton('Resume', Colors.green, _start), // Resume pakai _start — logikanya sama, lanjut dari _seconds sekarang
                const SizedBox(width: 16),
                _buildButton('Reset', Colors.red, _reset),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) { // helper buat tombol agar tidak duplikasi kode
    return ElevatedButton(                       // tombol dengan efek bayangan
      onPressed: onPressed,                      // callback — fungsi yang dipanggil saat ditekan
      style: ElevatedButton.styleFrom(
        backgroundColor: color,                  // warna latar tombol sesuai parameter
        foregroundColor: Colors.white,           // warna teks dan ikon putih
        padding: const EdgeInsets.symmetric(     // padding dalam tombol — supaya tidak terlalu sempit
          horizontal: 28,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(           // bentuk tombol — sudut membulat
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,                                   // teks tombol sesuai parameter
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}