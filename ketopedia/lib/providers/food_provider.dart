import 'package:flutter/foundation.dart';
import '../models/food_model.dart';
import '../services/database_service.dart';
import '../utils/constants.dart';

class FoodProvider with ChangeNotifier {
  List<FoodModel> _allFoods = [];
  List<FoodModel> _filteredFoods = [];
  List<FoodModel> _favorites = [];
  
  FoodCategory? _selectedCategory;
  int? _selectedRating;
  String _searchQuery = '';
  
  bool _isLoading = false;
  String? _error;

  List<FoodModel> get foods => _filteredFoods;
  List<FoodModel> get favorites => _favorites;
  FoodCategory? get selectedCategory => _selectedCategory;
  int? get selectedRating => _selectedRating;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allFoods = await DatabaseService.instance.getAllFoods();
      _applyFilters();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavorites(int userId) async {
    try {
      _favorites = await DatabaseService.instance.getFavorites(userId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void searchFoods(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void filterByCategory(FoodCategory? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void filterByRating(int? rating) {
    _selectedRating = rating;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _selectedCategory = null;
    _selectedRating = null;
    _searchQuery = '';
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredFoods = _allFoods;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredFoods = _filteredFoods
          .where((food) =>
              food.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (_selectedCategory != null) {
      _filteredFoods = _filteredFoods
          .where((food) => food.category == _selectedCategory)
          .toList();
    }

    // Apply rating filter
    if (_selectedRating != null) {
      _filteredFoods = _filteredFoods
          .where((food) => food.rating == _selectedRating)
          .toList();
    }

    // Sort by name
    _filteredFoods.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<bool> toggleFavorite(int userId, int foodId) async {
    try {
      final isFav = await DatabaseService.instance.isFavorite(userId, foodId);
      
      if (isFav) {
        await DatabaseService.instance.removeFavorite(userId, foodId);
      } else {
        await DatabaseService.instance.addFavorite(userId, foodId);
      }
      
      await loadFavorites(userId);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> isFavorite(int userId, int foodId) async {
    return await DatabaseService.instance.isFavorite(userId, foodId);
  }

  List<FoodModel> getFoodsByCategory(FoodCategory category) {
    return _allFoods.where((food) => food.category == category).toList();
  }

  List<FoodModel> getRecommendedFoods() {
    return _allFoods
        .where((food) => food.rating == AppConstants.ratingExcellentValue)
        .toList()
      ..shuffle();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}