import 'package:flutter/foundation.dart';

import 'character_item.dart';
import 'character_stat.dart';
import 'quiz_category.dart';
import 'storage_service.dart';

/// Mencatat performa jawaban per-aksara setiap kali pemain menjawab soal
/// kuis, lalu menyediakan daftar aksara yang paling sering salah agar
/// pemain bisa fokus mengulang materi yang lemah (lihat
/// [MistakeReviewScreen] dan badge di [CharacterListScreen]).
class MistakeService extends ChangeNotifier {
  MistakeService({StorageService? storageService})
      : _storage = storageService ?? StorageService();

  final StorageService _storage;

  final Map<QuizCategory, Map<String, CharacterStat>> _stats = {
    QuizCategory.hiragana: {},
    QuizCategory.katakana: {},
    QuizCategory.kanji: {},
  };

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> loadAll() async {
    for (final category in QuizCategory.values) {
      _stats[category] = await _storage.loadCategoryStats(category);
    }
    _isLoaded = true;
    notifyListeners();
  }

  /// Dipanggil setiap kali pemain menjawab satu soal di [QuizScreen].
  Future<void> recordAnswer({
    required QuizCategory category,
    required CharacterItem item,
    required bool wasCorrect,
  }) async {
    final categoryMap = _stats[category]!;
    final current = categoryMap[item.character] ?? CharacterStat.fromCharacterItem(item);
    categoryMap[item.character] = current.copyWithAnswer(wasCorrect: wasCorrect);
    await _storage.saveCategoryStats(category, categoryMap);
    notifyListeners();
  }

  CharacterStat? statFor(QuizCategory category, String character) {
    return _stats[category]?[character];
  }

  /// Daftar aksara dengan kesalahan terbanyak pada [category], diurutkan
  /// dari yang paling sering salah. Hanya menyertakan aksara yang pernah
  /// dijawab salah minimal sekali. [limit] membatasi jumlah hasil jika
  /// diisi (mis. untuk ringkasan di beranda).
  List<CharacterStat> mostMistaken(QuizCategory category, {int? limit}) {
    final values = (_stats[category]?.values ?? const Iterable<CharacterStat>.empty())
        .where((stat) => stat.wrongCount > 0)
        .toList()
      ..sort((a, b) {
        final byWrongCount = b.wrongCount.compareTo(a.wrongCount);
        if (byWrongCount != 0) return byWrongCount;
        return a.accuracy.compareTo(b.accuracy);
      });

    if (limit != null && values.length > limit) {
      return values.sublist(0, limit);
    }
    return values;
  }

  int totalMistakeCount(QuizCategory category) {
    final categoryMap = _stats[category];
    if (categoryMap == null) return 0;
    return categoryMap.values.fold<int>(0, (sum, stat) => sum + stat.wrongCount);
  }

  Future<void> resetAllStats() async {
    await _storage.clearStats();
    for (final category in QuizCategory.values) {
      _stats[category] = {};
    }
    notifyListeners();
  }
}