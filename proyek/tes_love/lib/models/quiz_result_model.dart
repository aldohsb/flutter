import 'dart:convert';

/// 5 kategori Love Language
enum LoveLanguage {
  wordsOfAffirmation,
  qualityTime,
  receivingGifts,
  actsOfService,
  physicalTouch,
}

extension LoveLanguageExt on LoveLanguage {
  String get label {
    switch (this) {
      case LoveLanguage.wordsOfAffirmation:
        return 'Kata-kata Afirmasi';
      case LoveLanguage.qualityTime:
        return 'Waktu Berkualitas';
      case LoveLanguage.receivingGifts:
        return 'Hadiah';
      case LoveLanguage.actsOfService:
        return 'Tindakan Pelayanan';
      case LoveLanguage.physicalTouch:
        return 'Sentuhan Fisik';
    }
  }

  String get shortLabel {
    switch (this) {
      case LoveLanguage.wordsOfAffirmation:
        return 'Afirmasi';
      case LoveLanguage.qualityTime:
        return 'Waktu';
      case LoveLanguage.receivingGifts:
        return 'Hadiah';
      case LoveLanguage.actsOfService:
        return 'Pelayanan';
      case LoveLanguage.physicalTouch:
        return 'Sentuhan';
    }
  }

  String get emoji {
    switch (this) {
      case LoveLanguage.wordsOfAffirmation:
        return '💬';
      case LoveLanguage.qualityTime:
        return '⏳';
      case LoveLanguage.receivingGifts:
        return '🎁';
      case LoveLanguage.actsOfService:
        return '🤝';
      case LoveLanguage.physicalTouch:
        return '🫂';
    }
  }

  String get key => name;
}

class QuizResultModel {
  final String id;
  final String userId;
  final DateTime takenAt;
  // Skor per love language (0–12 tiap kategori, 6 soal × 2 poin maks, dst.)
  final Map<LoveLanguage, int> scores;

  const QuizResultModel({
    required this.id,
    required this.userId,
    required this.takenAt,
    required this.scores,
  });

  /// Love language dengan skor tertinggi
  LoveLanguage get primaryLanguage {
    return scores.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  /// Ranking dari tertinggi ke terendah
  List<MapEntry<LoveLanguage, int>> get ranking {
    final entries = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  /// Total skor (harusnya selalu 30 — satu poin tiap jawaban)
  int get totalScore => scores.values.fold(0, (sum, s) => sum + s);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'takenAt': takenAt.toIso8601String(),
      'scores': scores.map((k, v) => MapEntry(k.key, v)),
    };
  }

  factory QuizResultModel.fromMap(Map<String, dynamic> map) {
    final rawScores = map['scores'] as Map<String, dynamic>;
    final scores = <LoveLanguage, int>{};
    for (final entry in rawScores.entries) {
      final ll = LoveLanguage.values.firstWhere((e) => e.key == entry.key);
      scores[ll] = entry.value as int;
    }
    return QuizResultModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      takenAt: DateTime.parse(map['takenAt'] as String),
      scores: scores,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory QuizResultModel.fromJson(String source) =>
      QuizResultModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}