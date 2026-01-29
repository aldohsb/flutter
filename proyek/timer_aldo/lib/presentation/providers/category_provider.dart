import 'package:flutter/material.dart';
import '../../data/models/category.dart';
import '../../data/services/storage_service.dart';
import '../../core/constants/app_constants.dart';

class CategoryProvider extends ChangeNotifier {
  final StorageService _storageService;
  
  List<Category> _categories = [];
  Category? _selectedCategory;
  
  CategoryProvider(this._storageService) {
    _loadCategories();
  }
  
  // Getters
  List<Category> get categories => List.unmodifiable(_categories);
  Category? get selectedCategory => _selectedCategory;
  
  // Load categories from storage
  Future<void> _loadCategories() async {
    _categories = _storageService.getCategories();
    
    // If no categories exist, create default ones
    if (_categories.isEmpty) {
      await _createDefaultCategories();
    }
    
    // Set first category as selected if none selected
    if (_selectedCategory == null && _categories.isNotEmpty) {
      _selectedCategory = _categories.first;
    }
    
    notifyListeners();
  }
  
  // Create default categories
  Future<void> _createDefaultCategories() async {
    for (final catData in AppConstants.defaultCategories) {
      final category = Category(
        name: catData['name'] as String,
        color: Color(catData['color'] as int),
        icon: _getIconData(catData['icon'] as String),
      );
      
      await _storageService.saveCategory(category);
      _categories.add(category);
    }
  }
  
  IconData _getIconData(String iconName) {
    const iconMap = {
      'work': Icons.work_outline,
      'school': Icons.school_outlined,
      'coffee': Icons.coffee_outlined,
      'people': Icons.people_outline,
      'more': Icons.more_horiz,
    };
    
    return iconMap[iconName] ?? Icons.category_outlined;
  }
  
  // Add new category
  Future<void> addCategory(Category category) async {
    await _storageService.saveCategory(category);
    _categories.add(category);
    notifyListeners();
  }
  
  // Update category
  Future<void> updateCategory(Category category) async {
    await _storageService.saveCategory(category);
    
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
      
      // Update selected category if it's the one being updated
      if (_selectedCategory?.id == category.id) {
        _selectedCategory = category;
      }
      
      notifyListeners();
    }
  }
  
  // Delete category
  Future<void> deleteCategory(String categoryId) async {
    await _storageService.deleteCategory(categoryId);
    _categories.removeWhere((c) => c.id == categoryId);
    
    // If deleted category was selected, select first available
    if (_selectedCategory?.id == categoryId && _categories.isNotEmpty) {
      _selectedCategory = _categories.first;
    }
    
    notifyListeners();
  }
  
  // Select category
  void selectCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }
  
  // Get category by id
  Category? getCategoryById(String categoryId) {
    try {
      return _categories.firstWhere((c) => c.id == categoryId);
    } catch (e) {
      return null;
    }
  }
  
  // Refresh categories
  Future<void> refresh() async {
    await _loadCategories();
  }
}
