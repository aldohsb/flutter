import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../services/hive_service.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';

class BudgetProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  List<Category> _categories = [];
  DateTime _selectedMonth = DateTime.now();
  
  BudgetProvider() {
    _initializeData();
  }
  
  List<Transaction> get transactions => _transactions;
  List<Category> get categories => _categories;
  DateTime get selectedMonth => _selectedMonth;
  
  void _initializeData() {
    _categories = HiveService.getAllCategories();
    if (_categories.isEmpty) {
      _createDefaultCategories();
    }
    _transactions = HiveService.getAllTransactions();
    notifyListeners();
  }
  
  void _createDefaultCategories() {
    final defaultCategories = [
      Category(
        id: '1',
        name: 'Makanan',
        iconCodePoint: AppIcons.food.codePoint,
        colorValue: Colors.orange.value,
        isIncome: false,
      ),
      Category(
        id: '2',
        name: 'Transportasi',
        iconCodePoint: AppIcons.transport.codePoint,
        colorValue: Colors.blue.value,
        isIncome: false,
      ),
      Category(
        id: '3',
        name: 'Belanja',
        iconCodePoint: AppIcons.shopping.codePoint,
        colorValue: Colors.purple.value,
        isIncome: false,
      ),
      Category(
        id: '4',
        name: 'Hiburan',
        iconCodePoint: AppIcons.entertainment.codePoint,
        colorValue: Colors.pink.value,
        isIncome: false,
      ),
      Category(
        id: '5',
        name: 'Tagihan',
        iconCodePoint: AppIcons.bills.codePoint,
        colorValue: Colors.red.value,
        isIncome: false,
      ),
      Category(
        id: '6',
        name: 'Kesehatan',
        iconCodePoint: AppIcons.health.codePoint,
        colorValue: Colors.teal.value,
        isIncome: false,
      ),
      Category(
        id: '7',
        name: 'Gaji',
        iconCodePoint: AppIcons.salary.codePoint,
        colorValue: Colors.green.value,
        isIncome: true,
      ),
      Category(
        id: '8',
        name: 'Lainnya',
        iconCodePoint: AppIcons.other.codePoint,
        colorValue: Colors.grey.value,
        isIncome: false,
      ),
    ];
    
    for (var category in defaultCategories) {
      HiveService.addCategory(category);
    }
    _categories = defaultCategories;
  }
  
  Future<void> addTransaction(Transaction transaction) async {
    await HiveService.addTransaction(transaction);
    _transactions = HiveService.getAllTransactions();
    notifyListeners();
  }
  
  Future<void> deleteTransaction(String id) async {
    await HiveService.deleteTransaction(id);
    _transactions = HiveService.getAllTransactions();
    notifyListeners();
  }
  
  void setSelectedMonth(DateTime month) {
    _selectedMonth = month;
    notifyListeners();
  }
  
  List<Transaction> getTransactionsForMonth(DateTime month) {
    return _transactions.where((t) => 
      Helpers.isSameMonth(t.date, month)
    ).toList()..sort((a, b) => b.date.compareTo(a.date));
  }
  
  double getTotalIncome(DateTime month) {
    return getTransactionsForMonth(month)
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);
  }
  
  double getTotalExpense(DateTime month) {
    return getTransactionsForMonth(month)
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);
  }
  
  double getBalance(DateTime month) {
    return getTotalIncome(month) - getTotalExpense(month);
  }
  
  Map<String, double> getExpensesByCategory(DateTime month) {
    final expenses = getTransactionsForMonth(month)
      .where((t) => t.type == TransactionType.expense);
    
    final Map<String, double> categoryTotals = {};
    
    for (var transaction in expenses) {
      final category = HiveService.getCategoryById(transaction.categoryId);
      if (category != null) {
        categoryTotals[category.name] = 
          (categoryTotals[category.name] ?? 0) + transaction.amount;
      }
    }
    
    return categoryTotals;
  }
  
  Category? getCategoryById(String id) {
    return HiveService.getCategoryById(id);
  }
}