// Service untuk mengelola notifikasi lokal
// Service adalah class yang menyediakan fungsionalitas khusus

import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../utils/constants.dart';

// Singleton class - hanya ada 1 instance di seluruh aplikasi
class NotificationService {
  // === SINGLETON PATTERN (FIXED) ===
  
  // Private constructor HARUS di atas
  NotificationService._();
  
  // Static instance menggunakan getter untuk lazy initialization
  static NotificationService? _instance;
  
  // Factory constructor yang return instance
  factory NotificationService() {
    _instance ??= NotificationService._();
    return _instance!;
  }
  
  // Getter untuk akses instance
  static NotificationService get instance {
    _instance ??= NotificationService._();
    return _instance!;
  }

  // === PROPERTIES ===
  
  // Plugin untuk handle notifikasi lokal
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  
  // Flag untuk track apakah sudah diinisialisasi
  bool _initialized = false;

  // === INITIALIZATION ===
  
  // Method async untuk inisialisasi service
  Future<void> initialize() async {
    // Cek apakah sudah diinisialisasi
    if (_initialized) return;

    try {
      // Inisialisasi timezone database
      tz.initializeTimeZones();
      
      // Set timezone lokal
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } catch (e) {
        // Fallback ke UTC jika timezone tidak ditemukan
        print('Timezone Jakarta not found, using UTC: $e');
      }

      // === ANDROID SETTINGS ===
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      
      // === IOS SETTINGS ===
      const iosSettings = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      // === GENERAL SETTINGS ===
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize plugin
      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // === CREATE ANDROID NOTIFICATION CHANNEL ===
      const androidChannel = AndroidNotificationChannel(
        AppConstants.notificationChannelId,
        AppConstants.notificationChannelName,
        description: AppConstants.notificationChannelDescription,
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
      );

      // Create channel di Android
      await _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);

      _initialized = true;
      print('NotificationService initialized successfully');
    } catch (e) {
      print('Error initializing NotificationService: $e');
      _initialized = false;
    }
  }

  // === CALLBACK HANDLERS ===
  
  void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    print('Notification tapped with payload: $payload');
  }

  // === NOTIFICATION METHODS ===
  
  Future<void> showInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) {
      print('NotificationService not initialized, skipping notification');
      return;
    }

    try {
      const androidDetails = AndroidNotificationDetails(
        AppConstants.notificationChannelId,
        AppConstants.notificationChannelName,
        channelDescription: AppConstants.notificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final id = Random().nextInt(100000);

      await _notifications.show(
        id,
        title,
        body,
        details,
        payload: payload,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    if (!_initialized) return;

    try {
      final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

      const androidDetails = AndroidNotificationDetails(
        AppConstants.notificationChannelId,
        AppConstants.notificationChannelName,
        channelDescription: AppConstants.notificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tzScheduledTime,
        details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  Future<void> schedulePeriodicReminders({
    required int intervalMinutes,
    int startHour = 7,
    int endHour = 22,
  }) async {
    if (!_initialized) return;

    try {
      await cancelAllNotifications();

      final workingHours = endHour - startHour;
      final reminderCount = (workingHours * 60) ~/ intervalMinutes;
      
      final now = DateTime.now();
      
      for (int i = 0; i < reminderCount; i++) {
        final reminderTime = DateTime(
          now.year,
          now.month,
          now.day,
          startHour,
          0,
        ).add(Duration(minutes: intervalMinutes * i));

        if (reminderTime.isBefore(now)) {
          final tomorrowTime = reminderTime.add(const Duration(days: 1));
          await _scheduleReminder(i, tomorrowTime);
        } else {
          await _scheduleReminder(i, reminderTime);
        }
      }
    } catch (e) {
      print('Error scheduling periodic reminders: $e');
    }
  }

  Future<void> _scheduleReminder(int index, DateTime time) async {
    const messages = AppConstants.reminderMessages;
    final randomMessage = messages[Random().nextInt(messages.length)];

    await scheduleNotification(
      id: 1000 + index,
      title: 'Water Reminder',
      body: randomMessage,
      scheduledTime: time,
      payload: 'water_reminder_$index',
    );
  }

  // === CANCEL METHODS ===
  
  Future<void> cancelNotification(int id) async {
    try {
      await _notifications.cancel(id);
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _notifications.cancelAll();
    } catch (e) {
      print('Error canceling all notifications: $e');
    }
  }

  // === PERMISSION METHODS ===
  
  Future<bool> requestPermissions() async {
    if (!_initialized) await initialize();

    try {
      final androidImpl = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidImpl != null) {
        final granted = await androidImpl.requestNotificationsPermission();
        return granted ?? false;
      }

      final iosImpl = _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      
      if (iosImpl != null) {
        final granted = await iosImpl.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }

      return true;
    } catch (e) {
      print('Error requesting permissions: $e');
      return false;
    }
  }
}