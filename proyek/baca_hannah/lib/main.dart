// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local_storage.dart';
import 'data/repositories/chapter_repository.dart';
import 'data/repositories/progress_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Paksa orientasi portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar transparan
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Init local storage
  await LocalStorage.init();

  runApp(const BacaHannahApp());
}

class BacaHannahApp extends StatelessWidget {
  const BacaHannahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChapterRepository>(
          create: (_) => const ChapterRepository(),
        ),
        Provider<ProgressRepository>(
          create: (_) => const ProgressRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Baca Hannah',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}