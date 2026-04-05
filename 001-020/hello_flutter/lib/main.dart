// =============================================================
// lib/main.dart — File utama aplikasi HelloFlutter
// Ini adalah titik masuk (entry point) aplikasi Flutter
// Flutter membaca file ini pertama kali saat aplikasi dijalankan
// =============================================================

// Import package flutter/material.dart
// Ini seperti "import" di JavaScript atau "use" di Python
// material.dart berisi semua widget utama Flutter:
// MaterialApp, Scaffold, Text, Column, Center, Image, dll.
import 'package:flutter/material.dart';

// =============================================================
// Fungsi main() — Pintu Masuk Aplikasi
// Dart WAJIB punya fungsi bernama main() sebagai entry point
// Tanpa ini, aplikasi tidak akan bisa dijalankan
// =============================================================
void main() {
  // runApp() adalah fungsi Flutter yang "menyalakan" aplikasi
  // Parameter yang diterima adalah sebuah widget (root widget)
  // Widget ini akan menjadi "akar" dari seluruh pohon widget aplikasimu
  runApp(const HelloFlutterApp());
  // const = nilai widget ini tidak akan berubah, lebih efisien di memori
}

// =============================================================
// Class HelloFlutterApp — Widget Root Aplikasi
// Ini adalah widget PALING ATAS (root) di seluruh aplikasi
// StatelessWidget = widget yang tampilannya tidak berubah setelah dibuat
// =============================================================
class HelloFlutterApp extends StatelessWidget {
  // Constructor — cara membuat instance dari class ini
  // const = bisa dibuat sebagai konstanta (lebih efisien)
  const HelloFlutterApp({super.key});
  // super.key = meneruskan parameter 'key' ke parent class (StatelessWidget)
  // 'key' digunakan Flutter untuk mengidentifikasi widget secara unik di pohon widget

  // =============================================================
  // Method build() — WAJIB ada di setiap Widget
  // Flutter memanggil method ini untuk menggambar widget ke layar
  // BuildContext = informasi tentang "posisi" widget ini di pohon widget
  // =============================================================
  @override
  Widget build(BuildContext context) {
    // @override = kita menimpa (override) method build() dari parent class

    // MaterialApp adalah widget khusus yang WAJIB ada sebagai root aplikasi
    // Ia menyediakan: navigasi, tema, internasionalisasi, debug banner, dll.
    return MaterialApp(
      title: 'Hello Flutter',
      // title = nama aplikasi (dipakai di app switcher / recent apps di HP)

      debugShowCheckedModeBanner: false,
      // false = sembunyikan label merah "DEBUG" di pojok kanan atas
      // Di development kita sembunyikan agar tampilan terlihat bersih

      // theme = mengatur tema visual seluruh aplikasi (warna, font, bentuk)
      theme: ThemeData(
        // colorScheme = skema warna utama aplikasi
        // fromSeed() = generate seluruh skema warna dari satu warna benih
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          // 0xFF = prefix untuk warna hex di Dart (FF = opacity 100%)
          // 1A1A2E = warna biru-navy gelap, ini "warna favorit" di contoh ini
          // Ganti dengan warna favoritmu sendiri!
          //
          // Contoh warna lain:
          // 0xFF2E7D32 = hijau gelap
          // 0xFFB71C1C = merah gelap
          // 0xFF4A148C = ungu gelap
        ),
        useMaterial3: true,
        // useMaterial3 = aktifkan Material Design 3 (desain terbaru Google, 2022+)
        // Selalu gunakan true untuk project baru di 2025-2026
      ),

      // home = widget yang tampil pertama kali saat aplikasi dibuka
      // Ini seperti "halaman utama" aplikasimu
      home: const ProfileScreen(),
    );
  }
}

// =============================================================
// Class ProfileScreen — Layar Utama Aplikasi
// Widget ini merepresentasikan SATU LAYAR PENUH aplikasi
// Dipisah dari HelloFlutterApp agar kode lebih rapi dan modular
// =============================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = "kerangka" halaman standar Material Design
    // Ia menyediakan: AppBar (header), body (isi), FloatingActionButton, Drawer, dll.
    // Hampir setiap halaman aplikasi Flutter dimulai dengan Scaffold
    return Scaffold(
      // backgroundColor = warna latar belakang halaman
      // Kita set manual agar tidak bergantung pada tema default
      backgroundColor: const Color(0xFF1A1A2E),
      // Warna sama dengan seedColor di theme → konsistensi visual

      // body = area utama konten halaman (di bawah AppBar, di atas BottomNav)
      body: Center(
        // Center = widget yang memposisikan child-nya ke TENGAH layar
        // Baik secara horizontal (kiri-kanan) maupun vertikal (atas-bawah)
        // Tanpa Center, widget akan muncul di pojok kiri atas

        child: Column(
          // Column = susun widget-widget secara VERTIKAL (dari atas ke bawah)
          // Analogi Figma: seperti Auto Layout dengan direction Vertical

          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisAlignment = mengatur posisi children di sepanjang sumbu utama
          // Untuk Column, sumbu utama = vertikal (atas-bawah)
          // MainAxisAlignment.center = tempatkan semua children di tengah vertikal

          crossAxisAlignment: CrossAxisAlignment.center,
          // crossAxisAlignment = mengatur posisi children di sumbu silang
          // Untuk Column, sumbu silang = horizontal (kiri-kanan)
          // CrossAxisAlignment.center = tengahkan secara horizontal

          children: [
            // children = daftar widget yang akan disusun Column
            // Urutan dalam list = urutan tampil dari atas ke bawah

            // ---------------------------------------------------------
            // WIDGET 1: Foto Profil
            // Dibungkus Container untuk styling tambahan (border, shadow)
            // ---------------------------------------------------------
            Container(
              // Container = widget serbaguna untuk styling & layout
              // Bisa tambahkan: warna, border, padding, shadow, ukuran, dll.

              width: 150,  // lebar container dalam logical pixels
              height: 150, // tinggi container dalam logical pixels
              // Di Flutter, satuan ukuran adalah "logical pixels" bukan pixel fisik
              // Logical pixels otomatis menyesuaikan densitas layar HP

              decoration: BoxDecoration(
                // BoxDecoration = tempat mendefinisikan tampilan visual Container

                shape: BoxShape.circle,
                // BoxShape.circle = buat Container berbentuk lingkaran
                // Ini yang membuat foto profil tampil bulat

                border: Border.all(
                  // Border.all = tambahkan garis border di semua sisi
                  color: const Color(0xFF6C63FF),
                  // Warna border: ungu-biru (aksen/highlight)
                  width: 3,
                  // Tebal border: 3 logical pixels
                ),

                boxShadow: [
                  // boxShadow = tambahkan efek bayangan di bawah Container
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                    // withValues(alpha: 0.4) = warna yang sama tapi 40% transparan
                    // Ini membuat efek "glow" yang lembut di sekitar foto
                    blurRadius: 20,
                    // blurRadius = seberapa blur bayangan (semakin besar, semakin kabur)
                    spreadRadius: 2,
                    // spreadRadius = seberapa besar bayangan menyebar
                  ),
                ],
              ),

              // ClipOval = widget yang memotong (clip) child-nya menjadi bentuk oval/lingkaran
              // WAJIB ada agar gambar ikut berbentuk bulat mengikuti Container
              child: ClipOval(
                child: Image.asset(
                  // Image.asset = tampilkan gambar dari folder assets lokal
                  'assets/images/profile.png',
                  // Path harus sama persis dengan yang ada di pubspec.yaml
                  // dan dengan nama file fisiknya

                  width: 150,  // lebar gambar (sama dengan container)
                  height: 150, // tinggi gambar
                  fit: BoxFit.cover,
                  // BoxFit.cover = gambar mengisi seluruh area container
                  // Bagian yang keluar akan dipotong (tidak ada space kosong)
                  // Seperti "object-fit: cover" di CSS

                  // errorBuilder = tampilkan widget ini jika gambar gagal dimuat
                  // Sangat berguna selama development atau jika file belum ada
                  errorBuilder: (context, error, stackTrace) {
                    // Jika gambar tidak ditemukan, tampilkan ikon sebagai fallback
                    return Container(
                      width: 150,
                      height: 150,
                      color: const Color(0xFF2D2D44),
                      // Warna abu-abu gelap sebagai background placeholder
                      child: const Icon(
                        Icons.person,
                        // Icons.person = ikon siluet orang dari Material Icons
                        size: 80,
                        color: Color(0xFF6C63FF),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Akhir Widget 1 (foto profil)

            const SizedBox(height: 32),
            // SizedBox = widget kosong dengan ukuran tertentu
            // Digunakan sebagai "spacer" (jarak) antar widget
            // height: 32 = beri jarak 32px ke bawah
            // Analogi Figma: seperti mengatur Gap di Auto Layout

            // ---------------------------------------------------------
            // WIDGET 2: Nama
            // ---------------------------------------------------------
            const Text(
              'Aldo Setiawan',
              // Ganti dengan namamu sendiri!

              style: TextStyle(
                // TextStyle = mengatur tampilan teks

                fontSize: 28,
                // Ukuran font dalam logical pixels

                fontWeight: FontWeight.bold,
                // FontWeight.bold = teks tebal

                color: Colors.white,
                // Warna teks: putih agar kontras dengan background gelap

                letterSpacing: 1.2,
                // letterSpacing = jarak antar huruf (tracking)
                // 1.2 = sedikit lebih renggang dari default, lebih elegan
              ),
            ),
            // Akhir Widget 2 (nama)

            const SizedBox(height: 8),
            // Jarak 8px antara nama dan subtitle (lebih kecil dari sebelumnya)

            // ---------------------------------------------------------
            // WIDGET 3: Subtitle / Profesi
            // ---------------------------------------------------------
            const Text(
              'Font Designer & Flutter Developer',
              // Subtitle — bisa diisi profesi, motto, atau deskripsi singkat

              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFAAAAAA),
                // Warna abu-abu terang — lebih redup dari nama agar ada hierarki visual
                // Hierarki visual = nama lebih menonjol, subtitle lebih kalem

                letterSpacing: 0.8,
              ),
            ),
            // Akhir Widget 3 (subtitle)

            const SizedBox(height: 40),
            // Jarak lebih besar sebelum divider

            // ---------------------------------------------------------
            // WIDGET 4: Divider dekoratif
            // Garis horizontal tipis sebagai pemisah visual
            // ---------------------------------------------------------
            Container(
              width: 60,       // Garis pendek, hanya 60px
              height: 2,       // Ketebalan 2px
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                // Warna ungu-biru, sama dengan border foto → konsistensi

                borderRadius: BorderRadius.circular(1),
                // borderRadius = membuat sudut rounded
                // circular(1) = radius 1px, membuat ujung garis sedikit bulat
              ),
            ),
            // Akhir Widget 4 (divider)

            const SizedBox(height: 40),

            // ---------------------------------------------------------
            // WIDGET 5: Info Cards (lokasi & keahlian)
            // Row = susun widget secara HORIZONTAL
            // ---------------------------------------------------------
            Row(
              // Row = susun children secara horizontal (kiri ke kanan)
              // Analogi Figma: Auto Layout dengan direction Horizontal

              mainAxisAlignment: MainAxisAlignment.center,
              // Pusatkan Row secara horizontal

              mainAxisSize: MainAxisSize.min,
              // MainAxisSize.min = Row hanya selebar kontennya, tidak stretch penuh
              // Tanpa ini Row akan memenuhi lebar layar

              children: [
                // Info chip pertama: lokasi
                _buildInfoChip(
                  icon: Icons.location_on,
                  label: 'Yogyakarta, ID',
                ),
                // Panggil method _buildInfoChip (didefinisikan di bawah)
                // Kita memisahkan kode yang berulang ke dalam method tersendiri

                const SizedBox(width: 12),
                // Jarak horizontal 12px antara dua chip

                // Info chip kedua: keahlian
                _buildInfoChip(
                  icon: Icons.palette,
                  label: 'Font Design',
                ),
              ],
            ),
            // Akhir Widget 5 (info cards)
          ],
          // Akhir children Column
        ),
        // Akhir Column
      ),
      // Akhir Center
    );
    // Akhir Scaffold
  }

  // =============================================================
  // Method Helper: _buildInfoChip()
  // Method private (awalan underscore _) = hanya bisa dipakai dalam class ini
  // Fungsinya: membuat "chip" kecil dengan ikon dan label
  // Kenapa dipisah? Karena chip ini muncul DUA KALI — DRY principle!
  // DRY = Don't Repeat Yourself — jangan tulis kode yang sama berulang kali
  // =============================================================
  Widget _buildInfoChip({
    required IconData icon,
    // required = parameter WAJIB diisi saat memanggil method ini
    // IconData = tipe data untuk ikon Material Icons

    required String label,
    // String = tipe data teks
  }) {
    // Method ini mengembalikan (return) sebuah Widget
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        // padding horizontal 16px (kiri dan kanan)
        vertical: 8,
        // padding vertikal 8px (atas dan bawah)
      ),
      // EdgeInsets.symmetric = shortcut untuk padding yang simetris

      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        // Warna background chip: abu-abu gelap (sedikit lebih terang dari bg utama)
        // Ini menciptakan kedalaman/layering visual

        borderRadius: BorderRadius.circular(20),
        // circular(20) = sudut sangat membulat → tampak seperti pill/kapsul

        border: Border.all(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
          // Border tipis dengan warna aksen yang transparan (30%)
        ),
      ),

      child: Row(
        // Row kecil di dalam chip: ikon di kiri, teks di kanan
        mainAxisSize: MainAxisSize.min,
        // min = hanya selebar isi konten

        children: [
          Icon(
            icon,
            // icon = parameter yang diterima dari caller
            size: 14,
            color: const Color(0xFF6C63FF),
          ),

          const SizedBox(width: 6),
          // Jarak kecil antara ikon dan teks

          Text(
            label,
            // label = teks yang diterima dari caller
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFCCCCCC),
              // Abu-abu terang untuk teks chip
            ),
          ),
        ],
      ),
    );
  }
  // Akhir method _buildInfoChip
}
// Akhir class ProfileScreen