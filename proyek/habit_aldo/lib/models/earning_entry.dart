import 'package:hive/hive.dart';

part 'earning_entry.g.dart';

@HiveType(typeId: 3)
class EarningEntry extends HiveObject {
  @HiveField(0)
  String id;

  /// Amount in USD
  @HiveField(1)
  double amount;

  @HiveField(2)
  String note;

  @HiveField(3)
  DateTime date;

  EarningEntry({
    required this.id,
    required this.amount,
    this.note = '',
    required this.date,
  });
}

@HiveType(typeId: 4)
class MonthlyEarningGoal extends HiveObject {
  /// Key: 'yyyy-MM', Value: target amount USD
  @HiveField(0)
  Map<String, double> monthlyTargets;

  MonthlyEarningGoal({Map<String, double>? monthlyTargets})
      : monthlyTargets = monthlyTargets ?? {};

  String _key(int year, int month) =>
      '$year-${month.toString().padLeft(2, '0')}';

  double targetFor(int year, int month) =>
      monthlyTargets[_key(year, month)] ?? 0;

  void setTarget(int year, int month, double target) {
    monthlyTargets[_key(year, month)] = target;
    save();
  }

  /// Daily target for today given the month target (gradual increase)
  /// On day N of the month with D total days, daily target = monthlyTarget / D
  double dailyTargetFor(DateTime date) {
    final target = targetFor(date.year, date.month);
    if (target == 0) return 0;
    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    return target / daysInMonth;
  }

  /// Cumulative target up to and including 'date' (gradual ramp)
  double cumulativeTargetUpTo(DateTime date) {
    final target = targetFor(date.year, date.month);
    if (target == 0) return 0;
    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final dayOfMonth = date.day;
    return (target / daysInMonth) * dayOfMonth;
  }
}
