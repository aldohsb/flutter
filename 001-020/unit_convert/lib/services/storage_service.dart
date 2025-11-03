// Service untuk menyimpan dan mengambil data dari local storage
// Menggunakan SharedPreferences untuk persistensi data

import 'dart:convert'; // Untuk encode/decode JSON
import 'package:shared_preferences/shared_preferences.dart';
import '../models/conversion_result.dart';

class StorageService {
  // Singleton pattern - hanya ada satu instance StorageService di app
  // Ini efisien karena tidak perlu create instance berkali-kali
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // Key untuk menyimpan data di SharedPreferences
  static const String _historyKey = 'conversion_history';
  static const String _lastCategoryKey = 'last_category';
  static const String _currencyRatesKey = 'currency_rates';
  static const String _currencyUpdateTimeKey = 'currency_update_time';

  // Instance SharedPreferences
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  // Method ini harus dipanggil pertama kali sebelum pakai storage
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter untuk memastikan _prefs sudah initialized
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService belum di-initialize. Panggil init() dulu.');
    }
    return _prefs!;
  }

  // ========== HISTORY METHODS ==========

  // Save history konversi
  Future<void> saveConversionHistory(List<ConversionResult> history) async {
    // Convert list of objects ke list of maps
    final List<Map<String, dynamic>> historyMaps = 
        history.map((result) => result.toMap()).toList();
    
    // Encode ke JSON string
    final String jsonString = jsonEncode(historyMaps);
    
    // Save ke SharedPreferences
    await prefs.setString(_historyKey, jsonString);
  }

  // Load history konversi
  Future<List<ConversionResult>> loadConversionHistory() async {
    // Ambil JSON string dari SharedPreferences
    final String? jsonString = prefs.getString(_historyKey);
    
    // Kalau tidak ada data, return empty list
    if (jsonString == null) return [];

    try {
      // Decode JSON string ke list of maps
      final List<dynamic> jsonList = jsonDecode(jsonString);
      
      // Convert setiap map jadi ConversionResult object
      final List<ConversionResult> history = jsonList
          .map((json) => ConversionResult.fromMap(json as Map<String, dynamic>))
          .toList();
      
      return history;
    } catch (e) {
      // Kalau error saat parsing, return empty list
      print('Error loading history: $e');
      return [];
    }
  }

  // Clear semua history
  Future<void> clearHistory() async {
    await prefs.remove(_historyKey);
  }

  // ========== CATEGORY PREFERENCE ==========

  // Save kategori terakhir yang dipilih user
  Future<void> saveLastCategory(String categoryName) async {
    await prefs.setString(_lastCategoryKey, categoryName);
  }

  // Load kategori terakhir
  String? loadLastCategory() {
    return prefs.getString(_lastCategoryKey);
  }

  // ========== CURRENCY RATES ==========

  // Save currency rates (nilai tukar mata uang)
  Future<void> saveCurrencyRates(Map<String, double> rates) async {
    // Convert map ke JSON string
    final String jsonString = jsonEncode(rates);
    await prefs.setString(_currencyRatesKey, jsonString);
    
    // Save juga waktu update
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_currencyUpdateTimeKey, timestamp);
  }

  // Load currency rates
  Map<String, double>? loadCurrencyRates() {
    final String? jsonString = prefs.getString(_currencyRatesKey);
    if (jsonString == null) return null;

    try {
      // Decode JSON string
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      
      // Convert nilai jadi double (karena JSON bisa return int atau double)
      final Map<String, double> rates = {};
      jsonMap.forEach((key, value) {
        rates[key] = (value as num).toDouble();
      });
      
      return rates;
    } catch (e) {
      print('Error loading currency rates: $e');
      return null;
    }
  }

  // Cek apakah currency rates perlu di-update
  // Return true jika data lebih dari 1 hari
  bool shouldUpdateCurrencyRates() {
    final int? timestamp = prefs.getInt(_currencyUpdateTimeKey);
    if (timestamp == null) return true;

    final DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final Duration difference = DateTime.now().difference(lastUpdate);
    
    // Update kalau lebih dari 24 jam
    return difference.inHours >= 24;
  }

  // ========== GENERAL METHODS ==========

  // Clear semua data
  Future<void> clearAll() async {
    await prefs.clear();
  }

  // Save generic string value
  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  // Load generic string value
  String? loadString(String key) {
    return prefs.getString(key);
  }

  // Save generic bool value
  Future<void> saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  // Load generic bool value
  bool loadBool(String key, {bool defaultValue = false}) {
    return prefs.getBool(key) ?? defaultValue;
  }
}