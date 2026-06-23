import 'package:hive_flutter/hive_flutter.dart';

import '../models/quiz_result.dart';
import '../models/user_profile.dart';
import '../utils/app_constants.dart';

/// Bertanggung jawab menginisialisasi Hive beserta seluruh box yang
/// dibutuhkan aplikasi. Dipanggil sekali di `main()` sebelum `runApp`.
class StorageService {
  StorageService._();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(QuizResultAdapter());
    }

    await Hive.openBox<UserProfile>(AppConstants.userProfileBox);
    await Hive.openBox<QuizResult>(AppConstants.quizResultBox);
    await Hive.openBox(AppConstants.settingsBox);

    _initialized = true;
  }
}
