import 'package:flutter/material.dart';
import 'package:notepad_pro/models/note_model.dart';
import 'package:notepad_pro/services/hive_service.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final Uuid _uuid = const Uuid();

  List<NoteModel> _notes = [];
  String _searchQuery = '';
  String? _selectedFolderId;
  bool _showFavoritesOnly = false;

  // Getters
  List<NoteModel> get notes {
    List<NoteModel> filteredNotes = _notes;

    // Filter by folder
    if (_selectedFolderId != null) {
      filteredNotes = filteredNotes
          .where((note) => note.folderId == _selectedFolderId)
          .toList();
    }

    // Filter by favorites
    if (_showFavoritesOnly) {
      filteredNotes = filteredNotes.where((note) => note.isFavorite).toList();
    }

    // Filter by search
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filteredNotes = filteredNotes.where((note) {
        return note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query) ||
            note.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    // Sort by updated date (newest first)
    filteredNotes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return filteredNotes;
  }

  String get searchQuery => _searchQuery;
  String? get selectedFolderId => _selectedFolderId;
  bool get showFavoritesOnly => _showFavoritesOnly;

  // Load all notes
  Future<void> loadNotes() async {
    _notes = _hiveService.getAllNotes();
    notifyListeners();
  }

  // Create note
  Future<NoteModel> createNote({
    required String title,
    required String folderId,
    String content = '',
  }) async {
    final note = NoteModel.create(
      id: _uuid.v4(),
      title: title,
      folderId: folderId,
      content: content,
    );

    await _hiveService.addNote(note);
    await loadNotes();
    return note;
  }

  // Update note
  Future<void> updateNote(NoteModel note) async {
    await _hiveService.updateNote(note);
    await loadNotes();
  }

  // Delete note
  Future<void> deleteNote(String noteId) async {
    await _hiveService.deleteNote(noteId);
    await loadNotes();
  }

  // Toggle favorite
  Future<void> toggleFavorite(String noteId) async {
    final note = _hiveService.getNote(noteId);
    if (note != null) {
      final updatedNote = note.copyWith(
        isFavorite: !note.isFavorite,
      );
      await updateNote(updatedNote);
    }
  }

  // Add tag to note
  Future<void> addTagToNote(String noteId, String tagName) async {
    final note = _hiveService.getNote(noteId);
    if (note != null && !note.tags.contains(tagName)) {
      final updatedTags = [...note.tags, tagName];
      final updatedNote = note.copyWith(tags: updatedTags);
      await updateNote(updatedNote);
    }
  }

  // Remove tag from note
  Future<void> removeTagFromNote(String noteId, String tagName) async {
    final note = _hiveService.getNote(noteId);
    if (note != null) {
      final updatedTags = note.tags.where((tag) => tag != tagName).toList();
      final updatedNote = note.copyWith(tags: updatedTags);
      await updateNote(updatedNote);
    }
  }

  // Search
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Folder filter
  void setSelectedFolder(String? folderId) {
    _selectedFolderId = folderId;
    notifyListeners();
  }

  // Favorites filter
  void toggleFavoritesFilter() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }

  // Get notes by tag
  List<NoteModel> getNotesByTag(String tagName) {
    return _notes.where((note) => note.tags.contains(tagName)).toList();
  }

  // Get note count by folder
  int getNoteCountByFolder(String folderId) {
    return _notes.where((note) => note.folderId == folderId).length;
  }

  // Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _selectedFolderId = null;
    _showFavoritesOnly = false;
    notifyListeners();
  }
}