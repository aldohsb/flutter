import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'progress_service.dart';
import 'mistake_service.dart';
import 'home_screen.dart';

/// Widget akar aplikasi Usama Quiz. Menyediakan [ProgressService] dan
/// [MistakeService] ke seluruh widget tree lewat [MultiProvider], dan
/// mengatur tema global (Zen Garden Sage).
class UsamaQuizApp extends StatelessWidget {
  const UsamaQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProgressService>(create: (_) => ProgressService()..loadAll()),
        ChangeNotifierProvider<MistakeService>(create: (_) => MistakeService()..loadAll()),
      ],
      child: MaterialApp(
        title: 'Usama Quiz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}