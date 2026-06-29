import 'package:hive/hive.dart';

part 'weight_entry.g.dart';

@HiveType(typeId: 1)
class WeightEntry extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double weight;

  WeightEntry({required this.date, required this.weight});
}

@HiveType(typeId: 2)
class WeightGoal extends HiveObject {
  @HiveField(0)
  double startWeight;

  @HiveField(1)
  double targetWeight;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  int targetDays;

  WeightGoal({
    required this.startWeight,
    required this.targetWeight,
    required this.startDate,
    required this.targetDays,
  });

  /// Target berat untuk hari tertentu (interpolasi linear)
  double targetWeightForDate(DateTime date) {
    final daysPassed = DateTime(date.year, date.month, date.day)
        .difference(DateTime(startDate.year, startDate.month, startDate.day))
        .inDays;
    if (daysPassed <= 0) return startWeight;
    if (daysPassed >= targetDays) return targetWeight;
    final dailyChange = (targetWeight - startWeight) / targetDays;
    return startWeight + (dailyChange * daysPassed);
  }

  double get dailyChange => (targetWeight - startWeight) / targetDays;
}
