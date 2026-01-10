import 'package:intl/intl.dart';
import 'constants.dart';

class Helpers {
  // Format currency
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: AppConstants.currency,
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  
  // Format date
  static String formatDate(DateTime date) {
    return DateFormat(AppConstants.dateFormat, 'id_ID').format(date);
  }
  
  // Format month year
  static String formatMonthYear(DateTime date) {
    return DateFormat(AppConstants.monthYearFormat, 'id_ID').format(date);
  }
  
  // Get first day of month
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  // Get last day of month
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }
  
  // Get month name
  static String getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
  
  // Calculate percentage
  static double calculatePercentage(double value, double total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }
  
  // Validate amount
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nominal harus diisi';
    }
    
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Nominal harus lebih dari 0';
    }
    
    return null;
  }
  
  // Validate description
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Keterangan harus diisi';
    }
    
    if (value.length < 3) {
      return 'Keterangan minimal 3 karakter';
    }
    
    return null;
  }
}