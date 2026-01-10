import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String title;
  
  @HiveField(2)
  double amount;
  
  @HiveField(3)
  String categoryId;
  
  @HiveField(4)
  TransactionType type;
  
  @HiveField(5)
  DateTime date;
  
  @HiveField(6)
  String? note;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.type,
    required this.date,
    this.note,
  });
}