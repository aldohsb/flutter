import '../models/word_model.dart';
import 'arabic_words_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  // Get all words
  List<WordModel> getAllWords() {
    return ArabicWordsData.getAllWords();
  }

  // Get words by level number
  List<WordModel> getWordsForLevel(int levelNumber) {
    return ArabicWordsData.getRandomWordsForLevel(levelNumber, 10);
  }

  // Get words by rank range
  List<WordModel> getWordsByRankRange(int startRank, int endRank) {
    return ArabicWordsData.getWordsByRankRange(startRank, endRank);
  }

  // Get all completed words up to current level
  List<WordModel> getCompletedWords(int currentLevel) {
    final allWords = getAllWords();
    return allWords.where((word) => word.rank < (100 + (currentLevel ~/ 20) * 100)).toList();
  }

  // Search words
  List<WordModel> searchWords(String query) {
    final allWords = getAllWords();
    final lowerQuery = query.toLowerCase();
    
    return allWords.where((word) {
      return word.arabic.contains(query) ||
          word.transliteration.toLowerCase().contains(lowerQuery) ||
          word.indonesian.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}