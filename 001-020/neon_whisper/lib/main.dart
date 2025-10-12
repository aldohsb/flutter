import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import semua module yang sudah kita buat
import 'constants/app_strings.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'widgets/gradient_background.dart';
import 'widgets/neon_text.dart';

/// Entry point aplikasi Flutter
/// 
/// main() adalah function pertama yang dijalankan.
/// async karena kita akan melakukan setup asynchronous
void main() async {
  // Memastikan Flutter binding sudah diinisialisasi
  // Wajib dipanggil sebelum menggunakan native plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (opsional)
  // Mengunci orientasi ke portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style untuk status bar dan navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar (bar di atas) menggunakan warna dark
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      
      // Navigation bar (bar di bawah) menggunakan warna dark
      systemNavigationBarColor: AppColors.backgroundDeep,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Menjalankan aplikasi dengan widget root MyApp
  runApp(const MyApp());
}

/// Root widget aplikasi
/// 
/// StatelessWidget karena konfigurasi app tidak berubah
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget root untuk Material Design app
    return MaterialApp(
      // title: judul aplikasi (muncul di task switcher)
      title: 'NeonWhisper',
      
      // debugShowCheckedModeBanner: false untuk hide debug banner
      debugShowCheckedModeBanner: false,
      
      // theme: konfigurasi tema aplikasi
      theme: ThemeData(
        // brightness: Brightness.dark untuk dark theme
        brightness: Brightness.dark,
        
        // primaryColor: warna utama aplikasi
        primaryColor: AppColors.neonPurple,
        
        // scaffoldBackgroundColor: warna background default scaffold
        scaffoldBackgroundColor: AppColors.backgroundDark,
        
        // fontFamily: font default (bisa diganti dengan custom font)
        fontFamily: 'Sans Serif',
        
        // useMaterial3: menggunakan Material Design 3
        useMaterial3: true,
      ),
      
      // home: widget yang akan ditampilkan pertama kali
      home: const HomePage(),
    );
  }
}

/// HomePage: halaman utama aplikasi
/// 
/// StatelessWidget karena UI statis (tidak ada interaksi yang mengubah state)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman Material Design
    // Menyediakan app bar, body, floating action button, dll
    return Scaffold(
      // body: konten utama halaman
      body: GradientBackground(
        // Center: menempatkan child di tengah parent
        child: Center(
          // SingleChildScrollView: membuat konten scrollable
          // Berguna jika konten melebihi tinggi layar
          child: SingleChildScrollView(
            // padding: jarak dari edge layar
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,  // Padding kiri-kanan
              vertical: 48.0,    // Padding atas-bawah
            ),
            
            // Column: menyusun children secara vertikal
            child: Column(
              // mainAxisAlignment: alignment vertikal
              // MainAxisAlignment.center: children di tengah vertikal
              mainAxisAlignment: MainAxisAlignment.center,
              
              // crossAxisAlignment: alignment horizontal
              // CrossAxisAlignment.center: children di tengah horizontal
              crossAxisAlignment: CrossAxisAlignment.center,
              
              // children: array of widgets yang disusun vertikal
              children: [
                // === SECTION 1: Main Greeting ===
                
                // PulsingNeonText untuk efek berkedip subtle
                PulsingNeonText(
                  text: AppStrings.mainGreeting,
                  style: AppTextStyles.neonHeading,
                ),
                
                // SizedBox: widget untuk spacing
                // Membuat jarak vertikal 16 pixels
                const SizedBox(height: 16),
                
                // === SECTION 2: Subtitle dengan Gradient ===
                
                GradientNeonText(
                  text: AppStrings.subGreeting,
                  gradient: AppColors.neonTextGradient,
                  style: AppTextStyles.neonSubheading,
                ),
                
                const SizedBox(height: 48),
                
                // === SECTION 3: Welcome Message dalam NeonBox ===
                
                NeonBox(
                  // padding: jarak dalam box
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 24.0,
                  ),
                  
                  // borderRadius: membuat sudut rounded
                  borderRadius: 16.0,
                  
                  child: Column(
                    children: [
                      // Icon dengan glow effect
                      Icon(
                        Icons.celebration,
                        size: 48,
                        color: AppColors.neonPink,
                        shadows: [
                          Shadow(
                            color: AppColors.neonPink.withOpacity(0.8),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Welcome message text
                      NeonText(
                        text: AppStrings.welcomeMessage,
                        style: AppTextStyles.neonBody,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // === SECTION 4: Additional Info ===
                
                // Divider dengan glow effect
                Container(
                  height: 2,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: AppColors.neonTextGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonPurple.withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Info text
                NeonText(
                  text: 'Swipe to explore',
                  style: AppTextStyles.neonBody.copyWith(
                    fontSize: 14,
                    letterSpacing: 2.0,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Animated icon
                const PulsingIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget untuk icon yang berkedip (pulsing effect)
/// 
/// StatefulWidget karena memiliki animasi
class PulsingIcon extends StatefulWidget {
  const PulsingIcon({super.key});

  @override
  State<PulsingIcon> createState() => _PulsingIconState();
}

/// State untuk PulsingIcon dengan animation
class _PulsingIconState extends State<PulsingIcon>
    with SingleTickerProviderStateMixin {
  /// Animation controller
  late AnimationController _controller;
  
  /// Animation untuk scale
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Setup scale animation dari 0.8 ke 1.2
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Jalankan animasi berulang
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          // scale: besaran scale dari animation
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 32,
        color: AppColors.neonCyan,
        shadows: [
          Shadow(
            color: AppColors.neonCyan.withOpacity(0.8),
            blurRadius: 20,
          ),
        ],
      ),
    );
  }
}