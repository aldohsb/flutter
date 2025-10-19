class WordModel {
  final int id;
  final String arabic;
  final String transliteration;
  final String indonesian;
  final int rank; // Ranking popularitas (100-2100)

  WordModel({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.indonesian,
    required this.rank,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic': arabic,
      'transliteration': transliteration,
      'indonesian': indonesian,
      'rank': rank,
    };
  }

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'] as int,
      arabic: json['arabic'] as String,
      transliteration: json['transliteration'] as String,
      indonesian: json['indonesian'] as String,
      rank: json['rank'] as int,
    );
  }
}