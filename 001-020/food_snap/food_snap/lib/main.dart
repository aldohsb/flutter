import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart';
import 'screens/food_gallery_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Wajib ada sebelum runApp() jika ada kode platform (SystemChrome)

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Kunci orientasi portrait — layout card horizontal kurang cocok di landscape

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // Brightness.dark = ikon status bar berwarna gelap (hitam)
      // Cocok untuk app dengan background TERANG (kebalikan dari Hari 2 & 3)
      statusBarBrightness: Brightness.light,
      // Untuk iOS: Brightness.light = background status bar terang → ikon gelap
    ),
  );

  runApp(const FoodSnapApp());
}

class FoodSnapApp extends StatelessWidget {
  const FoodSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodSnap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          // Brightness.light = tema TERANG — berbeda dari Hari 2 & 3 yang gelap
          // FoodSnap sengaja dibuat light theme agar foto makanan terlihat segar
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
        // ThemeData.light() — base light theme, bukan dark
      ),
      home: const FoodGalleryScreen(),
    );
  }
}