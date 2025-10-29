// File: lib/providers/quote_provider.dart

import 'dart:convert'; // Untuk encode/decode JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Untuk save data local
import '../models/quote_model.dart';
import '../services/quote_service.dart';

// ChangeNotifier = class khusus Flutter untuk State Management
// Seperti "papan pengumuman" yang bisa ngasih tau kalau ada update
class QuoteProvider with ChangeNotifier {
  // Instance dari QuoteService untuk fetch data
  final QuoteService _quoteService = QuoteService();

  // State variables - data yang bisa berubah
  QuoteModel? _currentQuote; // Quote yang sedang ditampilkan (? = bisa null)
  List<QuoteModel> _favorites = []; // List quote favorit
  bool _isLoading = false; // Status loading (true = sedang fetch data)
  String? _error; // Pesan error (kalau ada)
  int _currentIndex = 0; // Index quote saat ini (untuk pagination 1/365)

  // Getters - cara baca data dari luar class
  // Seperti kaca jendela: bisa lihat tapi tidak bisa ubah langsung
  QuoteModel? get currentQuote => _currentQuote;
  List<QuoteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentIndex => _currentIndex;
  String get backgroundImageUrl => _quoteService.getBackgroundImageUrl(_currentIndex);

  // Constructor - jalan pas QuoteProvider pertama kali dibuat
  QuoteProvider() {
    // Load favorites dari local storage
    _loadFavorites();
    // Langsung fetch quote pertama
    fetchNewQuote();
  }

  // Method untuk fetch quote baru dari API
  Future<void> fetchNewQuote() async {
    // Set loading jadi true, TAPI jangan reset error
    // Biar user tau kalau offline
    _isLoading = true;
    notifyListeners(); // Beritahu semua widget yang "dengerin" provider ini

    try {
      // Panggil service untuk ambil data
      final quote = await _quoteService.fetchRandomQuote();
      
      // Update state dengan quote baru
      _currentQuote = quote;
      _currentIndex++; // Tambah index untuk pagination
      _isLoading = false;
      _error = null; // Reset error karena berhasil
      
      // notifyListeners() = kasih tau semua widget: "Ada update nih!"
      // Widget yang pakai Provider ini akan otomatis rebuild
      notifyListeners();
    } catch (e) {
      // Kalau error, coba ambil dari fallback
      print('Error in provider: $e');
      _error = 'Offline mode';
      _isLoading = false;
      
      // Coba lagi ambil quote (akan pakai fallback)
      try {
        final quote = await _quoteService.fetchRandomQuote();
        _currentQuote = quote;
        _currentIndex++;
      } catch (e2) {
        print('Even fallback failed: $e2');
      }
      
      notifyListeners();
    }
  }

  // Method untuk cek apakah quote ini sudah masuk favorit
  bool isFavorite(String quoteId) {
    // any() = cek apakah ada item yang memenuhi kondisi
    return _favorites.any((quote) => quote.id == quoteId);
  }

  // Method untuk toggle favorite (tambah/hapus dari favorit)
  void toggleFavorite(QuoteModel quote) {
    if (isFavorite(quote.id)) {
      // Kalau sudah ada di favorit, hapus
      // removeWhere() = hapus item yang memenuhi kondisi
      _favorites.removeWhere((q) => q.id == quote.id);
    } else {
      // Kalau belum ada, tambahkan
      _favorites.add(quote);
    }
    
    // Save ke local storage
    _saveFavorites();
    notifyListeners();
  }

  // Method untuk save favorites ke local storage
  // Biar data tidak hilang pas app ditutup
  Future<void> _saveFavorites() async {
    try {
      // SharedPreferences = storage local di HP (seperti database mini)
      final prefs = await SharedPreferences.getInstance();
      
      // Convert List<QuoteModel> jadi List<String> (JSON)
      // Karena SharedPreferences hanya bisa save data primitif
      final favoritesJson = _favorites.map((q) => json.encode(q.toJson())).toList();
      
      // Save dengan key 'favorites'
      await prefs.setStringList('favorites', favoritesJson);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  // Method untuk load favorites dari local storage
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Ambil data dengan key 'favorites'
      final favoritesJson = prefs.getStringList('favorites');
      
      if (favoritesJson != null) {
        // Convert List<String> jadi List<QuoteModel>
        _favorites = favoritesJson
            .map((jsonStr) => QuoteModel.fromJson(json.decode(jsonStr)))
            .toList();
        
        notifyListeners();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // Method untuk hapus satu favorite
  void removeFavorite(String quoteId) {
    _favorites.removeWhere((q) => q.id == quoteId);
    _saveFavorites();
    notifyListeners();
  }

  // Method untuk clear semua favorites
  void clearFavorites() {
    _favorites.clear();
    _saveFavorites();
    notifyListeners();
  }
}