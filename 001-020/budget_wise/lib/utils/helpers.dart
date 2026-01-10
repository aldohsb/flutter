import 'package:intl/intl.dart';

class Helpers {
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
  
  static String formatDateShort(DateTime date) {
    return DateFormat('dd/MM').format(date);
  }
  
  static String formatMonth(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }
  
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
  
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }
  
  static List<DateTime> getDaysInMonth(DateTime date) {
    final firstDay = getFirstDayOfMonth(date);
    final lastDay = getLastDayOfMonth(date);
    final days = <DateTime>[];
    
    for (var i = 0; i <= lastDay.day - 1; i++) {
      days.add(firstDay.add(Duration(days: i)));
    }
    
    return days;
  }
}