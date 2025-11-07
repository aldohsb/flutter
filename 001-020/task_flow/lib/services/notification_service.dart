// File ini mengelola local notifications untuk reminder tasks
// Service untuk membuat dan mengatur notifikasi lokal

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task_model.dart';

// Kelas untuk mengelola notifikasi
class NotificationService {
  // Singleton pattern seperti di HiveService
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Instance plugin untuk local notifications
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Flag untuk cek apakah sudah diinisialisasi
  bool _isInitialized = false;

  // Inisialisasi notification service
  Future<void> init() async {
    if (_isInitialized) return; // Jika sudah init, skip

    // Inisialisasi timezone untuk scheduling
    // Timezone perlu untuk jadwal notifikasi
    tz.initializeTimeZones();

    // Settings untuk Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    // @mipmap/ic_launcher = icon aplikasi default

    // Settings untuk iOS/macOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,  // Minta izin tampil alert
      requestBadgePermission: true,  // Minta izin badge (angka di icon app)
      requestSoundPermission: true,  // Minta izin suara
    );

    // Gabungkan settings untuk semua platform
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: iosSettings,
    );

    // Inisialisasi plugin dengan settings
    await _notifications.initialize(
      initSettings,
      // Callback saat notifikasi diklik (opsional)
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Di sini bisa tambahkan logic navigasi ke detail task
        // Untuk tutorial sederhana, kita skip dulu
      },
    );

    _isInitialized = true;
  }

  // Schedule notifikasi untuk task tertentu
  Future<void> scheduleTaskReminder(Task task) async {
    // Pastikan sudah diinisialisasi
    if (!_isInitialized) await init();

    // Konversi deadline task ke timezone
    final scheduledDate = tz.TZDateTime.from(task.deadline, tz.local);

    // Cek apakah waktu sudah lewat
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      // Jika sudah lewat, jangan schedule notifikasi
      return;
    }

    // Detail notifikasi untuk Android
    const androidDetails = AndroidNotificationDetails(
      'task_reminders',           // Channel ID
      'Task Reminders',           // Channel name
      channelDescription: 'Reminders for your tasks', // Deskripsi channel
      importance: Importance.high, // Tingkat kepentingan
      priority: Priority.high,     // Prioritas
      icon: '@mipmap/ic_launcher', // Icon notifikasi
    );

    // Detail notifikasi untuk iOS/macOS
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,  // Tampilkan alert
      presentBadge: true,  // Tampilkan badge
      presentSound: true,  // Mainkan suara
    );

    // Gabungkan details untuk semua platform
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    // Schedule notifikasi
    // zonedSchedule = jadwal berdasarkan timezone
    await _notifications.zonedSchedule(
      task.id.hashCode,              // ID notifikasi (harus unik, pakai hash dari task.id)
      'Task Reminder',               // Judul notifikasi
      '${task.title} - ${task.priority} priority', // Body notifikasi
      scheduledDate,                 // Waktu notifikasi
      notificationDetails,           // Details yang sudah dibuat tadi
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // exactAllowWhileIdle = notifikasi tetap muncul meski device sleep
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // absoluteTime = waktu absolut (bukan relative)
    );
  }

  // Cancel notifikasi untuk task tertentu
  Future<void> cancelTaskReminder(String taskId) async {
    // cancel() = batalkan notifikasi berdasarkan ID
    await _notifications.cancel(taskId.hashCode);
  }

  // Cancel semua notifikasi
  Future<void> cancelAllReminders() async {
    // cancelAll() = batalkan semua notifikasi yang terjadwal
    await _notifications.cancelAll();
  }

  // Show notifikasi instant (tanpa schedule)
  // Berguna untuk testing atau notifikasi langsung
  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    if (!_isInitialized) await init();

    const androidDetails = AndroidNotificationDetails(
      'instant_notifications',
      'Instant Notifications',
      channelDescription: 'Instant task notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    // show() = tampilkan notifikasi langsung
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000), // ID random
      title,
      body,
      notificationDetails,
    );
  }

  // Request permission untuk iOS
  // Di Android, permission otomatis granted
  Future<bool> requestPermissions() async {
    if (!_isInitialized) await init();

    // Request permission khusus untuk iOS/macOS
    final iosImplementation =
        _notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    final macOSImplementation =
        _notifications.resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>();

    if (iosImplementation != null) {
      return await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      ) ?? false;
    }

    if (macOSImplementation != null) {
      return await macOSImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      ) ?? false;
    }

    // Untuk Android dan platform lain, return true
    return true;
  }
}