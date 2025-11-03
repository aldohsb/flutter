// Provider adalah state management untuk aplikasi
// Ini adalah otak dari aplikasi yang mengelola semua data dan logika

import 'package:flutter/foundation.dart';
import '../models/unit_category.dart';
import '../models/unit_item.dart';
import '../models/conversion_result.dart';
import '../utils/unit_definitions.dart';
import '../utils/conversion_calculator.dart';
import '../services/storage_service.dart';

// ChangeNotifier adalah class yang bisa memberitahu listener ketika ada perubahan
// Bayangkan seperti penyiar radio yang broadcast update ke semua pendengar
class ConverterProvider with ChangeNotifier {
  // Storage service untuk menyimpan data
  final StorageService _storage = StorageService();

  // ========== STATE VARIABLES ==========
  // Variables ini menyimpan state/kondisi aplikasi saat ini

  // Kategori yang sedang dipilih (Length, Weight, dll)
  UnitCategory _selectedCategory = UnitDefinitions.categories.first;

  // Unit asal dan tujuan yang dipilih
  UnitItem? _fromUnit;
  UnitItem? _toUnit;

  // Input dari user (string, karena user ketik di number pad)
  String _inputValue = '0';

  // Hasil konversi
  double? _outputValue;

  // History konversi
  List<ConversionResult> _history = [];

  // Loading state (untuk show loading indicator)
  bool _isLoading = false;

  // ========== GETTERS ==========
  // Getter adalah method untuk mendapatkan nilai private variables
  
  UnitCategory get selectedCategory => _selectedCategory;
  UnitItem? get fromUnit => _fromUnit;
  UnitItem? get toUnit => _toUnit;
  String get inputValue => _inputValue;
  double? get outputValue => _outputValue;
  List<ConversionResult> get history => _history;
  bool get isLoading => _isLoading;

  // Getter untuk list unit berdasarkan kategori yang dipilih
  List<UnitItem> get availableUnits {
    return UnitDefinitions.getUnitsForCategory(_selectedCategory.type);
  }

  // ========== INITIALIZATION ==========

  // Initialize provider - load data dari storage
  Future<void> init() async {
    _isLoading = true;
    notifyListeners(); // Beritahu UI untuk update

    try {
      // Load history dari storage
      _history = await _storage.loadConversionHistory();

      // Load kategori terakhir yang dipilih
      final lastCategoryName = _storage.loadLastCategory();
      if (lastCategoryName != null) {
        // Find kategori by name
        final category = UnitDefinitions.categories.firstWhere(
          (cat) => cat.name == lastCategoryName,
          orElse: () => UnitDefinitions.categories.first,
        );
        _selectedCategory = category;
      }

      // Set default units untuk kategori
      _setDefaultUnits();
    } catch (e) {
      print('Error initializing provider: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Set default units berdasarkan kategori
  void _setDefaultUnits() {
    final units = availableUnits;
    if (units.isEmpty) return;

    // Set from unit ke unit pertama
    _fromUnit = units.first;
    
    // Set to unit ke unit kedua (kalau ada)
    _toUnit = units.length > 1 ? units[1] : units.first;
  }

  // ========== CATEGORY SELECTION ==========

  // Method untuk ganti kategori
  void selectCategory(UnitCategory category) {
    _selectedCategory = category;
    
    // Reset units dan values
    _setDefaultUnits();
    _inputValue = '0';
    _outputValue = null;

    // Save ke storage
    _storage.saveLastCategory(category.name);

    notifyListeners(); // Beritahu UI untuk update
  }

  // ========== UNIT SELECTION ==========

  // Method untuk ganti from unit
  void selectFromUnit(UnitItem unit) {
    _fromUnit = unit;
    
    // Kalau to unit sama dengan from unit, swap
    if (_toUnit == unit) {
      _toUnit = _fromUnit;
    }

    // Recalculate conversion
    _calculateConversion();
    notifyListeners();
  }

  // Method untuk ganti to unit
  void selectToUnit(UnitItem unit) {
    _toUnit = unit;
    
    // Kalau from unit sama dengan to unit, swap
    if (_fromUnit == unit) {
      _fromUnit = _toUnit;
    }

    // Recalculate conversion
    _calculateConversion();
    notifyListeners();
  }

  // Method untuk swap from dan to unit
  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;

    // Swap juga input dan output value
    if (_outputValue != null) {
      _inputValue = ConversionCalculator.formatResult(_outputValue!);
      _calculateConversion();
    }

    notifyListeners();
  }

  // ========== INPUT HANDLING ==========

  // Method untuk handle input dari number pad
  void handleNumberInput(String number) {
    // Kalau input masih '0', replace dengan number
    if (_inputValue == '0') {
      _inputValue = number;
    } else {
      // Append number ke input
      _inputValue += number;
    }

    // Calculate conversion
    _calculateConversion();
    notifyListeners();
  }

  // Method untuk handle decimal point
  void handleDecimalPoint() {
    // Kalau sudah ada decimal point, ignore
    if (_inputValue.contains('.')) return;

    _inputValue += '.';
    notifyListeners();
  }

  // Method untuk delete last character
  void handleBackspace() {
    if (_inputValue.length <= 1) {
      _inputValue = '0';
    } else {
      _inputValue = _inputValue.substring(0, _inputValue.length - 1);
    }

    _calculateConversion();
    notifyListeners();
  }

  // Method untuk clear input
  void handleClear() {
    _inputValue = '0';
    _outputValue = null;
    notifyListeners();
  }

  // ========== CONVERSION CALCULATION ==========

  // Private method untuk calculate conversion
  void _calculateConversion() {
    // Validasi
    if (_fromUnit == null || _toUnit == null) {
      _outputValue = null;
      return;
    }

    // Parse input value
    final value = ConversionCalculator.parseInput(_inputValue);
    if (value == null) {
      _outputValue = null;
      return;
    }

    // Calculate conversion
    _outputValue = ConversionCalculator.convert(
      value: value,
      fromUnit: _fromUnit!,
      toUnit: _toUnit!,
      category: _selectedCategory.type,
    );
  }

  // ========== HISTORY ==========

  // Method untuk save conversion ke history
  void saveToHistory() {
    if (_fromUnit == null || _toUnit == null || _outputValue == null) return;

    final value = ConversionCalculator.parseInput(_inputValue);
    if (value == null) return;

    // Create conversion result
    final result = ConversionResult(
      inputValue: value,
      outputValue: _outputValue!,
      fromUnit: _fromUnit!,
      toUnit: _toUnit!,
      timestamp: DateTime.now(),
    );

    // Add ke history (di depan)
    _history.insert(0, result);

    // Limit history to 50 items
    if (_history.length > 50) {
      _history = _history.sublist(0, 50);
    }

    // Save to storage
    _storage.saveConversionHistory(_history);

    notifyListeners();
  }

  // Method untuk clear history
  void clearHistory() {
    _history.clear();
    _storage.clearHistory();
    notifyListeners();
  }

  // Method untuk load conversion dari history
  void loadFromHistory(ConversionResult result) {
    // Find kategori
    final category = UnitDefinitions.categories.firstWhere(
      (cat) => cat.type == _getCategoryForUnit(result.fromUnit),
      orElse: () => _selectedCategory,
    );

    _selectedCategory = category;
    _fromUnit = result.fromUnit;
    _toUnit = result.toUnit;
    _inputValue = ConversionCalculator.formatResult(result.inputValue);
    _outputValue = result.outputValue;

    notifyListeners();
  }

  // Helper method untuk get category dari unit
  UnitCategoryType _getCategoryForUnit(UnitItem unit) {
    // Loop through all categories
    for (final category in UnitDefinitions.categories) {
      final units = UnitDefinitions.getUnitsForCategory(category.type);
      if (units.contains(unit)) {
        return category.type;
      }
    }
    return UnitCategoryType.length; // Default
  }
}