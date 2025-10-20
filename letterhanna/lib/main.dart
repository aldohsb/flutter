// File: lib/main.dart
// Ini adalah file utama aplikasi Flutter kita.
// Setiap baris akan dijelaskan dengan komentar untuk pemula.
// Hari 1: Kita mulai dengan template default Flutter, tapi ubah title menjadi "LetterHanna".
// Nanti di hari berikutnya, kita akan edit file ini untuk tambah widget baru, seperti ganti home page menjadi tampilan e-commerce dummy.
// Import ini wajib: 'package:flutter/material.dart' menyediakan widget dasar seperti Scaffold, AppBar, dll.

import 'package:flutter/material.dart';

// Fungsi main(): Titik masuk aplikasi. Ini seperti "start" program.
// runApp() akan jalankan widget root kita, yaitu MyApp().
void main() {
  runApp(const MyApp()); // const: Membuat widget immutable (tidak berubah), efisien.
}

// Class MyApp: Widget root aplikasi. Ini StatelessWidget karena tidak punya state yang berubah.
// StatelessWidget: Widget statis, tidak berubah selama runtime (misal, teks tetap).
// Nanti di hari advance, kita akan ganti ke state management lebih kompleks.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor: super.key untuk inheritance dari StatelessWidget.

  // Method build(): Dipanggil Flutter untuk render UI.
  // Kembalikan widget tree (struktur UI).
  @override
  Widget build(BuildContext context) {
    // MaterialApp: Wrapper utama untuk app berbasis Material Design (UI style Google).
    // Ini sediakan theme, navigation, dll.
    return MaterialApp(
      title: 'LetterHanna', // Title app: Muncul di taskbar atau app switcher. Kita ubah dari default 'Flutter Demo' menjadi 'LetterHanna'.
      // Theme: Pengaturan warna/UI global. Hari ini default, nanti di hari 16-20 kita custom untuk elegant/classic (misal, primarySwatch: Colors.brown).
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Warna dasar sementara.
        useMaterial3: true, // Gunakan Material Design 3 (versi terbaru, lebih modern).
      ),
      // Home: Widget halaman utama. Saat ini MyHomePage (counter default).
      // Nanti di hari 6, kita ganti ke Navigator atau halaman custom.
      home: const MyHomePage(title: 'LetterHanna Home Page'),
    );
  }
}

// Class MyHomePage: Halaman utama. Ini StatefulWidget karena punya state yang berubah (counter).
// StatefulWidget: Widget dinamis, bisa update UI saat state berubah (misal, button ditekan).
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // Constructor: title wajib, untuk AppBar.

  final String title; // Variabel: Simpan title dari atas.

  // createState(): Buat state untuk widget ini.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Class _MyHomePageState: State private untuk MyHomePage.
// Di sinilah logic state (seperti counter) disimpan.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Variabel state: Counter mulai dari 0. Nanti di hari 10, kita ganti ke state management lain seperti Provider.

  // Method: Tambah counter saat button ditekan.
  void _incrementCounter() {
    // setState(): Update state dan rebuild UI. Ini basic state management untuk beginner.
    // Nanti di hari berikutnya, kita edit method ini atau ganti dengan logic e-commerce (misal, tambah item ke cart).
    setState(() {
      _counter++;
    });
  }

  // Method build(): Render UI halaman.
  @override
  Widget build(BuildContext context) {
    // Scaffold: Struktur dasar halaman (AppBar, body, floating button).
    // Ini seperti "frame" halaman.
    return Scaffold(
      appBar: AppBar( // AppBar: Header atas.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Warna dari theme.
        title: Text(widget.title), // Tampilkan title "LetterHanna Home Page".
      ),
      // Body: Isi utama halaman. Center: Letakkan child di tengah.
      body: Center(
        child: Column( // Column: Susun widget vertikal.
          mainAxisAlignment: MainAxisAlignment.center, // Tengah vertikal.
          children: <Widget>[ // List child widgets.
            const Text( // Text widget: Tampilkan teks statis.
              'You have pushed the button this many times:', // Teks default. Nanti edit jadi welcome message LetterHanna.
            ),
            Text( // Text dinamis: Tampilkan _counter.
              '$_counter', // $_counter: Convert int ke string.
              style: Theme.of(context).textTheme.headlineMedium, // Style dari theme.
            ),
          ],
        ),
      ),
      // FloatingActionButton: Tombol melayang kanan bawah.
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Panggil method increment saat ditekan.
        tooltip: 'Increment', // Tooltip saat hover.
        child: const Icon(Icons.add), // Icon plus.
      ),
    );
  }
}