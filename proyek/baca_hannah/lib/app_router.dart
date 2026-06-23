// lib/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/repositories/chapter_repository.dart';
import 'features/home/screens/home_screen.dart';
import 'features/reading/screens/reading_screen.dart';
import 'features/progress/screens/progress_screen.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String reading = '/reading/:chapterId';
  static const String progress = '/progress';

  static String readingPath(int chapterId) => '/reading/$chapterId';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/reading/:chapterId',
        builder: (context, state) {
          final chapterIdStr = state.pathParameters['chapterId'] ?? '1';
          final chapterId = int.tryParse(chapterIdStr) ?? 1;
          const repo = ChapterRepository();
          final chapter = repo.getChapterById(chapterId);
          if (chapter == null) {
            return const HomeScreen();
          }
          final startPage =
              (state.extra as Map<String, dynamic>?)?['startPage'] as int? ?? 0;
          return ReadingScreen(chapter: chapter, startPageIndex: startPage);
        },
      ),
      GoRoute(
        path: progress,
        builder: (context, state) => const ProgressScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Halaman tidak ditemukan: ${state.error}'),
      ),
    ),
  );
}