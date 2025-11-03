// Service untuk fetch currency exchange rates dari API
// Menggunakan API gratis dari exchangerate-api.com

import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  // Singleton pattern
  static final CurrencyService _instance = CurrencyService._internal();
  factory CurrencyService() => _instance;
  CurrencyService._internal();

  // API endpoint - kita pakai exchangerate-api.com (gratis, no API key needed)
  // Base currency: USD
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest';
  static const String _baseCurrency = 'USD';

  // Cache untuk menyimpan rates yang sudah di-fetch
  // Agar tidak perlu fetch berkali-kali
  Map<String, double>? _cachedRates;
  DateTime? _lastFetchTime;

  // Duration sebelum cache expired (1 hour)
  static const Duration _cacheDuration = Duration(hours: 1);

  // Method untuk fetch exchange rates
  Future<Map<String, double>?> fetchExchangeRates() async {
    // Kalau ada cache yang masih valid, return cache
    if (_isCacheValid()) {
      return _cachedRates;
    }

    try {
      // Buat HTTP request ke API
      final Uri url = Uri.parse('$_baseUrl/$_baseCurrency');
      
      // Set timeout 10 detik
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Kalau timeout, throw error
          throw Exception('Request timeout');
        },
      );

      // Cek apakah response sukses (status code 200)
      if (response.statusCode == 200) {
        // Parse JSON response
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Extract rates dari response
        // Response format: { "rates": { "EUR": 0.85, "IDR": 15000, ... } }
        final Map<String, dynamic> ratesJson = data['rates'] as Map<String, dynamic>;
        
        // Convert ke Map<String, double>
        final Map<String, double> rates = {};
        ratesJson.forEach((key, value) {
          rates[key] = (value as num).toDouble();
        });

        // Simpan ke cache
        _cachedRates = rates;
        _lastFetchTime = DateTime.now();

        return rates;
      } else {
        // Kalau response tidak sukses
        print('Failed to fetch rates. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Catch semua error (network error, parsing error, dll)
      print('Error fetching exchange rates: $e');
      return null;
    }
  }

  // Method untuk cek apakah cache masih valid
  bool _isCacheValid() {
    // Kalau belum pernah fetch, cache tidak valid
    if (_cachedRates == null || _lastFetchTime == null) {
      return false;
    }

    // Cek apakah cache sudah expired
    final Duration timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
    return timeSinceLastFetch < _cacheDuration;
  }

  // Method untuk get rate specific currency
  // Contoh: getRate('IDR') => 15000
  Future<double?> getRate(String currencyCode) async {
    final rates = await fetchExchangeRates();
    if (rates == null) return null;

    return rates[currencyCode];
  }

  // Method untuk convert amount dari satu currency ke currency lain
  Future<double?> convert({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    // Kalau currency sama, return amount asli
    if (fromCurrency == toCurrency) return amount;

    // Fetch rates
    final rates = await fetchExchangeRates();
    if (rates == null) return null;

    // Get rate untuk from dan to currency
    final fromRate = rates[fromCurrency];
    final toRate = rates[toCurrency];

    // Kalau salah satu rate tidak ada, return null
    if (fromRate == null || toRate == null) return null;

    // Convert:
    // 1. Convert dari fromCurrency ke USD (base currency)
    // 2. Convert dari USD ke toCurrency
    final amountInUSD = amount / fromRate;
    final result = amountInUSD * toRate;

    return result;
  }

  // Method untuk clear cache (force refresh)
  void clearCache() {
    _cachedRates = null;
    _lastFetchTime = null;
  }

  // Method untuk get semua available currencies
  Future<List<String>?> getAvailableCurrencies() async {
    final rates = await fetchExchangeRates();
    if (rates == null) return null;

    // Return list currency codes
    return rates.keys.toList()..sort(); // Sort alphabetically
  }

  // Method untuk format currency dengan symbol
  String formatCurrency(double amount, String currencyCode) {
    // Map currency code ke symbol
    final Map<String, String> symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'IDR': 'Rp',
      'MYR': 'RM',
      'SGD': 'S\$',
    };

    final symbol = symbols[currencyCode] ?? currencyCode;
    
    // Format dengan 2 desimal
    final formatted = amount.toStringAsFixed(2);
    
    return '$symbol $formatted';
  }
}