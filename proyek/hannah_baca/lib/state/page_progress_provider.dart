import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

class PageProgressNotifier extends Notifier<Map<int, int>> {
  final _storage = StorageService();

  @override
  Map<int, int> build() {
    _load();
    return {};
  }

  Future<void> _load() async {
    state = await _storage.loadPageProgress();
  }

  int pageFor(int level) => state[level] ?? 0;

  Future<void> setPage(int level, int pageIndex) async {
    state = {...state, level: pageIndex};
    await _storage.savePageProgress(state);
  }

  Future<void> clearLevel(int level) async {
    final updated = {...state}..remove(level);
    state = updated;
    await _storage.savePageProgress(state);
  }
}

final pageProgressProvider =
    NotifierProvider<PageProgressNotifier, Map<int, int>>(
  PageProgressNotifier.new,
);