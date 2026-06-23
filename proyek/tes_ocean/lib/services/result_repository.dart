import 'package:hive/hive.dart';

import '../models/quiz_result.dart';
import '../utils/app_constants.dart';

/// Lapisan akses data untuk entitas [QuizResult].
class ResultRepository {
  Box<QuizResult> get _box => Hive.box<QuizResult>(
        AppConstants.quizResultBox,
      );

  /// Mengembalikan seluruh riwayat hasil tes milik [userId], diurutkan dari
  /// yang paling baru ke yang paling lama.
  List<QuizResult> getByUser(String userId) {
    final results = _box.values.where((r) => r.userId == userId).toList();
    results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  QuizResult? getLatestByUser(String userId) {
    final results = getByUser(userId);
    return results.isEmpty ? null : results.first;
  }

  Future<void> add(QuizResult result) async {
    await _box.put(result.id, result);
  }

  Future<void> deleteAllForUser(String userId) async {
    final keysToDelete = _box.values
        .where((r) => r.userId == userId)
        .map((r) => r.id)
        .toList();
    await _box.deleteAll(keysToDelete);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }
}
