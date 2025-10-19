// ============================================================================
// FILE: lib/screens/home_screen.dart
// FUNGSI: Layar utama aplikasi dengan Stack, Positioned, dan animasi partikel
// ============================================================================
// KONSEP: Stack + Positioned + CustomPaint untuk layout kompleks dengan animasi
// ============================================================================

import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';
import '../widgets/particle_painter.dart';
import '../models/weather_model.dart';
import '../utils/constants.dart';

// ============================================================================
// HOME SCREEN WIDGET
// ============================================================================
// Ini adalah halaman utama aplikasi yang menampilkan:
// 1. Background dengan animasi partikel (CustomPaint)
// 2. Kartu cuaca di tengah (WeatherCard)
// 3. Header dengan informasi

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ============================================================================
// STATE CLASS - Mengelola logika HomeScreen
// ============================================================================

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // =========================================================================
  // PROPERTIES - Variabel yang menyimpan state
  // =========================================================================

  // Data cuaca yang ditampilkan
  late WeatherModel _currentWeather;

  // List untuk menyimpan semua partikel
  late List<Particle> _particles;

  // Animation Controller untuk animasi partikel
  late AnimationController _particleAnimationController;

  // =========================================================================
  // LIFECYCLE HOOK: initState()
  // =========================================================================
  // Dipanggil sekali saat widget pertama dibuat

  @override
  void initState() {
    super.initState();

    // =====================================================================
    // INISIALISASI DATA CUACA
    // =====================================================================
    // Untuk demo, kita gunakan cuaca cerah (sunny)
    _currentWeather = WeatherModel.sunny();

    // =====================================================================
    // SETUP PARTICLE ANIMATION CONTROLLER
    // =====================================================================
    // Controller ini mengatur timing untuk animasi partikel
    _particleAnimationController = AnimationController(
      // Durasi animasi partikel
      duration: Duration(
        milliseconds: AppAnimations.particleAnimationDuration,
      ),
      // vsync untuk smooth animation
      vsync: this,
    );

    // =====================================================================
    // SETUP PARTIKEL
    // =====================================================================
    // Kita perlu tahu ukuran screen untuk create partikel
    // Gunakan WidgetsBinding untuk akses info setelah build pertama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Sekarang kita bisa akses ukuran screen melalui MediaQuery
      final screenSize = MediaQuery.of(context).size;

      // Buat partikel sebanyak yang ditentukan di constants
      _particles = List.generate(
        ParticleSettings.particleCount,
        (index) => Particle(
          maxWidth: screenSize.width,
          maxHeight: screenSize.height,
        ),
      );

      // Mulai animasi partikel
      _particleAnimationController.repeat();
    });
  }

  // =========================================================================
  // LIFECYCLE HOOK: dispose()
  // =========================================================================

  @override
  void dispose() {
    // Hapus controller saat widget dihapus
    _particleAnimationController.dispose();
    super.dispose();
  }

  // =========================================================================
  // BUILD METHOD - Menggambar UI
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold adalah basic layout structure di Flutter
      // Menyediakan app bar, body, floating button, dll

      // Background warna dari theme
      backgroundColor: AppColors.bgLight,

      // App Bar (header atas)
      appBar: AppBar(
        // Judul app
        title: Text(
          '🌤️ SkyMood',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // Centered title
        centerTitle: true,
      ),

      // Body - konten utama
      body: _buildBody(),
    );
  }

  // =========================================================================
  // HELPER METHOD: _buildBody()
  // =========================================================================
  // Method ini membangun body yang kompleks dengan Stack dan Positioned

  Widget _buildBody() {
    return Stack(
      // =====================================================================
      // STACK CONCEPT
      // =====================================================================
      // Stack memungkinkan widget bertumpuk satu di atas yang lain
      // Seperti tumpukan kertas di atas meja.
      // Widget yang didefinisikan terakhir akan di atas yang pertama.
      // =====================================================================

      children: [
        // =====================================================================
        // LAYER 1 (PALING BAWAH): BACKGROUND CUSTOM PAINT
        // =====================================================================
        // AnimatedBuilder listening ke animation untuk continuous repaint
        AnimatedBuilder(
          // Animation controller yang di-listen
          animation: _particleAnimationController,

          // Builder dipanggil setiap frame animasi berubah
          builder: (context, child) {
            return CustomPaint(
              // ============================================================
              // CUSTOM PAINT
              // ============================================================
              // painter: Custom painter class yang akan menggambar
              // Ini adalah class ParticlePainter yang kita buat sebelumnya
              painter: ParticlePainter(
                // Pass particles ke painter
                particles: _particles,
                // Pass animation value (0.0 - 1.0)
                // Ini membuat painter tahu kapan harus update
                animationValue: _particleAnimationController.value,
              ),

              // Ukuran canvas untuk custom paint
              // Mengisi seluruh layar dengan MediaQuery
              size: Size.infinite,
            );
          },
        ),

        // =====================================================================
        // LAYER 2 (TENGAH): KONTEN UTAMA
        // =====================================================================
        // Center widget untuk menempatkan content di tengah
        Center(
          child: _buildMainContent(),
        ),

        // =====================================================================
        // LAYER 3 (ATAS): BUTTON UNTUK GANTI CUACA
        // =====================================================================
        // Positioned digunakan untuk menempatkan widget di posisi absolut
        // inside Stack

        Positioned(
          // Jarak dari bawah
          bottom: AppSizes.paddingXLarge,
          // Center secara horizontal
          left: 0,
          right: 0,

          child: Center(
            child: _buildWeatherToggleButtons(),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // HELPER: Main Content
  // =========================================================================

  Widget _buildMainContent() {
    return SingleChildScrollView(
      // Scroll jika content terlalu besar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: AppSizes.paddingMedium),

          // Heading deskripsi
          Text(
            'Cuaca Hari Ini',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          SizedBox(height: AppSizes.paddingLarge),

          // Weather Card dengan animasi
          WeatherCard(weather: _currentWeather),

          SizedBox(height: AppSizes.paddingLarge),
        ],
      ),
    );
  }

  // =========================================================================
  // HELPER: Weather Toggle Buttons
  // =========================================================================
  // Tombol untuk mengubah cuaca (untuk testing)

  Widget _buildWeatherToggleButtons() {
    return SingleChildScrollView(
      // Horizontal scroll untuk menghindari overflow
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
        child: Row(
          // Maintenunakan spacing antar tombol
          mainAxisSize: MainAxisSize.min,
          children: [
            // ============================================================
            // Button Sunny
            // ============================================================
            _buildWeatherButton(
              label: '☀️ Cerah',
              onPressed: () {
                setState(() {
                  _currentWeather = WeatherModel.sunny();
                });
              },
              isActive: _currentWeather.condition == 'sunny',
            ),

            SizedBox(width: AppSizes.paddingSmall),

            // ============================================================
            // Button Cloudy
            // ============================================================
            _buildWeatherButton(
              label: '☁️ Berawan',
              onPressed: () {
                setState(() {
                  _currentWeather = WeatherModel.cloudy();
                });
              },
              isActive: _currentWeather.condition == 'cloudy',
            ),

            SizedBox(width: AppSizes.paddingSmall),

            // ============================================================
            // Button Rainy
            // ============================================================
            _buildWeatherButton(
              label: '🌧️ Hujan',
              onPressed: () {
                setState(() {
                  _currentWeather = WeatherModel.rainy();
                });
              },
              isActive: _currentWeather.condition == 'rainy',
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER: Single Weather Button
  // =========================================================================

  Widget _buildWeatherButton({
    required String label,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return ElevatedButton(
      // Callback saat tombol ditekan
      onPressed: onPressed,

      // Styling tombol
      style: ElevatedButton.styleFrom(
        // Warna background
        backgroundColor: isActive
            ? AppColors.sunny  // Kuning jika aktif
            : AppColors.primaryLight,  // Biru jika tidak aktif

        // Warna teks
        foregroundColor: isActive
            ? AppColors.textDark
            : AppColors.textGray,

        // Padding dalam tombol
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),

        // Border radius membulat
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),

        // Elevation (shadow) untuk button
        elevation: isActive ? 8 : 4,
      ),

      // Text label tombol
      child: Text(label),
    );
  }
}