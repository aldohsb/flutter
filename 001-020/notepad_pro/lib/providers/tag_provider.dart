import 'package:flutter/material.dart';
import 'package:notepad_pro/models/tag_model.dart';
import 'package:notepad_pro/services/hive_service.dart';
import 'package:notepad_pro/utils/constants.dart';
import 'package:uuid/uuid.dart';

class TagProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final Uuid _uuid = const Uuid();

  List<TagModel> _tags = [];

  // Getters
  List<TagModel> get tags {
    // Sort by usage count (most used first)
    final sortedTags = List<TagModel>.from(_tags);
    sortedTags.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    return sortedTags;
  }

  // Load all tags
  Future<void> loadTags() async {
    _tags = _hiveService.getAllTags();
    notifyListeners();
  }

  // Create tag
  Future<TagModel> createTag({
    required String name,
    Color? color,
  }) async {
    // Check if tag already exists
    final existingTag = _hiveService.getTagByName(name);
    if (existingTag != null && existingTag.id.isNotEmpty) {
      return existingTag;
    }

    // Create new tag
    final tag = TagModel.create(
      id: _uuid.v4(),
      name: name,
      color: color ?? _getRandomTagColor(),
    );

    await _hiveService.addTag(tag);
    await loadTags();
    return tag;
  }

  // Update tag
  Future<void> updateTag(TagModel tag) async {
    await _hiveService.updateTag(tag);
    await loadTags();
  }

  // Delete tag
  Future<void> deleteTag(String tagId) async {
    await _hiveService.deleteTag(tagId);
    await loadTags();
  }

  // Rename tag
  Future<void> renameTag(String tagId, String newName) async {
    final tag = _hiveService.getTag(tagId);
    if (tag != null) {
      final updatedTag = tag.copyWith(name: newName);
      await updateTag(updatedTag);
    }
  }

  // Change tag color
  Future<void> changeTagColor(String tagId, Color color) async {
    final tag = _hiveService.getTag(tagId);
    if (tag != null) {
      final updatedTag = tag.copyWith(color: color);
      await updateTag(updatedTag);
    }
  }

  // Increment usage count
  Future<void> incrementTagUsage(String tagName) async {
    final tag = _hiveService.getTagByName(tagName);
    if (tag != null && tag.id.isNotEmpty) {
      final updatedTag = tag.copyWith(
        usageCount: tag.usageCount + 1,
      );
      await updateTag(updatedTag);
    }
  }

  // Decrement usage count
  Future<void> decrementTagUsage(String tagName) async {
    final tag = _hiveService.getTagByName(tagName);
    if (tag != null && tag.id.isNotEmpty && tag.usageCount > 0) {
      final updatedTag = tag.copyWith(
        usageCount: tag.usageCount - 1,
      );
      await updateTag(updatedTag);
    }
  }

  // Get tag by name
  TagModel? getTagByName(String name) {
    return _hiveService.getTagByName(name);
  }

  // Get or create tag
  Future<TagModel> getOrCreateTag(String name) async {
    final existingTag = getTagByName(name);
    if (existingTag != null && existingTag.id.isNotEmpty) {
      return existingTag;
    }
    return await createTag(name: name);
  }

  // Get popular tags (top 10)
  List<TagModel> getPopularTags({int limit = 10}) {
    final sortedTags = List<TagModel>.from(_tags);
    sortedTags.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    return sortedTags.take(limit).toList();
  }

  // Search tags
  List<TagModel> searchTags(String query) {
    if (query.isEmpty) return tags;
    
    final lowerQuery = query.toLowerCase();
    return _tags
        .where((tag) => tag.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // Get random color for new tag
  Color _getRandomTagColor() {
    final index = DateTime.now().millisecond % AppConstants.tagColors.length;
    return AppConstants.tagColors[index];
  }

  // Clean unused tags (with 0 usage count)
  Future<void> cleanUnusedTags() async {
    final unusedTags = _tags.where((tag) => tag.usageCount == 0).toList();
    for (var tag in unusedTags) {
      await deleteTag(tag.id);
    }
    await loadTags();
  }
}