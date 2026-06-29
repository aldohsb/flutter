import 'package:hive/hive.dart';

part 'weight_entry.g.dart';

@HiveType(typeId: 1)
class WeightEntry extends HiveObject {
  @HiveField(0)
  String id;

  /// Weight in kg
  @HiveField(1)
  double weightKg;

  @HiveField(2)
  DateTime date;

  WeightEntry({
    required this.id,
    required this.weightKg,
    required this.date,
  });
}

@HiveType(typeId: 2)
class WeightGoal extends HiveObject {
  /// Starting weight in kg
  @HiveField(0)
  double startWeightKg;

  /// Target weight in kg
  @HiveField(1)
  double targetWeightKg;

  /// Start date of the weight loss journey
  @HiveField(2)
  DateTime startDate;

  /// Number of days to reach target
  @HiveField(3)
  int durationDays;

  WeightGoal({
    required this.startWeightKg,
    required this.targetWeightKg,
    required this.startDate,
    required this.durationDays,
  });

  /// Daily target weight for a given date
  double targetForDate(DateTime date) {
    final daysPassed = date.difference(startDate).inDays;
    if (daysPassed < 0) return startWeightKg;
    if (daysPassed >= durationDays) return targetWeightKg;

    final totalLoss = startWeightKg - targetWeightKg;
    final dailyLoss = totalLoss / durationDays;
    return startWeightKg - (dailyLoss * daysPassed);
  }

  /// Daily loss in kg
  double get dailyLossKg {
    if (durationDays == 0) return 0;
    return (startWeightKg - targetWeightKg) / durationDays;
  }
}
