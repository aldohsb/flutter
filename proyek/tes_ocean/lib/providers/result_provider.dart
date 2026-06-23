import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quiz_result.dart';
import '../services/result_repository.dart';

/// Menyediakan instance [ResultRepository] tunggal untuk seluruh aplikasi.
final resultRepositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});

/// Mengelola riwayat hasil tes untuk satu profil pengguna tertentu.
/// Menggunakan [FamilyNotifier] agar setiap [userId] memiliki state
/// riwayatnya sendiri-sendiri secara terisolasi.
class UserResultHistoryNotifier
    extends FamilyNotifier<List<QuizResult>, String> {
  @override
  List<QuizResult> build(String arg) {
    final repo = ref.watch(resultRepositoryProvider);
    return repo.getByUser(arg);
  }

  void refresh() {
    final repo = ref.read(resultRepositoryProvider);
    state = repo.getByUser(arg);
  }

  Future<void> deleteResult(String resultId) async {
    final repo = ref.read(resultRepositoryProvider);
    await repo.delete(resultId);
    refresh();
  }
}

final userResultHistoryProvider = NotifierProvider.family<
    UserResultHistoryNotifier, List<QuizResult>, String>(
  UserResultHistoryNotifier.new,
);
