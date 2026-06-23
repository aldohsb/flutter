// ============================================================
// lib/utils/date_formatter.dart
// Helper formatting tanggal dan waktu untuk Moodly
//
// KONSEP: Utility / Helper Class
// Fungsi-fungsi kecil yang dipakai di banyak tempat dikumpulkan
// di satu file agar tidak duplikasi kode.
// Semua method static: bisa dipanggil tanpa buat objek.
//
// Contoh penggunaan:
//   DateFormatter.formatFull(entry.date)  → "Senin, 18 Juni 2026"
//   DateFormatter.formatShort(entry.date) → "18 Jun"
// ============================================================

// intl menyediakan DateFormat untuk formatting tanggal internasional
import 'package:intl/intl.dart';
import 'mood_constants.dart'; // Untuk monthNames dan shortDayNames

abstract class DateFormatter {

  // ============================================================
  // FORMAT PENUH – dipakai di header halaman atau kartu detail
  // Contoh output: "Senin, 18 Juni 2026"
  // ============================================================
  static String formatFull(DateTime date) {
    // intl DateFormat menggunakan kode format mirip Java
    // EEEE = nama hari penuh, d = tanggal, MMMM = nama bulan penuh, y = tahun
    // 'id' = locale Indonesia (format dan nama dalam Bahasa Indonesia)
    final formatter = DateFormat('EEEE, d MMMM yyyy', 'id');
    return formatter.format(date);
  }

  // ============================================================
  // FORMAT MEDIUM – dipakai di list item riwayat mood
  // Contoh output: "Senin, 18 Jun"
  // ============================================================
  static String formatMedium(DateTime date) {
    final formatter = DateFormat('EEEE, d MMM', 'id');
    return formatter.format(date);
  }

  // ============================================================
  // FORMAT PENDEK – dipakai di label chart atau badge
  // Contoh output: "18 Jun"
  // ============================================================
  static String formatShort(DateTime date) {
    final formatter = DateFormat('d MMM', 'id');
    return formatter.format(date);
  }

  // ============================================================
  // FORMAT WAKTU SAJA – dipakai di detail entri mood
  // Contoh output: "10:30"
  // ============================================================
  static String formatTime(DateTime date) {
    // HH = jam 24 format (00-23), mm = menit (00-59)
    final formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }

  // ============================================================
  // FORMAT RELATIVE – "Hari ini", "Kemarin", atau tanggal lengkap
  // Lebih ramah pengguna dibanding tanggal numerik
  // ============================================================
  static String formatRelative(DateTime date) {
    final now = DateTime.now();

    // Bandingkan hanya tanggal (abaikan waktu)
    // Buat DateTime dari year/month/day saja untuk perbandingan bersih
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(date.year, date.month, date.day);

    // difference().inDays = selisih hari antara dua tanggal
    final diffDays = today.difference(entryDate).inDays;

    if (diffDays == 0) return 'Hari ini';
    if (diffDays == 1) return 'Kemarin';
    if (diffDays < 7) return '$diffDays hari lalu';

    // Lebih dari seminggu: tampilkan tanggal lengkap
    return formatMedium(date);
  }

  // ============================================================
  // FORMAT NAMA HARI PENDEK – untuk sumbu X chart
  // Menggunakan konstanta dari MoodConstants
  // Contoh output: "Sen" (untuk Senin)
  // ============================================================
  static String formatShortDay(DateTime date) {
    // weekday: 1=Senin, 2=Selasa, ..., 7=Minggu
    // Kita index dari 0, jadi -1
    return MoodConstants.shortDayNames[date.weekday - 1];
  }

  // ============================================================
  // FORMAT BULAN DAN TAHUN – untuk header grup bulan di history
  // Contoh output: "Juni 2026"
  // ============================================================
  static String formatMonthYear(DateTime date) {
    // date.month: 1-12, array index 0-11, jadi -1
    final monthName = MoodConstants.monthNames[date.month - 1];
    return '$monthName ${date.year}';
  }

  // ============================================================
  // IS SAME DAY – mengecek apakah dua DateTime di hari yang sama
  // Berguna untuk logika "sudah catat mood hari ini?"
  // ============================================================
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // ============================================================
  // GET WEEK START – mendapatkan tanggal awal minggu (Senin)
  // dari suatu tanggal. Dipakai untuk grouping chart mingguan.
  // ============================================================
  static DateTime getWeekStart(DateTime date) {
    // weekday: Senin=1, Selasa=2, ..., Minggu=7
    // subtract(days: weekday - 1) → mundur ke hari Senin
    return DateTime(
      date.year,
      date.month,
      date.day - (date.weekday - 1),
    );
  }

  // ============================================================
  // FORMAT DURATION – berapa lama sejak entri dibuat
  // Lebih detail dari formatRelative, termasuk jam
  // Contoh: "3 jam lalu", "5 menit lalu", "Baru saja"
  // ============================================================
  static String formatDuration(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays == 1) return 'Kemarin';

    return formatRelative(date);
  }
}