import 'package:flutter/material.dart';

// Fungsi utama - program dimulai dari sini
void main() {
  runApp(LetterHannaApp());
}

// Widget utama aplikasi
class LetterHannaApp extends StatelessWidget {
  const LetterHannaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letter Hanna Studio',
      debugShowCheckedModeBanner: false, // Hilangkan banner "Debug"
      theme: ThemeData(
        primaryColor: Color(0xFF2C1810), // Warna coklat gelap
      ),
      home: HomePage(),
    );
  }
}

// Halaman utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar = Header di atas
      appBar: AppBar(
        title: Text(
          'Letter Hanna Studio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1976D2),
        elevation: 2,
      ),

      // Body = Konten utama
      body: Container(
        color: Color(0xFFFFF8F0), // Background krem
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon/Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8D5C4),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '🎨', // ← Emoji baru
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),

                SizedBox(height: 30), // Jarak vertikal
                // Judul
                Text(
                  'Handwriting Fonts',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                // Deskripsi
                Text(
                  'Koleksi font tulisan tangan premium untuk\nmembuat desain Anda lebih personal dan menarik',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5C4033),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40),

                // Tombol
                ElevatedButton(
                  onPressed: () {
                    // Nanti kita akan tambahkan fungsi di sini
                    print('Tombol diklik!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B4513),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Jelajahi Koleksi Font',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
