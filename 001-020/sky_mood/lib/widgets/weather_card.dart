// ============================================================================
// FILE: lib/widgets/weather_card.dart
// FUNGSI: Widget kartu cuaca dengan desain Claymorphism dan animasi
// ============================================================================
// KONSEP: StatefulWidget + AnimationController + Tween untuk animasi smooth
// ============================================================================

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

// ============================================================================
// WEATHER CARD WIDGET
// ============================================================================
// Widget ini adalah kartu utama yang menampilkan informasi cuaca.
// Menggunakan StatefulWidget karena perlu mengatur animasi dengan AnimationController

class WeatherCard extends StatefulWidget {
  // Property - data cuaca yang akan ditampilkan
  final WeatherModel weather;

  // Constructor
  const WeatherCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

// ============================================================================
// STATE CLASS - Menyimpan state dan logika widget
// ============================================================================
// TickerStateMixin memungkinkan AnimationController bekerja dengan proper timing

class _WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  // =========================================================================
  // ANIMATION CONTROLLER - Mengatur timing animasi
  // =========================================================================
  // AnimationController adalah "maestro" yang mengontrol durasi dan timing
  late AnimationController _animationController;

  // =========================================================================
  // ANIMATION - Tween untuk interpolasi nilai
  // =========================================================================
  // Tween adalah "resep" yang menentukan perubahan dari nilai awal ke akhir
  // Di sini kita buat animasi untuk scale (ukuran), opacity, dan offset

  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  // =========================================================================
  // LIFECYCLE HOOK: initState()
  // =========================================================================
  // Dipanggil sekali saat widget pertama kali dibuat
  // Tempat yang tepat untuk inisialisasi controller

  @override
  void initState() {
    super.initState();

    // =====================================================================
    // SETUP ANIMATION CONTROLLER
    // =====================================================================
    _animationController = AnimationController(
      // Durasi animasi dalam milliseconds
      duration: Duration(
        milliseconds: AppAnimations.animationDuration,
      ),
      // vsync: this - SingleTickerProviderStateMixin yang "in sync" dengan vsync
      // Ini memastikan animasi berjalan smooth sesuai refresh rate device
      vsync: this,
    );

    // =====================================================================
    // SETUP TWEEN ANIMATIONS
    // =====================================================================

    // Scale animation - membuat kartu "pop in" dengan grow effect
    _scaleAnimation = Tween<double>(
      begin: 0.8,   // Mulai dari 80% ukuran normal (kecil)
      end: 1.0,     // Berakhir di 100% ukuran normal (full)
    ).animate(
      // Curve.elasticOut membuat animasi terasa "bouncy" dan natural
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,  // Kurva elastis untuk bounce effect
      ),
    );

    // Opacity animation - fade in dari transparan ke opaque
    _opacityAnimation = Tween<double>(
      begin: 0.0,   // Mulai transparan
      end: 1.0,     // Berakhir fully opaque
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,  // Fade in smooth
      ),
    );

    // Offset animation - kartu masuk dari bawah ke atas
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),   // Mulai 30% ke bawah
      end: Offset.zero,         // Berakhir di posisi normal
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,  // Ease out smooth
      ),
    );

    // =====================================================================
    // MULAI ANIMASI
    // =====================================================================
    // forward() membuat animasi berjalan dari begin ke end
    _animationController.forward();
  }

  // =========================================================================
  // LIFECYCLE HOOK: dispose()
  // =========================================================================
  // Dipanggil saat widget dihapus dari widget tree
  // Tempat yang tepat untuk membersihkan resource (cleanup)

  @override
  void dispose() {
    // Harus dispose AnimationController untuk mencegah memory leak
    _animationController.dispose();
    super.dispose();
  }

  // =========================================================================
  // BUILD METHOD - Menggambar UI
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        // AnimatedBuilder adalah widget yang rebuild setiap frame animasi berubah
        // animation: apa yang di-listen (observer)
        animation: _animationController,

        // builder: function yang dipanggil setiap frame untuk rebuild
        builder: (context, child) {
          return Transform.scale(
            // Scale animation value (0.8 - 1.0)
            scale: _scaleAnimation.value,

            child: Opacity(
              // Opacity animation value (0.0 - 1.0)
              opacity: _opacityAnimation.value,

              child: SlideTransition(
                // Slide animation - pergeseran dari bawah ke atas
                position: _offsetAnimation,

                child: _buildWeatherCard(),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================================
  // HELPER METHOD: _buildWeatherCard()
  // =========================================================================
  // Fungsi ini membangun UI kartu cuaca dengan claymorphism design

  Widget _buildWeatherCard() {
    return Container(
      // Dimensi kartu - dikurangi untuk fit
      width: 260,
      height: 320,

      // Dekorasi container
      decoration: BoxDecoration(
        // Warna latar belakang - biru muda
        color: AppColors.primaryLight,

        // Border radius membulat - karakteristik claymorphism
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),

        // Shadow lembut - efek 3D claymorphism
        boxShadow: AppShadows.softShadowMedium(),
      ),

      // Padding dalam untuk content
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMedium),

        child: Column(
          // Distribusi children secara vertical
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            // ===============================================================
            // TOP SECTION - Header dengan lokasi
            // ===============================================================
            _buildTopSection(),

            // ===============================================================
            // MIDDLE SECTION - Emoji dan suhu besar
            // ===============================================================
            _buildMiddleSection(),

            // ===============================================================
            // BOTTOM SECTION - Detail cuaca (humidity, wind speed)
            // ===============================================================
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER: TOP SECTION - Lokasi dan kondisi
  // =========================================================================

  Widget _buildTopSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Lokasi
        Text(
          widget.weather.location,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 2),

        // Kondisi cuaca dalam bahasa Indonesia
        Text(
          widget.weather.getConditionLabel(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
              ),
        ),
      ],
    );
  }

  // =========================================================================
  // HELPER: MIDDLE SECTION - Emoji dan suhu
  // =========================================================================

  Widget _buildMiddleSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Emoji cuaca yang besar (dikurangi dari 80 ke 64)
        Text(
          widget.weather.getEmoji(),
          style: TextStyle(
            fontSize: 64,
          ),
        ),

        SizedBox(height: AppSizes.paddingSmall),

        // Suhu dalam angka besar dan jelas
        Text(
          '${widget.weather.temperature}°C',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
        ),

        SizedBox(height: 2),

        // Deskripsi cuaca
        Text(
          widget.weather.description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
              ),
        ),
      ],
    );
  }

  // =========================================================================
  // HELPER: BOTTOM SECTION - Detail informasi
  // =========================================================================

  Widget _buildBottomSection() {
    return Container(
      // Background untuk section info detail
      decoration: BoxDecoration(
        // Warna background - putih dengan opacity
        color: AppColors.highlight.withOpacity(0.4),

        // Border radius
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),

        // Inner shadow untuk efek inset
        boxShadow: AppShadows.innerShadow(),
      ),

      // Padding dalam - reduced untuk fit
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall,
        vertical: AppSizes.paddingSmall,
      ),

      // Row untuk dua info side by side
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          // ===============================================================
          // Humidity Info
          // ===============================================================
          Expanded(
            child: _buildDetailInfo(
              label: 'Kelembaban',
              value: '${widget.weather.humidity}%',
              icon: '💧',
            ),
          ),

          // Divider vertical - lebih kecil
          Container(
            width: 1,
            height: 35,
            color: AppColors.textGray.withOpacity(0.3),
          ),

          // ===============================================================
          // Wind Speed Info
          // ===============================================================
          Expanded(
            child: _buildDetailInfo(
              label: 'Angin',
              value: '${widget.weather.windSpeed} km/h',
              icon: '💨',
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // HELPER: Detail Info Item
  // =========================================================================

  Widget _buildDetailInfo({
    required String label,
    required String value,
    required String icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon emoji
        Text(
          icon,
          style: TextStyle(fontSize: 18),
        ),

        SizedBox(height: 2),

        // Label (keterangan) - dengan maxLines agar tidak overflow
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 2),

        // Value (angka) - dengan maxLines
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}