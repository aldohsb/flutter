import 'package:flutter/material.dart';
import 'package:notepad_pro/models/folder_model.dart';
import 'package:notepad_pro/services/hive_service.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:uuid/uuid.dart';

class FolderProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final Uuid _uuid = const Uuid();

  List<FolderModel> _folders = [];

  // Getters
  List<FolderModel> get folders => _folders;

  FolderModel? get defaultFolder {
    return _folders.firstWhere(
      (folder) => folder.id == AppConstants.defaultFolderId,
      orElse: () => FolderModel.create(
        id: AppConstants.defaultFolderId,
        name: AppConstants.defaultFolderName,
      ),
    );
  }

  // Load all folders
  Future<void> loadFolders() async {
    _folders = _hiveService.getAllFolders();
    
    // Sort: default folder first, then alphabetically
    _folders.sort((a, b) {
      if (a.id == AppConstants.defaultFolderId) return -1;
      if (b.id == AppConstants.defaultFolderId) return 1;
      return a.name.compareTo(b.name);
    });
    
    notifyListeners();
  }

  // Create folder
  Future<FolderModel> createFolder({
    required String name,
    String? icon,
    Color? color,
  }) async {
    final folder = FolderModel.create(
      id: _uuid.v4(),
      name: name,
      icon: icon,
      color: color,
    );

    await _hiveService.addFolder(folder);
    await loadFolders();
    return folder;
  }

  // Update folder
  Future<void> updateFolder(FolderModel folder) async {
    await _hiveService.updateFolder(folder);
    await loadFolders();
  }

  // Delete folder
  Future<void> deleteFolder(String folderId) async {
    // Prevent deleting default folder
    if (folderId == AppConstants.defaultFolderId) {
      throw Exception('Cannot delete default folder');
    }

    await _hiveService.deleteFolder(folderId);
    await loadFolders();
  }

  // Rename folder
  Future<void> renameFolder(String folderId, String newName) async {
    final folder = _hiveService.getFolder(folderId);
    if (folder != null) {
      final updatedFolder = folder.copyWith(name: newName);
      await updateFolder(updatedFolder);
    }
  }

  // Change folder color
  Future<void> changeFolderColor(String folderId, Color color) async {
    final folder = _hiveService.getFolder(folderId);
    if (folder != null) {
      final updatedFolder = folder.copyWith(color: color);
      await updateFolder(updatedFolder);
    }
  }

  // Change folder icon
  Future<void> changeFolderIcon(String folderId, String icon) async {
    final folder = _hiveService.getFolder(folderId);
    if (folder != null) {
      final updatedFolder = folder.copyWith(icon: icon);
      await updateFolder(updatedFolder);
    }
  }

  // Get folder by id
  FolderModel? getFolderById(String folderId) {
    return _hiveService.getFolder(folderId);
  }

  // Get total note count across all folders
  int get totalNoteCount {
    return _folders.fold(0, (sum, folder) => sum + folder.noteCount);
  }
}