import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Tunggu UserProvider selesai init, lalu tunggu minimal 2 detik splash
    await Future.wait([
      Future<void>.delayed(const Duration(milliseconds: 2200)),
      _waitForProvider(),
    ]);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Future<void> _waitForProvider() async {
    final userProvider = context.read<UserProvider>();
    while (userProvider.isLoading) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon / Logo
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 28),

              Text(
                'Tes Love Language',
                style: AppTextStyles.display.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 300.ms)
                  .slideY(begin: 0.2, end: 0, duration: 500.ms, delay: 300.ms),

              const SizedBox(height: 10),

              Text(
                'Temukan cara kamu dicintai',
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 500.ms),

              const SizedBox(height: 56),

              // Loading indicator
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary.withAlpha(180),
                ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}