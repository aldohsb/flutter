import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'screens/profile/profile_selection_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();
  await initializeDateFormatting('id_ID');

  runApp(const ProviderScope(child: TesOceanApp()));
}

/// Root widget aplikasi Tes OCEAN.
class TesOceanApp extends StatelessWidget {
  const TesOceanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tes OCEAN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ProfileSelectionScreen(),
    );
  }
}
