import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/color_mode.dart';

class StorageService {
  static const _completedKey = 'completed_levels';
  static const _pageProgressKey = 'page_progress';
  static const _colorModeKey = 'color_mode';
  static const _fontScaleKey = 'font_scale';
  static const _hijaiyahCompletedKey = 'hijaiyah_completed_levels';
  static const _hijaiyahPageProgressKey = 'hijaiyah_page_progress';

  Future<Set<int>> loadCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_completedKey) ?? [];
    return list.map(int.parse).toSet();
  }

  Future<void> saveCompletedLevels(Set<int> levels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _completedKey,
      levels.map((e) => e.toString()).toList(),
    );
  }

  Future<Map<int, int>> loadPageProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_pageProgressKey) ?? [];
    return _decodeProgress(list);
  }

  Future<void> savePageProgress(Map<int, int> progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_pageProgressKey, _encodeProgress(progress));
  }

  Future<SyllableColorMode> loadColorMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_colorModeKey);
    return value == 'single' ? SyllableColorMode.single : SyllableColorMode.multi;
  }

  Future<void> saveColorMode(SyllableColorMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _colorModeKey,
      mode == SyllableColorMode.single ? 'single' : 'multi',
    );
  }

  Future<double> loadFontScale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_fontScaleKey) ?? 1.0;
  }

  Future<void> saveFontScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontScaleKey, scale);
  }

  Future<Set<int>> loadHijaiyahCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_hijaiyahCompletedKey) ?? [];
    return list.map(int.parse).toSet();
  }

  Future<void> saveHijaiyahCompletedLevels(Set<int> levels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _hijaiyahCompletedKey,
      levels.map((e) => e.toString()).toList(),
    );
  }

  Future<Map<int, int>> loadHijaiyahPageProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_hijaiyahPageProgressKey) ?? [];
    return _decodeProgress(list);
  }

  Future<void> saveHijaiyahPageProgress(Map<int, int> progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _hijaiyahPageProgressKey,
      _encodeProgress(progress),
    );
  }

  Map<int, int> _decodeProgress(List<String> list) {
    final map = <int, int>{};
    for (final entry in list) {
      final parts = entry.split(':');
      if (parts.length != 2) continue;
      map[int.parse(parts[0])] = int.parse(parts[1]);
    }
    return map;
  }

  List<String> _encodeProgress(Map<int, int> progress) {
    return progress.entries.map((e) => '${e.key}:${e.value}').toList();
  }
}