import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool isCompletedToday;

  @HiveField(3)
  int streak;

  @HiveField(4)
  List<DateTime> completionHistory;

  @HiveField(5)
  DateTime lastCompletedDate;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime startDate; // tanggal mulai hitung persentase

  @HiveField(8)
  int sortOrder;

  Habit({
    required this.id,
    required this.name,
    this.isCompletedToday = false,
    this.streak = 0,
    List<DateTime>? completionHistory,
    DateTime? lastCompletedDate,
    DateTime? createdAt,
    DateTime? startDate,
    this.sortOrder = 0,
  })  : completionHistory = completionHistory ?? [],
        lastCompletedDate = lastCompletedDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        startDate = startDate ?? DateTime.now();

  /// Persentase completion sejak startDate sampai hari ini
  double getCompletionPercentage() {
    final today = DateTime.now();
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(today.year, today.month, today.day);
    final totalDays = end.difference(start).inDays + 1;
    if (totalDays <= 0) return 0;

    final completed = completionHistory.where((date) {
      final d = DateTime(date.year, date.month, date.day);
      return !d.isBefore(start) && !d.isAfter(end);
    }).length;

    return (completed / totalDays) * 100;
  }

  double getMonthlyPercentage(int year, int month) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final completed = completionHistory.where((date) {
      return date.year == year && date.month == month;
    }).length;
    return (completed / daysInMonth) * 100;
  }

  void toggleCompletion() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    if (isCompletedToday) {
      isCompletedToday = false;
      completionHistory.removeWhere((date) =>
          date.year == todayDate.year &&
          date.month == todayDate.month &&
          date.day == todayDate.day);
      updateStreak();
    } else {
      isCompletedToday = true;
      final exists = completionHistory.any((date) =>
          date.year == todayDate.year &&
          date.month == todayDate.month &&
          date.day == todayDate.day);
      if (!exists) {
        completionHistory.add(todayDate);
      }
      lastCompletedDate = todayDate;
      updateStreak();
    }
  }

  /// Tambah completion untuk tanggal tertentu (untuk konfirmasi hari kemarin)
  void addCompletionForDate(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    final exists = completionHistory.any((dt) =>
        dt.year == d.year && dt.month == d.month && dt.day == d.day);
    if (!exists) {
      completionHistory.add(d);
    }
    updateStreak();
  }

  /// Hapus completion untuk tanggal tertentu
  void removeCompletionForDate(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    completionHistory.removeWhere(
        (dt) => dt.year == d.year && dt.month == d.month && dt.day == d.day);
    updateStreak();
  }

  bool isCompletedOnDate(DateTime date) {
    return completionHistory.any((dt) =>
        dt.year == date.year && dt.month == date.month && dt.day == date.day);
  }

  void updateStreak() {
    if (completionHistory.isEmpty) {
      streak = 0;
      return;
    }

    final sorted = List<DateTime>.from(completionHistory)
      ..sort((a, b) => b.compareTo(a));

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastDate = DateTime(sorted.first.year, sorted.first.month, sorted.first.day);
    final daysDiff = todayDate.difference(lastDate).inDays;

    if (daysDiff > 1) {
      streak = 0;
      return;
    }

    int currentStreak = 1;
    for (int i = 0; i < sorted.length - 1; i++) {
      final current = DateTime(sorted[i].year, sorted[i].month, sorted[i].day);
      final next = DateTime(sorted[i + 1].year, sorted[i + 1].month, sorted[i + 1].day);
      if (current.difference(next).inDays == 1) {
        currentStreak++;
      } else {
        break;
      }
    }
    streak = currentStreak;
  }

  void checkAndResetDaily() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastDate = DateTime(
      lastCompletedDate.year,
      lastCompletedDate.month,
      lastCompletedDate.day,
    );
    if (todayDate.isAfter(lastDate) && isCompletedToday) {
      isCompletedToday = false;
    }
  }
}
