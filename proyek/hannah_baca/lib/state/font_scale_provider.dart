import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';

class FontScaleNotifier extends Notifier<double> {
  final _storage = StorageService();

  @override
  double build() {
    _load();
    return 1.0;
  }

  Future<void> _load() async {
    state = await _storage.loadFontScale();
  }

  Future<void> increase() async {
    state = (state + 0.1).clamp(0.6, 2.0);
    await _storage.saveFontScale(state);
  }

  Future<void> decrease() async {
    state = (state - 0.1).clamp(0.6, 2.0);
    await _storage.saveFontScale(state);
  }
}

final fontScaleProvider = NotifierProvider<FontScaleNotifier, double>(
  FontScaleNotifier.new,
);