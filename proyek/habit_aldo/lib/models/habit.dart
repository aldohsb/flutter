import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int sortOrder;

  @HiveField(3)
  // Key: 'yyyy-MM-dd', Value: true/false
  Map<String, bool> completionLog;

  @HiveField(4)
  DateTime startDate;

  @HiveField(5)
  DateTime createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.sortOrder,
    Map<String, bool>? completionLog,
    DateTime? startDate,
    DateTime? createdAt,
  })  : completionLog = completionLog ?? {},
        startDate = startDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  // ── Helpers ──────────────────────────────────────────────

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  bool isCompletedOn(DateTime date) => completionLog[_dateKey(date)] == true;

  void setCompleted(DateTime date, bool value) {
    completionLog[_dateKey(date)] = value;
    save();
  }

  /// Current streak: consecutive completed days ending today or yesterday
  int get streak {
    int count = 0;
    DateTime day = DateTime.now();
    // If today not yet completed, start from yesterday
    if (!isCompletedOn(day)) {
      day = day.subtract(const Duration(days: 1));
    }
    while (isCompletedOn(day)) {
      count++;
      day = day.subtract(const Duration(days: 1));
      if (day.isBefore(startDate.subtract(const Duration(days: 1)))) break;
    }
    return count;
  }

  /// Completion percentage from startDate to yesterday (inclusive)
  double get completionPercent {
    final today = DateTime.now();
    final from = DateTime(startDate.year, startDate.month, startDate.day);
    final to = DateTime(today.year, today.month, today.day)
        .subtract(const Duration(days: 1));

    if (to.isBefore(from)) return 0;

    int total = 0;
    int done = 0;
    DateTime cursor = from;
    while (!cursor.isAfter(to)) {
      total++;
      if (isCompletedOn(cursor)) done++;
      cursor = cursor.add(const Duration(days: 1));
    }
    if (total == 0) return 0;
    return (done / total) * 100;
  }

  /// Days where completion is explicitly set to false (for day-change dialog)
  List<DateTime> missedDaysFor(DateTime date) {
    final key = _dateKey(date);
    // completionLog has that date with false or not present → missed
    if (completionLog[key] == true) return [];
    return [date];
  }
}
