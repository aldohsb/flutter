import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_scroll_behavior.dart';
import 'routing/app_router.dart';

class HannahBacaApp extends StatelessWidget {
  const HannahBacaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hannah Baca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      scrollBehavior: AppScrollBehavior(),
      routerConfig: AppRouter.router,
    );
  }
}