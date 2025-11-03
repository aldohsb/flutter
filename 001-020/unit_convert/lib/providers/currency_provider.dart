// Provider khusus untuk handle currency conversion dengan API
// Extends ConverterProvider untuk inherit semua functionality

import 'package:flutter/foundation.dart';
import '../services/currency_service.dart';
import '../services/storage_service.dart';
import '../models/unit_item.dart';

class CurrencyProvider with ChangeNotifier {
  // Services
  final CurrencyService _currencyService = CurrencyService();
  final StorageService _storage = StorageService();

  // State
  Map<String, double>? _exchangeRates;
  bool _isLoading = false;
  String? _errorMessage;
  DateTime? _lastUpdateTime;

  // Getters
  Map<String, double>? get exchangeRates => _exchangeRates;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  DateTime? get lastUpdateTime => _lastUpdateTime;

  // Initialize - load rates dari storage atau fetch dari API
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Coba load dari storage dulu
      _exchangeRates = _storage.loadCurrencyRates();

      // Kalau ada data di storage dan masih fresh, pakai itu
      if (_exchangeRates != null && !_storage.shouldUpdateCurrencyRates()) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Kalau tidak ada atau sudah outdated, fetch dari API
      await fetchRates();
    } catch (e) {
      _errorMessage = 'Gagal memuat data: $e';
      print('Error initializing currency provider: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method untuk fetch exchange rates dari API
  Future<void> fetchRates() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch dari API
      final rates = await _currencyService.fetchExchangeRates();

      if (rates != null) {
        _exchangeRates = rates;
        _lastUpdateTime = DateTime.now();

        // Save ke storage
        await _storage.saveCurrencyRates(rates);

        _errorMessage = null;
      } else {
        _errorMessage = 'Gagal mengambil data kurs. Coba lagi nanti.';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      print('Error fetching rates: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Method untuk update conversion factor di unit items
  // Ini dipanggil dari ConverterProvider ketika kategori currency dipilih
  List<UnitItem> updateCurrencyUnits(List<UnitItem> units) {
    // Kalau belum ada rates, return units asli
    if (_exchangeRates == null) return units;

    // Update conversion factor untuk setiap unit
    return units.map((unit) {
      // Cari rate untuk currency ini
      final rate = _exchangeRates![unit.symbol];
      
      if (rate != null) {
        // Update conversion factor
        return unit.copyWith(conversionFactor: rate);
      }
      
      return unit;
    }).toList();
  }

  // Method untuk manual refresh
  Future<void> refresh() async {
    _currencyService.clearCache();
    await fetchRates();
  }

  // Method untuk get rate untuk specific currency
  double? getRate(String currencyCode) {
    return _exchangeRates?[currencyCode];
  }

  // Method untuk format last update time
  String getLastUpdateText() {
    if (_lastUpdateTime == null) return 'Belum pernah update';

    final now = DateTime.now();
    final difference = now.difference(_lastUpdateTime!);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else {
      return '${difference.inDays} hari lalu';
    }
  }

  // Method untuk cek apakah perlu update
  bool shouldUpdate() {
    return _storage.shouldUpdateCurrencyRates();
  }
}