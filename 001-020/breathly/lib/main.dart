import 'package:flutter/material.dart'; // import library utama Flutter

void main() => runApp(const BreathlyApp()); // titik masuk app

class BreathlyApp extends StatelessWidget { // root widget, tidak punya state
  const BreathlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // setup app level: tema, routing
      debugShowCheckedModeBanner: false, // hilangkan banner DEBUG
      theme: ThemeData( // definisi tema global
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90D9), // biru tenang sebagai warna utama
          brightness: Brightness.dark, // dark mode — lebih cocok untuk app meditasi
        ),
        useMaterial3: true,
      ),
      home: const BreathScreen(), // arahkan ke BreathScreen
    );
  }
}

class BreathScreen extends StatelessWidget { // sementara StatelessWidget dulu — belum ada state
  const BreathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // layout dasar halaman
      body: Center( // konten di tengah layar
        child: Text( // teks placeholder sementara
          'breathly',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w200, // tipis — kesan tenang
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 6, // spasi huruf lebar — kesan minimalis
          ),
        ),
      ),
    );
  }
}