import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/level_select/level_select_screen.dart';
import '../features/reading_drill/reading_drill_screen.dart';
import '../features/results/level_result_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/levels',
        builder: (context, state) => const LevelSelectScreen(),
      ),
      GoRoute(
        path: '/drill/:level',
        builder: (context, state) {
          final level = int.parse(state.pathParameters['level']!);
          return ReadingDrillScreen(level: level);
        },
      ),
      GoRoute(
        path: '/result/:level',
        builder: (context, state) {
          final level = int.parse(state.pathParameters['level']!);
          return LevelResultScreen(level: level);
        },
      ),
    ],
  );
}