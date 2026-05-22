import 'dart:async';                                      // diperlukan untuk Timer
import 'package:flutter/material.dart';                  // diperlukan untuk StatefulWidget, Scaffold, dll
import 'package:timerbox/models/timer_state.dart';       // impor enum TimerState dari models
import 'package:timerbox/widgets/timer_button.dart';     // impor widget TimerButton dari widgets

class TimerScreen extends StatefulWidget {               // layar utama — dipindah dari main.dart ke file sendiri
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;                                      // total detik yang sudah berjalan
  Timer? _timer;                                         // objek timer — null saat idle atau paused
  TimerState _state = TimerState.idle;                   // status awal: belum mulai
  List<String> _laps = [];                               // daftar waktu lap — string MM:SS

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();                                    // hentikan timer saat layar ditutup
    super.dispose();
  }

  void _start() {
    setState(() => _state = TimerState.running);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() => _seconds++);
      },
    );
  }

  void _pause() {
    _timer?.cancel();
    setState(() => _state = TimerState.paused);
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _state = TimerState.idle;
      _laps = [];                                        // kosongkan daftar lap saat reset
    });
  }

  void _lap() {
    setState(() {
      _laps.insert(0, _formatTime());                    // lap terbaru selalu di index 0 — tampil paling atas
    });
  }

  String _formatTime() {                                 // ubah total detik ke format MM:SS
    final int minutes = _seconds ~/ 60;                  // integer division — ambil menit utuh
    final int seconds = _seconds % 60;                   // modulo — ambil sisa detik
    final String mm = minutes.toString().padLeft(2, '0'); // selalu 2 digit
    final String ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss';
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
      body: Column(
        children: [
          const SizedBox(height: 60),                    // spacer atas — ganti peran mainAxisAlignment.center
          Text(
            _formatTime(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()],
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_state == TimerState.idle) ...[
                TimerButton(                             // pakai TimerButton — bukan ElevatedButton langsung
                  label: 'Start',
                  color: Colors.green,
                  onPressed: _start,
                ),
              ],
              if (_state == TimerState.running) ...[
                TimerButton(label: 'Lap',   color: Colors.white54, onPressed: _lap),
                const SizedBox(width: 16),
                TimerButton(label: 'Pause', color: Colors.orange,  onPressed: _pause),
                const SizedBox(width: 16),
                TimerButton(label: 'Reset', color: Colors.red,     onPressed: _reset),
              ],
              if (_state == TimerState.paused) ...[
                TimerButton(label: 'Resume', color: Colors.green, onPressed: _start),
                const SizedBox(width: 16),
                TimerButton(label: 'Reset',  color: Colors.red,   onPressed: _reset),
              ],
            ],
          ),
          const SizedBox(height: 24),
          if (_laps.isNotEmpty)                          // divider hanya muncul kalau ada lap
            const Divider(color: Colors.white24, thickness: 1),
          Expanded(                                      // beri sisa ruang Column ke ListView
            child: ListView.builder(
              itemCount: _laps.length,                   // jumlah item = jumlah lap
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // label kiri, waktu kanan
                    children: [
                      Text(
                        'Lap ${_laps.length - index}',  // nomor lap terbalik — terbaru di atas
                        style: const TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      Text(
                        _laps[index],                    // waktu MM:SS yang disimpan saat lap ditekan
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}