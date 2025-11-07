// File ini berisi fungsi-fungsi helper untuk mengolah tanggal
// Helper = fungsi pembantu yang mempermudah pekerjaan kita

import 'package:intl/intl.dart';

// Kelas untuk fungsi-fungsi utilitas tanggal
class DateHelper {
  // Format tanggal menjadi string yang mudah dibaca
  // Contoh: "08 Nov 2025"
  static String formatDate(DateTime date) {
    // DateFormat dari package intl untuk format tanggal
    // 'dd MMM yyyy' = format: tanggal bulan tahun
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Format tanggal dan waktu lengkap
  // Contoh: "08 Nov 2025, 09:30"
  static String formatDateTime(DateTime dateTime) {
    // 'dd MMM yyyy, HH:mm' = format: tanggal bulan tahun, jam:menit
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  // Format hanya waktu
  // Contoh: "09:30"
  static String formatTime(DateTime time) {
    // 'HH:mm' = format 24 jam: jam:menit
    return DateFormat('HH:mm').format(time);
  }

  // Cek apakah tanggal adalah hari ini
  static bool isToday(DateTime date) {
    final now = DateTime.now(); // Tanggal dan waktu sekarang
    // Bandingkan tahun, bulan, dan tanggal
    // Jika sama semua = hari ini
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Cek apakah tanggal sudah lewat (overdue)
  static bool isOverdue(DateTime date) {
    final now = DateTime.now();
    // Jika tanggal task lebih kecil dari hari ini = sudah lewat
    return date.isBefore(DateTime(now.year, now.month, now.day));
  }

  // Cek apakah tanggal besok
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  // Mendapatkan string deskriptif untuk tanggal
  // Contoh: "Today", "Tomorrow", atau "08 Nov 2025"
  static String getDateDescription(DateTime date) {
    if (isToday(date)) {
      return 'Today'; // Hari ini
    } else if (isTomorrow(date)) {
      return 'Tomorrow'; // Besok
    } else if (isOverdue(date)) {
      return 'Overdue'; // Terlambat
    } else {
      return formatDate(date); // Tanggal normal
    }
  }

  // Mendapatkan sisa hari dari sekarang
  static int getDaysRemaining(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(DateTime(now.year, now.month, now.day));
    // difference.inDays = selisih dalam jumlah hari
    return difference.inDays;
  }
}