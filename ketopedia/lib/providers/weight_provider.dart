import 'package:flutter/foundation.dart';
import '../models/weight_entry_model.dart';
import '../services/database_service.dart';
import '../services/export_service.dart';
import '../models/user_model.dart';

class WeightProvider with ChangeNotifier {
  List<WeightEntryModel> _entries = [];
  bool _isLoading = false;
  String? _error;

  List<WeightEntryModel> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  WeightEntryModel? get latestEntry =>
      _entries.isNotEmpty ? _entries.first : null;

  double? get currentWeight => latestEntry?.weight;

  double? get initialWeight =>
      _entries.isNotEmpty ? _entries.last.weight : null;

  double? get totalWeightChange {
    if (_entries.length < 2) return null;
    return currentWeight! - initialWeight!;
  }

  Future<void> loadEntries(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _entries = await DatabaseService.instance.getWeightEntries(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addEntry(WeightEntryModel entry) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final id = await DatabaseService.instance.insertWeightEntry(entry);
      final newEntry = entry.copyWith(id: id);
      _entries.insert(0, newEntry);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEntry(WeightEntryModel entry) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await DatabaseService.instance.updateWeightEntry(entry);
      final index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteEntry(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await DatabaseService.instance.deleteWeightEntry(id);
      _entries.removeWhere((entry) => entry.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<WeightEntryModel> getEntriesForChart() {
    // Return entries in chronological order for chart
    return _entries.reversed.toList();
  }

  double? getAverageWeightLoss() {
    if (_entries.length < 2) return null;

    final firstEntry = _entries.last;
    final lastEntry = _entries.first;
    final daysDiff =
        lastEntry.date.difference(firstEntry.date).inDays;

    if (daysDiff == 0) return null;

    final weightDiff = firstEntry.weight - lastEntry.weight;
    return (weightDiff / daysDiff) * 7; // Average per week
  }

  Future<bool> exportData(UserModel user) async {
    try {
      await ExportService.instance.shareWeightData(user, _entries);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}