import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

class ProgressNotifier extends Notifier<Set<int>> {
  final _storage = StorageService();

  @override
  Set<int> build() {
    _load();
    return {};
  }

  Future<void> _load() async {
    state = await _storage.loadCompletedLevels();
  }

  Future<void> completeLevel(int level) async {
    state = {...state, level};
    await _storage.saveCompletedLevels(state);
  }
}

final progressProvider = NotifierProvider<ProgressNotifier, Set<int>>(
  ProgressNotifier.new,
);