import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as drift;
import '../database/app_database.dart';
import '../utils/helpers.dart';

class TransactionProvider with ChangeNotifier {
  final AppDatabase _database;
  
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];
  DateTime _selectedMonth = DateTime.now();
  bool _isLoading = false;

  TransactionProvider(this._database) {
    loadTransactions();
  }

  // Getters
  List<Transaction> get transactions => _filteredTransactions;
  DateTime get selectedMonth => _selectedMonth;
  bool get isLoading => _isLoading;

  // Load transactions for selected month
  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final startDate = Helpers.getFirstDayOfMonth(_selectedMonth);
      final endDate = Helpers.getLastDayOfMonth(_selectedMonth);

      _filteredTransactions = await _database.getTransactionsByDateRange(
        startDate,
        endDate,
      );
      
      _transactions = await _database.getAllTransactions();
    } catch (e) {
      debugPrint('Error loading transactions: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add transaction
  Future<void> addTransaction({
    required String type,
    required double amount,
    required String category,
    required String description,
    required DateTime date,
  }) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      
      await _database.addTransaction(
        TransactionsCompanion(
          id: drift.Value(id),
          type: drift.Value(type),
          amount: drift.Value(amount),
          category: drift.Value(category),
          description: drift.Value(description),
          date: drift.Value(date),
          createdAt: drift.Value(DateTime.now()),
        ),
      );

      await loadTransactions();
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      rethrow;
    }
  }

  // Update transaction
  Future<void> updateTransaction({
    required String id,
    required String type,
    required double amount,
    required String category,
    required String description,
    required DateTime date,
    required DateTime createdAt,
  }) async {
    try {
      await _database.updateTransaction(
        Transaction(
          id: id,
          type: type,
          amount: amount,
          category: category,
          description: description,
          date: date,
          createdAt: createdAt,
        ),
      );

      await loadTransactions();
    } catch (e) {
      debugPrint('Error updating transaction: $e');
      rethrow;
    }
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    try {
      await _database.deleteTransaction(id);
      await loadTransactions();
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      rethrow;
    }
  }

  // Change selected month
  void changeMonth(DateTime newMonth) {
    _selectedMonth = newMonth;
    loadTransactions();
  }

  // Get total income
  Future<double> getTotalIncome() async {
    final startDate = Helpers.getFirstDayOfMonth(_selectedMonth);
    final endDate = Helpers.getLastDayOfMonth(_selectedMonth);
    return await _database.getSumByTypeAndDateRange('income', startDate, endDate);
  }

  // Get total expense
  Future<double> getTotalExpense() async {
    final startDate = Helpers.getFirstDayOfMonth(_selectedMonth);
    final endDate = Helpers.getLastDayOfMonth(_selectedMonth);
    return await _database.getSumByTypeAndDateRange('expense', startDate, endDate);
  }

  // Get balance
  Future<double> getBalance() async {
    final income = await getTotalIncome();
    final expense = await getTotalExpense();
    return income - expense;
  }

  // Get category totals
  Map<String, double> getCategoryTotals(String type) {
    final categoryMap = <String, double>{};
    
    for (var transaction in _filteredTransactions) {
      if (transaction.type == type) {
        categoryMap[transaction.category] = 
            (categoryMap[transaction.category] ?? 0) + transaction.amount;
      }
    }
    
    return categoryMap;
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
}