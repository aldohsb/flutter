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

  Habit({
    required this.id,
    required this.name,
    this.isCompletedToday = false,
    this.streak = 0,
    List<DateTime>? completionHistory,
    DateTime? lastCompletedDate,
    DateTime? createdAt,
  })  : completionHistory = completionHistory ?? [],
        lastCompletedDate = lastCompletedDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  double getMonthlyPercentage(int year, int month) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final completedDaysInMonth = completionHistory.where((date) {
      return date.year == year && date.month == month;
    }).length;
    
    return (completedDaysInMonth / daysInMonth) * 100;
  }

  void toggleCompletion() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    if (isCompletedToday) {
      isCompletedToday = false;
      completionHistory.removeWhere((date) => 
        date.year == todayDate.year && 
        date.month == todayDate.month && 
        date.day == todayDate.day
      );
      updateStreak();
    } else {
      isCompletedToday = true;
      // Check if today already exists in history
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

  void updateStreak() {
    if (completionHistory.isEmpty) {
      streak = 0;
      return;
    }

    final sortedHistory = List<DateTime>.from(completionHistory)
      ..sort((a, b) => b.compareTo(a));

    int currentStreak = 1;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    final lastDate = sortedHistory.first;
    final daysDifference = todayDate.difference(lastDate).inDays;
    
    if (daysDifference > 1) {
      streak = 0;
      return;
    }

    for (int i = 0; i < sortedHistory.length - 1; i++) {
      final current = sortedHistory[i];
      final next = sortedHistory[i + 1];
      final diff = current.difference(next).inDays;
      
      if (diff == 1) {
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