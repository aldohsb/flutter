import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

// ============================================================================
// HOME PAGE - Halaman Utama Aplikasi
// ============================================================================
// Penjelasan: HomePage adalah halaman pertama yang dilihat user
// StatelessWidget digunakan karena untuk Hari 1 belum perlu data dinamis

class HomePage extends StatelessWidget {
  // StatelessWidget = Widget tanpa state (data yang berubah)
  // Perfect untuk Hari 1 karena kita hanya menampilkan dummy data yang static
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // build() mengembalikan widget tree (hierarchy UI)
    // context berisi informasi tentang lokasi widget di tree
    
    return Scaffold(
      // Scaffold: widget dasar untuk struktur halaman Material Design
      // Menyediakan: AppBar, Body, BottomNavigationBar, FloatingActionButton, dll
      
      // ===== APPBAR (Header/Toolbar) =====
      appBar: AppBar(
        // AppBar: widget header di bagian atas halaman
        
        elevation: 0,
        // elevation: 0 - menghilangkan shadow di bawah appbar (design minimal)
        
        backgroundColor: const Color(0xFFFAF9F7),
        // backgroundColor: warna background appbar sama dengan background halaman
        // Membuat kesan seamless, elegant
        
        centerTitle: true,
        // centerTitle: true - memposisikan title di tengah (iOS style, elegant)
        
        title: Text(
          // title: text yang ditampilkan di tengah appbar
          
          'Letterhanna',
          // Text yang ditampilkan
          
          style: GoogleFonts.playfairDisplay(
            // GoogleFonts.playfairDisplay: menggunakan font Playfair Display
            // Font ini elegant, classic, cocok untuk brand premium
            
            fontSize: 28,
            // fontSize: ukuran teks
            
            fontWeight: FontWeight.w700,
            // fontWeight: w700 = Bold (800 adalah paling tebal, 100 paling tipis)
            
            color: const Color(0xFF2C2C2C),
            // color: warna teks = coklat tua
            
            letterSpacing: 0.5,
            // letterSpacing: jarak antar huruf (membuat kesan elegant)
          ),
        ),
        
        leading: IconButton(
          // leading: widget di sebelah kiri appbar (biasanya back button)
          // IconButton: button berbentuk icon yang clickable
          
          icon: const Icon(Icons.menu),
          // icon: icon yang ditampilkan (menu kebab)
          
          onPressed: () {
            // onPressed: callback function saat button ditekan
            // Untuk Hari 1 kosong dulu (akan diimplementasi di hari selanjutnya)
            // Nantinya ini akan buka drawer/sidebar
          },
          
          color: const Color(0xFF2C2C2C),
          // color: warna icon
        ),
        
        actions: [
          // actions: widget di sebelah kanan appbar (biasanya icon buttons)
          
          IconButton(
            // Icon search
            icon: const Icon(Icons.search),
            onPressed: () {
              // Nantinya buka halaman search
            },
            color: const Color(0xFF2C2C2C),
          ),
          
          IconButton(
            // Icon shopping cart (keranjang belanja)
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              // Nantinya navigate ke cart page
            },
            color: const Color(0xFF2C2C2C),
          ),
        ],
      ),
      
      // ===== BODY (Konten Utama) =====
      body: SingleChildScrollView(
        // SingleChildScrollView: membuat content bisa di-scroll vertikal
        // Diperlukan agar semua konten bisa dilihat di layar kecil
        
        child: Padding(
          // Padding: memberi jarak di semua sisi (top, bottom, left, right)
          
          padding: const EdgeInsets.all(16),
          // padding: 16 points di semua sisi (standard padding Material Design)
          
          child: Column(
            // Column: widget yang menyusun child secara vertikal (top to bottom)
            // Analoginya: VStack di SwiftUI atau LinearLayout vertikal di Android
            
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: alignment horizontal
            // start = left (untuk LTR languages seperti Indonesia)
            
            children: [
              // ===== SECTION: HERO BANNER =====
              // Banner besar di atas yang menarik perhatian
              
              Container(
                // Container: widget dasar untuk custom styling
                
                width: double.infinity,
                // width: double.infinity = lebar penuh sesuai parent
                
                height: 200,
                // height: tinggi container
                
                decoration: BoxDecoration(
                  // decoration: styling border, background, shadow, dll
                  
                  color: AppColors.accentBeige,
                  // color: warna background (cream/beige) dari constants
                  
                  borderRadius: BorderRadius.circular(16),
                  // borderRadius: membuat sudut rounded
                  // circular(16) = semua sudut melengkung dengan radius 16
                  
                  boxShadow: AppShadows.md,
                  // boxShadow: shadow preset dari constants (reusable!)
                ),
                
                child: Center(
                  // Center: menempatkan child di tengah
                  
                  child: Column(
                    // Column di dalam Container untuk stack vertikal
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: center = rata tengah vertikal
                    
                    children: [
                      Text(
                        'New Collection',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // SizedBox: memberi jarak antar widget
                      // height: 8 = jarak 8 points ke bawah
                      
                      Text(
                        'Handwriting Fonts Collection 2024',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ElevatedButton(
                        // ElevatedButton: tombol Material Design yang menonjol
                        // (vs TextButton yang flat, vs OutlinedButton yang outline)
                        
                        onPressed: () {
                          // Action saat tombol ditekan
                          // Nantinya navigate ke collection page
                        },
                        
                        style: ElevatedButton.styleFrom(
                          // styleFrom: custom styling untuk button
                          
                          backgroundColor: AppColors.primaryDark,
                          // backgroundColor: warna button dari constants
                          
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          // padding: jarak dari text ke edge button
                          // symmetric: padding sama di kiri-kanan (horizontal) dan atas-bawah (vertical)
                        ),
                        
                        child: Text(
                          'Explore Now',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              // Jarak besar antar section
              
              // ===== SECTION: FEATURED PRODUCTS =====
              Text(
                'Featured Products',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Grid produk - Hari 1 pakai dummy data
              GridView.count(
                // GridView.count: menampilkan items dalam grid dengan fixed column count
                
                crossAxisCount: 2,
                // crossAxisCount: jumlah kolom = 2 (untuk responsive di mobile)
                
                shrinkWrap: true,
                // shrinkWrap: true = grid tidak scroll sendiri, 
                // dia ikut scroll parent (SingleChildScrollView)
                
                physics: const NeverScrollableScrollPhysics(),
                // physics: NeverScrollableScrollPhysics = disable scrolling pada grid
                // Karena sudah di dalam SingleChildScrollView
                
                mainAxisSpacing: 16,
                // mainAxisSpacing: jarak vertikal antar item
                
                crossAxisSpacing: 16,
                // crossAxisSpacing: jarak horizontal antar item
                
                children: List.generate(
                  // List.generate: membuat list dengan jumlah items tertentu
                  // Lebih efisien daripada menulis manual
                  
                  4,
                  // 4: jumlah produk yang ingin ditampilkan
                  
                  (index) => _buildProductCard(index + 1),
                  // Function yang dijalankan untuk setiap item (0, 1, 2, 3)
                  // index + 1: mengubah index 0 menjadi 1 untuk nomor produk
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // ========================================================================
  // HELPER FUNCTION: BUILD PRODUCT CARD
  // ========================================================================
  // Penjelasan: Function terpisah untuk membuat card produk
  // Benefit: Reusable, code lebih clean, mudah di-maintain
  
  Widget _buildProductCard(int productNumber) {
    // productNumber: parameter untuk membedakan setiap produk
    
    return               Container(
            // Container: wrapper untuk styling card
            
            decoration: BoxDecoration(
              // Styling card: background, border, shadow
              
              color: Colors.white,
              // color: white background untuk card
              
              borderRadius: BorderRadius.circular(12),
              // borderRadius: sudut yang melengkung
              
              boxShadow: AppShadows.md,
              // boxShadow: shadow preset dari constants
            ),
      
      child: Column(
        // Column: stack vertikal untuk gambar, title, price
        
        crossAxisAlignment: CrossAxisAlignment.start,
        // crossAxisAlignment: start = align ke kiri
        
        children: [
          // ===== PRODUCT IMAGE =====
          Container(
            // Container untuk background gambar (placeholder Hari 1)
            
            width: double.infinity,
            height: 140,
            // Dimensi gambar
            
            decoration: BoxDecoration(
              // Styling container gambar
              
              color: Color(0xFFF0F0F0),
              // color: warna placeholder (abu-abu terang)
              
              borderRadius: const BorderRadius.only(
                // borderRadius: hanya top-left dan top-right yang rounded
                // Agar sesuai dengan border card
                
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            
            child: Center(
              // Center: tempatkan icon di tengah
              
              child: Icon(
                // Icon placeholder untuk gambar font
                
                Icons.image,
                // Icons.image: icon gambar dari Material Icons
                
                size: 48,
                color: Colors.grey[400],
              ),
            ),
          ),
          
          // ===== PRODUCT INFO =====
          Padding(
            // Padding: jarak dari tepi
            
            padding: const EdgeInsets.all(12),
            // padding: 12 points di semua sisi
            
            child: Column(
              // Column: stack info produk
              
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                // Product name
                Text(
                  'Font Pack #$productNumber',
                  // Dummy name: Font Pack #1, Font Pack #2, dll
                  
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                  
                  maxLines: 1,
                  // maxLines: 1 = text hanya 1 baris
                  
                  overflow: TextOverflow.ellipsis,
                  // overflow: ellipsis = text panjang ditampilkan dengan ...
                ),
                
                const SizedBox(height: 6),
                
                // Product price
                Text(
                  'Rp 49.999',
                  // Dummy price
                  
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PENJELASAN HARI 1:
// ============================================================================
// ✅ Yang sudah dibuat:
// 1. AppBar elegant dengan logo Letterhanna
// 2. Hero banner untuk featured collection
// 3. Grid products dengan dummy data
// 4. Styling elegant classic dengan warna coklat-cream
// 5. Google Fonts (Figaro + Poppins) untuk professional look
//
// ❌ Yang BELUM dibuat (akan ditambah di hari berikutnya):
// 1. State Management (belum perlu untuk Hari 1)
// 2. Real data / API (masih dummy)
// 3. Navigation antar halaman
// 4. Bottom navigation bar
// 5. Product detail page
// 6. Shopping cart
// 7. Database lokal
//
// 📝 CATATAN UNTUK HARI SELANJUTNYA:
// - Hari 2: Refactor menjadi StatefulWidget jika perlu, tambah interaksi
// - Hari 3: Buat model data, import dummy data dari file terpisah
// - Hari 4: Buat navigation dan halaman product detail
// - Dst...
//
// Keuntungan structure ini:
// ✅ Sudah terlihat hasil yang professional
// ✅ Mudah dipahami untuk pemula
// ✅ Siap di-extend tanpa banyak refactor
// ============================================================================