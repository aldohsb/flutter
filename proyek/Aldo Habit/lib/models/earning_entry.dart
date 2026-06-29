import 'package:hive/hive.dart';

part 'earning_entry.g.dart';

@HiveType(typeId: 3)
class EarningEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String? note;

  EarningEntry({
    required this.id,
    required this.date,
    required this.amount,
    this.note,
  });
}

@HiveType(typeId: 4)
class EarningGoal extends HiveObject {
  @HiveField(0)
  double monthlyTarget;

  EarningGoal({required this.monthlyTarget});
}
