// File: lib/widgets/quote_card.dart
// Penjelasan: Widget untuk menampilkan satu quote card dengan ink bleed effect
// Widget ini akan di-reuse berkali-kali di ListView

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quote_model.dart';
import '../utils/theme_utils.dart';
import 'ink_bleed_painter.dart';

/// Widget QuoteCard menampilkan satu quote dalam format kartu
/// StatelessWidget berarti widget tidak punya state yang berubah
class QuoteCard extends StatelessWidget {
  /// Quote object yang akan ditampilkan
  final Quote quote;

  /// Constructor dengan required parameter quote
  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    // === MAIN CARD CONTAINER ===
    // Stack digunakan untuk menumpuk widget (background, content, dsb)
    return Stack(
      children: [
        // === BACKGROUND LAYER: INK BLEED EFFECT ===
        // CustomPaint menggunakan CustomPainter untuk menggambar custom graphics
        Positioned.fill(
          // Positioned.fill membuat child mengisi seluruh parent area
          child: CustomPaint(
            // Gunakan InkBleedPainter untuk menggambar efek tinta
            painter: InkBleedPainter(),
            // child: Container() tidak perlu, cukup painter
          ),
        ),

        // === MIDDLE LAYER: CARD CONTENT CONTAINER ===
        Container(
          // Margin di sekitar kartu
          margin: const EdgeInsets.all(AppTheme.spacingMedium),
          // Padding di dalam kartu
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          // Decoration untuk styling container
          decoration: BoxDecoration(
            // Background color
            color: AppTheme.backgroundColor,
            // Border dengan warna subtle
            border: Border.all(
              color: AppTheme.dividerColor.withOpacity(0.4),
              width: 1.0,
            ),
            // Border radius untuk sudut yang rounded
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            // Shadow untuk efek "floating"
            boxShadow: const [AppTheme.cardShadow],
          ),
          // === CHILD: CONTENT INSIDE CARD ===
          child: Column(
            // MainAxisAlignment mengatur alignment vertikal
            mainAxisAlignment: MainAxisAlignment.start,
            // CrossAxisAlignment mengatur alignment horizontal
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === QUOTE TEXT ===
              // Text utama (isi kutipan)
              Text(
                // Gunakan quote.text dari model
                quote.text,
                // Style text dari theme
                style: GoogleFonts.notoSerif(
                  fontSize: AppTheme.fontSizeBody,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textPrimary,
                  height: 1.8, // Line height untuk readability yang lebih baik
                  fontStyle: FontStyle.italic, // Italic untuk efek kutipan
                ),
                // IMPORTANT: Handling text overflow dengan ellipsis
                // Jika text terlalu panjang dan tidak muat, akan ditampilkan "..."
                overflow: TextOverflow.ellipsis,
                // maxLines membatasi jumlah baris maksimal
                // null berarti unlimited, tapi dengan ellipsis bisa auto-wrap
                maxLines: 5,
              ),

              // Spacing vertikal antara quote text dan author
              const SizedBox(height: AppTheme.spacingLarge),

              // === DIVIDER HORIZONTAL ===
              // Garis pemisah antara quote dan author info
              Container(
                width: 30.0, // Lebar garis (tidak full width, untuk minimalism)
                height: 1.0,
                color: AppTheme.accentColor.withOpacity(0.4),
              ),

              // Spacing setelah divider
              const SizedBox(height: AppTheme.spacingMedium),

              // === AUTHOR INFO ROW ===
              Row(
                // MainAxisAlignment untuk spacing horizontal
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // CrossAxisAlignment untuk alignment vertical
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bagian kiri: Author name
                  Expanded(
                    // Expanded agar bisa flexible width
                    child: Column(
                      // Align ke kiri
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label "by" (optional, bisa dihapus)
                        Text(
                          'by',
                          style: GoogleFonts.roboto(
                            fontSize: AppTheme.fontSizeCaption,
                            color: AppTheme.textSecondary.withOpacity(0.6),
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.0,
                          ),
                        ),
                        // Nama author
                        // HANDLING OVERFLOW: Gunakan ellipsis jika author name panjang
                        Text(
                          quote.author,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                          // overflow: TextOverflow.ellipsis untuk handle nama panjang
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1, // Author name hanya 1 baris
                        ),
                      ],
                    ),
                  ),

                  // Spacing horizontal antara author dan category
                  const SizedBox(width: AppTheme.spacingMedium),

                  // Bagian kanan: Category badge
                  // Container untuk membuat badge/tag untuk kategori
                  Container(
                    // Padding dalam badge
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    // Decoration untuk styling badge
                    decoration: BoxDecoration(
                      // Background color badge (subtle)
                      color: AppTheme.accentColor.withOpacity(0.08),
                      // Border untuk outline badge
                      border: Border.all(
                        color: AppTheme.accentColor.withOpacity(0.3),
                        width: 0.8,
                      ),
                      // Border radius untuk badge
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                    ),
                    // Text kategori
                    child: Text(
                      // Gunakan quote.category dari model
                      quote.category,
                      // Style text kecil untuk kategori
                      style: GoogleFonts.roboto(
                        fontSize: AppTheme.fontSizeCaption - 1, // Lebih kecil dari caption
                        fontWeight: FontWeight.w500,
                        color: AppTheme.accentColor.withOpacity(0.7),
                        letterSpacing: 0.3,
                      ),
                      // HANDLING OVERFLOW: ellipsis untuk kategori panjang
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}