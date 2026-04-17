import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../core/data/food_data.dart';
import '../models/food_item.dart';
import '../widgets/food_card_widget.dart';
import '../widgets/food_card_shimmer.dart';

class FoodGalleryScreen extends StatefulWidget {
  // StatefulWidget — layar ini punya state yang berubah:
  // 1. Kategori yang sedang dipilih (_selectedCategory)
  // 2. Status loading gambar (_isLoading)
  // StatelessWidget tidak cukup untuk kasus ini
  const FoodGalleryScreen({super.key});

  @override
  State<FoodGalleryScreen> createState() => _FoodGalleryScreenState();
  // createState() membuat instance State yang terpisah dari widget
  // Widget dan State adalah dua objek berbeda di Flutter
}

class _FoodGalleryScreenState extends State<FoodGalleryScreen> {
  // Konvensi nama: awali dengan _ (private) dan akhiri dengan 'State'
  // Nama terhubung ke StatefulWidget-nya: FoodGalleryScreen → _FoodGalleryScreenState

  String _selectedCategory = 'Semua';
  // Variabel state: kategori yang sedang aktif/dipilih
  // Nilai awal 'Semua' — tampilkan semua makanan saat pertama buka

  bool _isLoading = true;
  // Variabel state: menandakan apakah shimmer placeholder ditampilkan
  // true = tampilkan shimmer, false = tampilkan konten asli

  @override
  void initState() {
    super.initState();
    // initState() dipanggil SEKALI saat widget pertama kali dibuat
    // Seperti componentDidMount() di React
    // super.initState() WAJIB dipanggil pertama sebelum kode lainnya

    Future.delayed(const Duration(milliseconds: 800), () {
      // Future.delayed: jalankan kode setelah jeda waktu tertentu
      // Mensimulasikan loading data dari API (di app nyata ini diganti fetch data asli)
      if (mounted) {
        // mounted: cek apakah widget masih ada di pohon widget
        // Penting! setState() tidak boleh dipanggil setelah widget di-dispose
        setState(() => _isLoading = false);
        // setState(): beritahu Flutter ada state yang berubah → rebuild widget
        // Tanpa setState(), _isLoading berubah tapi UI tidak diperbarui
      }
    });
  }

  List<FoodItem> get _filteredMenu {
    // getter yang menghitung list makanan berdasarkan kategori yang dipilih
    // Dipanggil seperti properti: _filteredMenu (bukan _filteredMenu())
    if (_selectedCategory == 'Semua') return FoodData.menu;
    // Jika 'Semua', kembalikan seluruh menu tanpa filter

    return FoodData.menu.where((item) => item.category == _selectedCategory).toList();
    // .where() = filter List — hanya ambil elemen yang memenuhi kondisi
    // Lambda (item) => item.category == _selectedCategory:
    //   untuk setiap 'item' di menu, periksa apakah category-nya sesuai
    // .toList() = konversi hasil Iterable ke List
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          // Column utama: header (tetap) + konten (bisa discroll)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            // Header tidak ikut discroll — tetap di atas

            _buildCategoryFilter(),
            // Filter kategori juga tidak ikut discroll

            Expanded(
              // Expanded: ambil semua sisa ruang vertikal untuk daftar card
              // Tanpa Expanded, ListView tidak tahu harus berapa tingginya
              child: _isLoading ? _buildShimmerList() : _buildFoodList(),
              // Ternary: jika _isLoading true → shimmer, jika false → daftar asli
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FoodSnap 🍽️',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      // w800 = ExtraBold, lebih tebal dari bold (w700)
                      color: AppColors.textPrimary,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kuliner terbaik Yogyakarta',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              // Tombol pencarian di pojok kanan atas (dekoratif, belum fungsional)
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowCard,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSummaryRow(),
          // Baris ringkasan: total menu + total tersedia
        ],
      ),
    );
  }

  Widget _buildSummaryRow() {
    final int totalMenu = FoodData.menu.length;
    // .length: properti List yang mengembalikan jumlah elemen
    // final di sini: nilai dihitung sekali saat build, tidak berubah

    final int totalAvailable = FoodData.menu.where((item) => item.isAvailable).length;
    // .where() filter hanya yang isAvailable == true, lalu hitung .length-nya

    return Row(
      children: [
        _buildSummaryChip(
          icon: Icons.restaurant_menu,
          label: '$totalMenu Menu',
          // String interpolation: '$variabel' menyisipkan nilai variabel ke dalam String
          // '$totalMenu Menu' → '6 Menu'
        ),
        const SizedBox(width: 10),
        _buildSummaryChip(
          icon: Icons.check_circle_outline,
          label: '$totalAvailable Tersedia',
        ),
        const SizedBox(width: 10),
        _buildSummaryChip(
          icon: Icons.star_rounded,
          label: 'Top Picks',
          isPrimary: true,
          // isPrimary: chip ini akan ditampilkan berbeda (warna primer)
        ),
      ],
    );
  }

  Widget _buildSummaryChip({
    required IconData icon,
    required String label,
    bool isPrimary = false,
    // isPrimary dengan nilai default false — tidak perlu diisi saat memanggil
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.backgroundChip,
        // Ternary: jika isPrimary → warna oranye transparan, jika tidak → abu-abu
        borderRadius: BorderRadius.circular(20),
        border: isPrimary
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1)
            : null,
        // Border hanya ada jika isPrimary — null berarti tidak ada border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: isPrimary ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isPrimary ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final List<String> categories = FoodData.categories;
    // Ambil daftar kategori dari FoodData (sudah include 'Semua' di indeks 0)

    return SizedBox(
      height: 52,
      // SizedBox memberi batasan tinggi untuk ListView horizontal
      // Tanpa ini ListView horizontal akan error (unbounded height)

      child: ListView.builder(
        // ListView.builder: render item secara lazy — hanya yang terlihat di layar
        // Lebih efisien dari ListView biasa untuk list panjang
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
        scrollDirection: Axis.horizontal,
        // Axis.horizontal: ListView discroll ke samping
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final String category = categories[index];
          // Ambil satu kategori berdasarkan index
          final bool isSelected = category == _selectedCategory;
          // Cek apakah kategori ini yang sedang aktif

          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = category);
              // setState(): update _selectedCategory dan rebuild UI
              // Flutter akan memanggil build() lagi setelah setState
              // _filteredMenu getter akan terhitung ulang dengan kategori baru
            },
            child: AnimatedContainer(
              // AnimatedContainer: seperti Container tapi properti berubah dengan animasi
              duration: const Duration(milliseconds: 200),
              // Durasi transisi 200ms — cukup cepat, terasa responsif
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.backgroundCard,
                // Warna berubah tergantung apakah ini kategori yang dipilih
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primaryGlow,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
                // Shadow hanya muncul di chip yang dipilih
              ),
              child: Center(
                child: Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    // Bold jika dipilih, medium jika tidak
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    // Putih jika dipilih (di atas background oranye), abu jika tidak
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      // Tampilkan 4 shimmer placeholder saat loading
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 4,
      itemBuilder: (context, index) => const FoodCardShimmer(),
      // Setiap item adalah FoodCardShimmer yang identik — const karena tidak ada data
    );
  }

  Widget _buildFoodList() {
    if (_filteredMenu.isEmpty) {
      return _buildEmptyState();
      // Tampilkan empty state jika tidak ada makanan di kategori ini
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      // Padding vertikal 8px di atas dan bawah seluruh list
      itemCount: _filteredMenu.length,
      // Jumlah item bergantung pada hasil filter
      itemBuilder: (context, index) {
        return FoodCardWidget(item: _filteredMenu[index]);
        // Render satu FoodCardWidget untuk setiap item di filtered menu
        // itemBuilder dipanggil Flutter saat item akan masuk ke viewport
        // (lazy rendering — efisien untuk list panjang)
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_food, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            'Tidak ada menu di kategori ini',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}