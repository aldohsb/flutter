/// Merepresentasikan satu unit aksara Jepang (Hiragana/Katakana/Kanji)
/// beserta padanan bacaan latin (romaji) yang digunakan dalam kuis.
///
/// Urutan item di dalam setiap data source (lihat folder `data/`) sengaja
/// disusun dari yang paling mudah ke yang paling sulit, karena urutan ini
/// dipakai oleh [QuizGeneratorService] untuk menentukan pool soal per level.
class CharacterItem {
  final String character;
  final String romaji;

  const CharacterItem({
    required this.character,
    required this.romaji,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterItem &&
          runtimeType == other.runtimeType &&
          character == other.character &&
          romaji == other.romaji;

  @override
  int get hashCode => character.hashCode ^ romaji.hashCode;

  @override
  String toString() => 'CharacterItem($character -> $romaji)';
}
