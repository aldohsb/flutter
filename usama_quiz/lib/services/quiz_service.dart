import 'dart:math';
import '../models/models.dart';
import '../data/quiz_data.dart';
import '../constants/app_constants.dart';

class QuizService {
  final Random _random = Random();

  // Generate questions untuk level tertentu
  List<Question> generateQuestionsForLevel(int level) {
    final aksaraData = JapaneseAksaraData();
    final questions = <Question>[];
    
    String categoryType = _getLevelCategory(level);
    List<String> aksaraList = _getAksaraListForLevel(level, categoryType);
    
    for (int i = 0; i < AppConstants.questionsPerLevel; i++) {
      final type = _random.nextBool() ? 'romaji_to_aksara' : 'aksara_to_romaji';
      final aksara = aksaraList[_random.nextInt(aksaraList.length)];
      
      Question question;
      
      if (type == 'romaji_to_aksara') {
        question = _generateRomajiToAksaraQuestion(
          id: level * 1000 + i,
          level: level,
          aksara: aksara,
          categoryType: categoryType,
          aksaraList: aksaraList,
        );
      } else {
        question = _generateAksaraToRomajiQuestion(
          id: level * 1000 + i,
          level: level,
          aksara: aksara,
          categoryType: categoryType,
          aksaraList: aksaraList,
        );
      }
      
      questions.add(question);
    }
    
    return questions;
  }

  // Determine category based on level
  String _getLevelCategory(int level) {
    if (level >= AppConstants.hiraganaStart && level <= AppConstants.hiraganaEnd) {
      return 'hiragana';
    } else if (level >= AppConstants.katakanaStart && level <= AppConstants.katakanaEnd) {
      return 'katakana';
    } else {
      return 'kanji';
    }
  }

  // Get aksara list untuk level
  List<String> _getAksaraListForLevel(int level, String categoryType) {
    if (categoryType == 'hiragana') {
      return JapaneseAksaraData.getHiraganaForLevel(level);
    } else if (categoryType == 'katakana') {
      final levelForKatakana = level - 40;
      return JapaneseAksaraData.getKatakanaForLevel(level);
    } else {
      // Kanji - mix dari JLPT N5
      return JapaneseAksaraData.kanjiJLPTN5.keys.toList();
    }
  }

  // Generate Romaji → Aksara question
  Question _generateRomajiToAksaraQuestion({
    required int id,
    required int level,
    required String aksara,
    required String categoryType,
    required List<String> aksaraList,
  }) {
    final Map<String, String> mapping = categoryType == 'hiragana'
        ? JapaneseAksaraData.hiraganaMap
        : categoryType == 'katakana'
            ? JapaneseAksaraData.katakanaMap
            : JapaneseAksaraData.kanjiJLPTN5;

    final romaji = mapping[aksara] ?? 'unknown';
    
    // Generate wrong options
    final wrongOptions = <String>[];
    final availableAksara = List<String>.from(aksaraList);
    availableAksara.remove(aksara);
    
    while (wrongOptions.length < 3 && availableAksara.isNotEmpty) {
      final wrong = availableAksara.removeAt(_random.nextInt(availableAksara.length));
      if (wrong != aksara) {
        wrongOptions.add(wrong);
      }
    }

    var options = [aksara, ...wrongOptions];
    options.shuffle(_random);

    return Question(
      id: id,
      level: level,
      type: 'romaji_to_aksara',
      question: 'Pilih aksara untuk: $romaji',
      options: options,
      correctAnswer: aksara,
      explanation: '$romaji = $aksara',
      categoryType: categoryType,
    );
  }

  // Generate Aksara → Romaji question
  Question _generateAksaraToRomajiQuestion({
    required int id,
    required int level,
    required String aksara,
    required String categoryType,
    required List<String> aksaraList,
  }) {
    final Map<String, String> mapping = categoryType == 'hiragana'
        ? JapaneseAksaraData.hiraganaMap
        : categoryType == 'katakana'
            ? JapaneseAksaraData.katakanaMap
            : JapaneseAksaraData.kanjiJLPTN5;

    final romaji = mapping[aksara] ?? 'unknown';
    
    // Generate wrong options (romaji)
    final wrongRomaji = <String>[];
    final availableAksara = List<String>.from(aksaraList);
    availableAksara.remove(aksara);
    
    while (wrongRomaji.length < 3 && availableAksara.isNotEmpty) {
      final wrong = availableAksara.removeAt(_random.nextInt(availableAksara.length));
      final wrongRom = mapping[wrong] ?? 'unknown';
      if (wrongRom != romaji && !wrongRomaji.contains(wrongRom)) {
        wrongRomaji.add(wrongRom);
      }
    }

    var options = [romaji, ...wrongRomaji];
    options.shuffle(_random);

    return Question(
      id: id,
      level: level,
      type: 'aksara_to_romaji',
      question: 'Pilih romaji untuk: $aksara',
      options: options,
      correctAnswer: romaji,
      explanation: '$aksara = $romaji',
      categoryType: categoryType,
    );
  }

  // Validate answer
  bool validateAnswer(String selectedAnswer, String correctAnswer) {
    return selectedAnswer.toLowerCase() == correctAnswer.toLowerCase();
  }

  // Calculate stars
  int calculateStars(int correctCount) {
    if (correctCount >= AppConstants.starsThreshold3) return 3;
    if (correctCount >= AppConstants.starsThreshold2) return 2;
    if (correctCount >= AppConstants.starsThreshold1) return 1;
    return 0;
  }

  // Check if passed
  bool checkIfPassed(int correctCount) {
    return correctCount >= AppConstants.minCorrectToPass;
  }
}