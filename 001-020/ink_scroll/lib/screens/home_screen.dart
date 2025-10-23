// File: lib/screens/home_screen.dart
// Penjelasan: Layar utama aplikasi yang menampilkan feed quotes
// Menggunakan ListView.separated dan CustomScrollView untuk layout yang fleksibel

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quote_model.dart';
import '../utils/theme_utils.dart';
import '../utils/quote_data.dart';
import '../widgets/quote_card.dart';

/// Screen HomeScreen adalah layar utama aplikasi
/// StatefulWidget digunakan karena kita mungkin ingin state yang berubah (filtering, dsb)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State untuk HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  // === STATE VARIABLES ===
  /// List untuk menyimpan quotes yang ditampilkan
  late List<Quote> displayedQuotes;

  /// Kategori yang dipilih untuk filter (null = tampilkan semua)
  String? selectedCategory;

  @override
  void initState() {
    // initState dipanggil sekali saat widget pertama kali dibuat
    super.initState();
    
    // Initialize quotes dengan dummy data
    displayedQuotes = QuoteData.getDummyQuotes();
  }

  /// Method untuk filter quotes berdasarkan kategori
  void _filterByCategory(String? category) {
    // setState diperlukan untuk merepaint/rebuild UI saat state berubah
    setState(() {
      // Update selected category
      selectedCategory = category;
      
      // Update displayed quotes
      if (category == null) {
        // Jika kategori null, tampilkan semua quotes
        displayedQuotes = QuoteData.getDummyQuotes();
      } else {
        // Jika ada kategori, filter quotes berdasarkan kategori
        displayedQuotes = QuoteData.getQuotesByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold adalah basic layout structure untuk app dengan AppBar, body, dsb
      backgroundColor: AppTheme.backgroundColor,

      // === APP BAR ===
      appBar: AppBar(
        title: Text(
          'InkScroll',
          style: GoogleFonts.playfairDisplay(
            fontSize: AppTheme.fontSizeHeading,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        // Elevation 0 untuk flat design (tidak ada shadow)
        elevation: 0,
        // Background color dari AppBar
        backgroundColor: AppTheme.backgroundColor,
      ),

      // === BODY: MAIN CONTENT ===
      body: Column(
        children: [
          // === CATEGORY FILTER CHIPS ===
          // Horizontal scroll untuk kategori
          SizedBox(
            // Tinggi area chips
            height: 50.0,
            child: ListView(
              // Scroll horizontal
              scrollDirection: Axis.horizontal,
              // Padding untuk spacing dari tepi
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              children: [
                // === "ALL" CHIP ===
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    // Label untuk chip "All"
                    label: const Text('All'),
                    // Background color berdasarkan apakah dipilih
                    backgroundColor: selectedCategory == null
                        ? AppTheme.accentColor.withOpacity(0.2)
                        : AppTheme.backgroundColor,
                    // Label style
                    labelStyle: GoogleFonts.roboto(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: selectedCategory == null
                          ? AppTheme.accentColor
                          : AppTheme.textSecondary,
                    ),
                    // Border
                    side: BorderSide(
                      color: selectedCategory == null
                          ? AppTheme.accentColor.withOpacity(0.5)
                          : AppTheme.dividerColor,
                      width: 1.0,
                    ),
                    // On tap handler
                    onSelected: (bool selected) {
                      if (selected) {
                        _filterByCategory(null); // Filter dengan category null = all
                      }
                    },
                  ),
                ),

                // === DYNAMIC CATEGORY CHIPS ===
                // Build chips untuk setiap kategori yang ada
                ...QuoteData.getCategories().map((category) {
                  // isSelected untuk check apakah kategori ini dipilih
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(category),
                      backgroundColor: isSelected
                          ? AppTheme.accentColor.withOpacity(0.2)
                          : AppTheme.backgroundColor,
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? AppTheme.accentColor
                            : AppTheme.textSecondary,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.accentColor.withOpacity(0.5)
                            : AppTheme.dividerColor,
                        width: 1.0,
                      ),
                      onSelected: (bool selected) {
                        if (selected) {
                          _filterByCategory(category);
                        }
                      },
                    ),
                  );
                }), // Konversi map iterator ke list
              ],
            ),
          ),

          // Spacing
          const SizedBox(height: AppTheme.spacingMedium),

          // === MAIN QUOTE LIST ===
          // Expanded untuk mengisi sisa space yang tersedia
          Expanded(
            child: _buildQuotesList(),
          ),
        ],
      ),
    );
  }

  /// Method untuk build quotes list dengan ListView.separated
  /// Terpisah agar code lebih rapi dan mudah dipahami
  Widget _buildQuotesList() {
    // Jika tidak ada quotes, tampilkan pesan kosong
    if (displayedQuotes.isEmpty) {
      return Center(
        child: Text(
          'No quotes found',
          style: GoogleFonts.playfairDisplay(
            fontSize: AppTheme.fontSizeBody,
            color: AppTheme.textSecondary,
          ),
        ),
      );
    }

    // === CUSTOM SCROLL VIEW ===
    // CustomScrollView memungkinkan kita menggabungkan beberapa "sliver"
    // Sliver adalah bagian yang bisa di-scroll secara coordinated
    return CustomScrollView(
      // List of slivers
      slivers: [
        // === SLIVER LIST ===
        // SliverList adalah version dari ListView yang bisa digunakan di CustomScrollView
        SliverList(
          // delegate untuk build children dalam SliverList
          // SliverChildListDelegate membangun list dari children yang sudah ada
          delegate: SliverChildBuilderDelegate(
            // Builder function untuk setiap item di list
            // Ini lebih efisien daripada SliverChildListDelegate untuk list besar
            (BuildContext context, int index) {
              // Dapatkan quote pada index ini
              final quote = displayedQuotes[index];

              // Return QuoteCard widget
              return QuoteCard(quote: quote);
            },
            // childCount untuk total item di list
            childCount: displayedQuotes.length,
          ),
        ),

        // === BOTTOM SPACING SLIVER ===
        // SliverToBoxAdapter untuk convert regular widget menjadi Sliver
        const SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.spacingLarge),
        ),
      ],
    );

    // ===== ALTERNATIF: MENGGUNAKAN ListView.separated =====
    // Komentar di bawah menunjukkan cara menggunakan ListView.separated
    // (tidak digunakan karena kita sudah pakai CustomScrollView)
    
    /*
    return ListView.separated(
      // itemCount untuk total items
      itemCount: displayedQuotes.length,

      // itemBuilder untuk build setiap item di list
      itemBuilder: (BuildContext context, int index) {
        final quote = displayedQuotes[index];
        return QuoteCard(quote: quote);
      },

      // PENTING: separatorBuilder untuk build divider antar items
      // Ini adalah keunikan ListView.separated dibanding ListView
      // Ini dipanggil untuk setiap "gap" antara items
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },

      // padding untuk spacing di sekitar list
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
    );
    */
  }
}