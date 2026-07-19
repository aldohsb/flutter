import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/color_mode.dart';
import '../services/storage_service.dart';

class ColorModeNotifier extends Notifier<SyllableColorMode> {
  final _storage = StorageService();

  @override
  SyllableColorMode build() {
    _load();
    return SyllableColorMode.multi;
  }

  Future<void> _load() async {
    state = await _storage.loadColorMode();
  }

  Future<void> toggle() async {
    state = state == SyllableColorMode.multi
        ? SyllableColorMode.single
        : SyllableColorMode.multi;
    await _storage.saveColorMode(state);
  }
}

final colorModeProvider =
    NotifierProvider<ColorModeNotifier, SyllableColorMode>(
  ColorModeNotifier.new,
);