import 'package:hive/hive.dart';
import '../models/transaction.dart';
import '../models/category.dart';

class HiveService {
  static Box<Transaction> get transactionBox => Hive.box<Transaction>('transactions');
  static Box<Category> get categoryBox => Hive.box<Category>('categories');
  
  static Future<void> addTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }
  
  static Future<void> updateTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }
  
  static Future<void> deleteTransaction(String id) async {
    await transactionBox.delete(id);
  }
  
  static List<Transaction> getAllTransactions() {
    return transactionBox.values.toList();
  }
  
  static Future<void> addCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }
  
  static Future<void> deleteCategory(String id) async {
    await categoryBox.delete(id);
  }
  
  static List<Category> getAllCategories() {
    return categoryBox.values.toList();
  }
  
  static List<Category> getExpenseCategories() {
    return categoryBox.values.where((cat) => !cat.isIncome).toList();
  }
  
  static List<Category> getIncomeCategories() {
    return categoryBox.values.where((cat) => cat.isIncome).toList();
  }
  
  static Category? getCategoryById(String id) {
    return categoryBox.get(id);
  }
}