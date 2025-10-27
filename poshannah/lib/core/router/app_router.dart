import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      // Route lainnya akan ditambahkan di hari-hari berikutnya
    ],
  );
}