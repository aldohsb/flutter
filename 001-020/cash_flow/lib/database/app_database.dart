import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// Define Transactions table
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get all transactions
  Future<List<Transaction>> getAllTransactions() async {
    return await select(transactions).get();
  }

  // Get transactions by date range
  Future<List<Transaction>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (select(transactions)
          ..where((t) => t.date.isBetweenValues(startDate, endDate))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  // Get transactions by type
  Future<List<Transaction>> getTransactionsByType(String type) async {
    return await (select(transactions)
          ..where((t) => t.type.equals(type))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  // Add transaction
  Future<int> addTransaction(TransactionsCompanion transaction) async {
    return await into(transactions).insert(transaction);
  }

  // Update transaction
  Future<bool> updateTransaction(Transaction transaction) async {
    return await update(transactions).replace(transaction);
  }

  // Delete transaction
  Future<int> deleteTransaction(String id) async {
    return await (delete(transactions)..where((t) => t.id.equals(id))).go();
  }

  // Get sum by type and date range
  Future<double> getSumByTypeAndDateRange(
    String type,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.amount.sum()])
      ..where(transactions.type.equals(type))
      ..where(transactions.date.isBetweenValues(startDate, endDate));

    final result = await query.getSingleOrNull();
    return result?.read(transactions.amount.sum()) ?? 0.0;
  }

  // Get transactions count
  Future<int> getTransactionsCount() async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.id.count()]);
    final result = await query.getSingleOrNull();
    return result?.read(transactions.id.count()) ?? 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cash_flow.sqlite'));
    return NativeDatabase(file);
  });
}