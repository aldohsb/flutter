import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

class HijaiyahProgressNotifier extends Notifier<Set<int>> {
  final _storage = StorageService();

  @override
  Set<int> build() {
    _load();
    return {};
  }

  Future<void> _load() async {
    state = await _storage.loadHijaiyahCompletedLevels();
  }

  Future<void> completeLevel(int level) async {
    state = {...state, level};
    await _storage.saveHijaiyahCompletedLevels(state);
  }
}

final hijaiyahProgressProvider =
    NotifierProvider<HijaiyahProgressNotifier, Set<int>>(
  HijaiyahProgressNotifier.new,
);