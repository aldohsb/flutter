import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad_pro/models/note_model.dart';
import 'package:notepad_pro/models/folder_model.dart';
import 'package:notepad_pro/models/tag_model.dart';
import 'package:notepad_pro/utils/constants.dart';

class HiveService {
  // Singleton pattern
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  // Boxes
  Box<NoteModel>? _notesBox;
  Box<FolderModel>? _foldersBox;
  Box<TagModel>? _tagsBox;

  // Getters
  Box<NoteModel> get notesBox => _notesBox!;
  Box<FolderModel> get foldersBox => _foldersBox!;
  Box<TagModel> get tagsBox => _tagsBox!;

  // Initialize Hive
  Future<void> init() async {
    // Initialize Hive Flutter
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FolderModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TagModelAdapter());
    }

    // Open boxes
    _notesBox = await Hive.openBox<NoteModel>(AppConstants.notesBox);
    _foldersBox = await Hive.openBox<FolderModel>(AppConstants.foldersBox);
    _tagsBox = await Hive.openBox<TagModel>(AppConstants.tagsBox);

    // Create default folder if not exists
    await _createDefaultFolder();
  }

  // Create default folder
  Future<void> _createDefaultFolder() async {
    if (_foldersBox!.isEmpty) {
      final defaultFolder = FolderModel.create(
        id: AppConstants.defaultFolderId,
        name: AppConstants.defaultFolderName,
      );
      await _foldersBox!.put(defaultFolder.id, defaultFolder);
    }
  }

  // CRUD Notes
  Future<void> addNote(NoteModel note) async {
    await _notesBox!.put(note.id, note);
    await _updateFolderCount(note.folderId);
  }

  Future<void> updateNote(NoteModel note) async {
    await _notesBox!.put(note.id, note);
  }

  Future<void> deleteNote(String noteId) async {
    final note = _notesBox!.get(noteId);
    if (note != null) {
      await _notesBox!.delete(noteId);
      await _updateFolderCount(note.folderId);
    }
  }

  NoteModel? getNote(String noteId) {
    return _notesBox!.get(noteId);
  }

  List<NoteModel> getAllNotes() {
    return _notesBox!.values.toList();
  }

  List<NoteModel> getNotesByFolder(String folderId) {
    return _notesBox!.values
        .where((note) => note.folderId == folderId)
        .toList();
  }

  List<NoteModel> searchNotes(String query) {
    final lowerQuery = query.toLowerCase();
    return _notesBox!.values.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
          note.content.toLowerCase().contains(lowerQuery) ||
          note.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  // CRUD Folders
  Future<void> addFolder(FolderModel folder) async {
    await _foldersBox!.put(folder.id, folder);
  }

  Future<void> updateFolder(FolderModel folder) async {
    await _foldersBox!.put(folder.id, folder);
  }

  Future<void> deleteFolder(String folderId) async {
    // Don't delete default folder
    if (folderId == AppConstants.defaultFolderId) return;
    
    // Move notes to default folder
    final notes = getNotesByFolder(folderId);
    for (var note in notes) {
      final updatedNote = note.copyWith(
        folderId: AppConstants.defaultFolderId,
      );
      await updateNote(updatedNote);
    }
    
    await _foldersBox!.delete(folderId);
    await _updateFolderCount(AppConstants.defaultFolderId);
  }

  FolderModel? getFolder(String folderId) {
    return _foldersBox!.get(folderId);
  }

  List<FolderModel> getAllFolders() {
    return _foldersBox!.values.toList();
  }

  // Update folder note count
  Future<void> _updateFolderCount(String folderId) async {
    final folder = _foldersBox!.get(folderId);
    if (folder != null) {
      final count = getNotesByFolder(folderId).length;
      final updatedFolder = folder.copyWith(noteCount: count);
      await _foldersBox!.put(folderId, updatedFolder);
    }
  }

  // CRUD Tags
  Future<void> addTag(TagModel tag) async {
    await _tagsBox!.put(tag.id, tag);
  }

  Future<void> updateTag(TagModel tag) async {
    await _tagsBox!.put(tag.id, tag);
  }

  Future<void> deleteTag(String tagId) async {
    await _tagsBox!.delete(tagId);
  }

  TagModel? getTag(String tagId) {
    return _tagsBox!.get(tagId);
  }

  List<TagModel> getAllTags() {
    return _tagsBox!.values.toList();
  }

  TagModel? getTagByName(String name) {
    return _tagsBox!.values.firstWhere(
      (tag) => tag.name.toLowerCase() == name.toLowerCase(),
      orElse: () => TagModel.create(id: '', name: ''),
    );
  }

  // Clear all data (untuk testing)
  Future<void> clearAll() async {
    await _notesBox!.clear();
    await _foldersBox!.clear();
    await _tagsBox!.clear();
    await _createDefaultFolder();
  }

  // Close boxes
  Future<void> close() async {
    await _notesBox?.close();
    await _foldersBox?.close();
    await _tagsBox?.close();
  }
}