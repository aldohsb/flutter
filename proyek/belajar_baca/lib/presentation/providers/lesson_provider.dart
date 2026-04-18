import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/lesson_chapter.dart';
import '../../data/repositories/lesson_repository.dart';

class LessonProvider extends ChangeNotifier {
  final LessonRepository _repo = LessonRepository.instance;

  int _currentChapterIndex = 0;
  int _currentCardIndex = 0;
  final Map<int, int> _chapterProgress = {}; // chapterIndex -> last card index

  int get currentChapterIndex => _currentChapterIndex;
  int get currentCardIndex => _currentCardIndex;

  List<LessonChapter> get chapters => _repo.chapters;

  LessonChapter get currentChapter =>
      _repo.getChapter(_currentChapterIndex);

  int getChapterProgress(int chapterIndex) =>
      _chapterProgress[chapterIndex] ?? 0;

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _repo.chapters.length; i++) {
      _chapterProgress[i] = prefs.getInt('progress_$i') ?? 0;
    }
    notifyListeners();
  }

  void openChapter(int chapterIndex) {
    _currentChapterIndex = chapterIndex;
    _currentCardIndex = _chapterProgress[chapterIndex] ?? 0;
    notifyListeners();
  }

  void nextCard() {
    if (_currentCardIndex < currentChapter.totalCards - 1) {
      _currentCardIndex++;
      _saveProgress();
      notifyListeners();
    }
  }

  void previousCard() {
    if (_currentCardIndex > 0) {
      _currentCardIndex--;
      notifyListeners();
    }
  }

  void goToCard(int index) {
    if (index >= 0 && index < currentChapter.totalCards) {
      _currentCardIndex = index;
      notifyListeners();
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = _chapterProgress[_currentChapterIndex] ?? 0;
    if (_currentCardIndex > saved) {
      _chapterProgress[_currentChapterIndex] = _currentCardIndex;
      await prefs.setInt('progress_$_currentChapterIndex', _currentCardIndex);
    }
  }
}
