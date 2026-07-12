import 'dart:math';

import 'character_item.dart';
import 'hiragana_data.dart';
import 'katakana_data.dart';
import 'kanji_data.dart';
import 'quiz_category.dart';
import 'quiz_question.dart';

/// Otak dari sistem kuis: mengubah data mentah aksara ([kHiraganaData],
/// [kKatakanaData], [kKanjiData]) menjadi 10 soal pilihan ganda untuk
/// level tertentu, dengan tingkat kesulitan yang naik secara gradual.
///
/// Strategi kesulitan gradual:
/// 1. Setiap kategori punya "pool" karakter yang sudah diurutkan dari yang
///    termudah ke tersulit (lihat komentar di masing-masing file data).
/// 2. Semakin tinggi level, semakin banyak karakter dari pool yang
///    "diperkenalkan" dan bisa muncul di soal (lihat [_introducedCount]).
/// 3. Karakter yang baru saja diperkenalkan pada level tersebut diberi
///    bobot lebih besar sebagai target soal (pengulangan terarah/spaced
///    repetition sederhana), tanpa melupakan karakter lama sepenuhnya.
/// 4. Arah soal (aksara->latin atau latin->aksara) diacak per soal.
/// 5. Pengecoh (distractor) diprioritaskan dari karakter yang "berdekatan"
///    posisinya di pool agar terasa mirip & lebih menantang.
class QuizGeneratorService {
  QuizGeneratorService({Random? random}) : _random = random ?? Random();

  final Random _random;

  List<CharacterItem> _fullPoolFor(QuizCategory category) {
    switch (category) {
      case QuizCategory.hiragana:
        return kHiraganaData;
      case QuizCategory.katakana:
        return kKatakanaData;
      case QuizCategory.kanji:
        return kKanjiData;
    }
  }

  int _introducedCount(int level, int total) {
    const minItems = 4;
    final clampedLevel = level.clamp(1, kLevelsPerCategory);
    final ratio = clampedLevel / kLevelsPerCategory;
    final count = (minItems + (total - minItems) * ratio).round();
    return count.clamp(minItems, total);
  }

  /// Menghasilkan 10 soal pilihan ganda untuk [category] pada [level]
  /// (1-50). Setiap panggilan menghasilkan urutan & pilihan yang berbeda
  /// karena diacak ulang, sehingga level bisa diulang tanpa terasa monoton.
  List<QuizQuestion> generateLevel(QuizCategory category, int level) {
    final fullPool = _fullPoolFor(category);
    final total = fullPool.length;

    final introduced = _introducedCount(level, total);
    final previouslyIntroduced =
        level <= 1 ? 0 : _introducedCount(level - 1, total).clamp(0, introduced);

    final currentPool = fullPool.sublist(0, introduced);
    final newlyIntroduced = level <= 1
        ? currentPool
        : fullPool.sublist(previouslyIntroduced, introduced);

    final weightedTargets = <CharacterItem>[
      ...currentPool,
      ...newlyIntroduced,
      ...newlyIntroduced,
    ];

    final questions = <QuizQuestion>[];
    for (var i = 0; i < kQuestionsPerLevel; i++) {
      final target = weightedTargets[_random.nextInt(weightedTargets.length)];
      final direction = _random.nextBool()
          ? QuestionDirection.scriptToRomaji
          : QuestionDirection.romajiToScript;

      final options = _buildOptions(currentPool, target, direction);
      final correctAnswer = direction == QuestionDirection.scriptToRomaji
          ? target.romaji
          : target.character;
      final promptText = direction == QuestionDirection.scriptToRomaji
          ? target.character
          : target.romaji;

      questions.add(
        QuizQuestion(
          promptText: promptText,
          direction: direction,
          options: options,
          correctAnswer: correctAnswer,
        ),
      );
    }

    return questions;
  }

  List<String> _buildOptions(
    List<CharacterItem> currentPool,
    CharacterItem target,
    QuestionDirection direction,
  ) {
    final distractors = _pickDistractors(currentPool, target, 3);
    final usedValues = <String>{};
    final options = <String>[];

    String valueOf(CharacterItem item) => direction == QuestionDirection.scriptToRomaji
        ? item.romaji
        : item.character;

    void tryAdd(CharacterItem item) {
      final value = valueOf(item);
      if (usedValues.add(value)) {
        options.add(value);
      }
    }

    tryAdd(target);
    for (final d in distractors) {
      tryAdd(d);
    }

    // Jaring pengaman: jika terjadi tabrakan nilai (mis. dua kanji berbeda
    // dengan bacaan latin yang sama) sehingga opsi < 4, tarik pengganti
    // acak dari pool utama sampai genap 4 opsi unik.
    var guard = 0;
    while (options.length < 4 && guard < 100 && currentPool.length > options.length) {
      final candidate = currentPool[_random.nextInt(currentPool.length)];
      if (candidate.character != target.character && candidate.romaji != target.romaji) {
        tryAdd(candidate);
      }
      guard++;
    }

    options.shuffle(_random);
    return options;
  }

  List<CharacterItem> _pickDistractors(
    List<CharacterItem> pool,
    CharacterItem target,
    int count,
  ) {
    final candidates = pool
        .where((item) => item.character != target.character && item.romaji != target.romaji)
        .toList();

    if (candidates.isEmpty) return const [];

    final targetIndex = pool.indexOf(target);
    candidates.sort((a, b) {
      final distanceA = (pool.indexOf(a) - targetIndex).abs();
      final distanceB = (pool.indexOf(b) - targetIndex).abs();
      return distanceA.compareTo(distanceB);
    });

    final closeRangeSize = (candidates.length * 0.6).ceil().clamp(count, candidates.length);
    final closeRange = candidates.sublist(0, closeRangeSize)..shuffle(_random);

    final selected = <CharacterItem>[];
    for (final item in closeRange) {
      if (selected.length >= count) break;
      selected.add(item);
    }
    if (selected.length < count) {
      for (final item in candidates) {
        if (selected.length >= count) break;
        if (!selected.contains(item)) selected.add(item);
      }
    }
    return selected;
  }
}
