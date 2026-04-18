import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart';
import 'screens/shell_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Wajib sebelum runApp jika ada kode platform sebelumnya

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      // light = ikon putih — cocok untuk app dark theme
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.navBackground,
      // systemNavigationBarColor: warna navigation bar sistem di Android (tombol back, home)
      // Disesuaikan dengan warna NavigationBar app agar menyatu
      systemNavigationBarIconBrightness: Brightness.light,
      // Ikon navigation bar sistem berwarna putih
    ),
  );

  runApp(const AppShell());
}

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppShell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        navigationBarTheme: NavigationBarThemeData(
          // Kustomisasi tema NavigationBar bawaan Material 3
          // Meskipun kita pakai CustomNavBar, setting ini mencegah override warna tak terduga
          backgroundColor: AppColors.navBackground,
          indicatorColor: AppColors.primary.withValues(alpha: 0.2),
          // indicatorColor: warna pill indicator di belakang ikon aktif
        ),
        snackBarTheme: const SnackBarThemeData(
          // Tema global untuk semua SnackBar di app
          contentTextStyle: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      home: const ShellScreen(),
    );
  }
}