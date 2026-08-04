import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Mengatur preferensi tampilan, termasuk visibilitas section di home screen.
class SettingsProvider extends ChangeNotifier {
  static const String _boxName = 'settings';
  static const String _keyPrefix = 'section_visible_';

  late Box _box;
  bool _isLoaded = false;

  /// Urutan & label section yang bisa disembunyikan/dimunculkan di home.
  static const Map<String, String> sectionLabels = {
    'weight': 'Berat Badan',
    'earning': 'Earning',
    'calorie': 'Kalori',
    'expense': 'Pengeluaran',
    'habits': 'Habits Hari Ini',
  };

  final Map<String, bool> _visibility = {
    'weight': true,
    'earning': true,
    'calorie': true,
    'expense': true,
    'habits': true,
  };

  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    for (final key in _visibility.keys) {
      final stored = _box.get('$_keyPrefix$key');
      if (stored is bool) {
        _visibility[key] = stored;
      }
    }
    _isLoaded = true;
    notifyListeners();
  }

  bool isVisible(String section) => _visibility[section] ?? true;

  Future<void> setVisible(String section, bool value) async {
    if (_visibility[section] == value) return;
    _visibility[section] = value;
    await _box.put('$_keyPrefix$section', value);
    notifyListeners();
  }

  Future<void> toggleVisible(String section) =>
      setVisible(section, !isVisible(section));
}