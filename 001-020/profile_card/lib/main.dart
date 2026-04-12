import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart';
import 'screens/profile_screen.dart';

void main() {
  // Inisialisasi binding Flutter sebelum akses platform (SystemChrome)
  // Wajib ada jika ada kode platform sebelum runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Kunci orientasi layar ke portrait saja
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Atur tampilan status bar: transparan, ikon putih (cocok untuk bg gelap)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark, // aktifkan tema gelap
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        // Jadikan Poppins font default seluruh app
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const ProfileScreen(),
    );
  }
}