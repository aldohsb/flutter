import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/color_mode.dart';

class StorageService {
  static const _completedKey = 'completed_levels';
  static const _pageProgressKey = 'page_progress';
  static const _colorModeKey = 'color_mode';

  Future<Set<int>> loadCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_completedKey) ?? [];
    return list.map(int.parse).toSet();
  }

  Future<void> saveCompletedLevels(Set<int> levels) async {
    final prefs = await SharedPreferences.getInstance();
    final list = levels.map((e) => e.toString()).toList();
    await prefs.setStringList(_completedKey, list);
  }

  // Format tiap entri: "level:pageIndex"
  Future<Map<int, int>> loadPageProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_pageProgressKey) ?? [];
    final map = <int, int>{};
    for (final entry in list) {
      final parts = entry.split(':');
      if (parts.length != 2) continue;
      map[int.parse(parts[0])] = int.parse(parts[1]);
    }
    return map;
  }

  Future<void> savePageProgress(Map<int, int> progress) async {
    final prefs = await SharedPreferences.getInstance();
    final list = progress.entries.map((e) => '${e.key}:${e.value}').toList();
    await prefs.setStringList(_pageProgressKey, list);
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
}