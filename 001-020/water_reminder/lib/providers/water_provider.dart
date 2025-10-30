// Provider untuk mengelola state aplikasi
// Provider adalah state management yang mudah digunakan

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/water_intake.dart';
import '../models/hydration_goal.dart';
import '../services/notification_service.dart';
import '../utils/constants.dart';

// ChangeNotifier adalah class yang bisa notify listeners saat ada perubahan
class WaterProvider extends ChangeNotifier {
  // === PROPERTIES ===
  
  // Hive boxes untuk storage
  late Box<WaterIntake> _intakeBox;
  late Box<HydrationGoal> _goalsBox;
  
  // SharedPreferences untuk settings
  late SharedPreferences _prefs;
  
  // Notification service
  final NotificationService _notificationService = NotificationService();
  
  // Data yang di-track
  int _dailyGoalMl = AppConstants.defaultDailyGoalMl;
  int _glassSize = AppConstants.defaultGlassSize;
  bool _notificationsEnabled = true;
  String _userName = 'User';
  
  // List untuk cache data
  List<WaterIntake> _todayIntakes = [];
  List<HydrationGoal> _goals = [];
  
  // Loading state
  bool _isLoading = true;

  // === GETTERS ===
  // Getters untuk expose data (read-only dari luar)
  
  int get dailyGoalMl => _dailyGoalMl;
  int get glassSize => _glassSize;
  bool get notificationsEnabled => _notificationsEnabled;
  String get userName => _userName;
  List<WaterIntake> get todayIntakes => _todayIntakes;
  List<HydrationGoal> get goals => _goals;
  bool get isLoading => _isLoading;
  
  // Computed getters - nilai yang dihitung dari data lain
  
  // Total intake hari ini
  int get todayTotalMl {
    return _todayIntakes.fold<int>(
      0, // initial value
      // fold mirip reduce: gabungkan semua element jadi satu nilai
      (sum, intake) => sum + intake.amountMl,
    );
  }
  
  // Persentase progress hari ini
  double get todayProgressPercentage {
    if (_dailyGoalMl == 0) return 0;
    final percentage = (todayTotalMl / _dailyGoalMl) * 100;
    // Clamp ke max 100%
    return percentage > 100 ? 100 : percentage;
  }
  
  // Sisa yang perlu diminum
  int get remainingMl {
    final remaining = _dailyGoalMl - todayTotalMl;
    return remaining > 0 ? remaining : 0;
  }
  
  // Apakah goal hari ini sudah tercapai
  bool get isTodayGoalReached {
    return todayTotalMl >= _dailyGoalMl;
  }
  
  // Total poin dari semua completed goals
  int get totalPoints {
    return _goals.where((g) => g.isCompleted).fold<int>(
      0,
      (sum, goal) => sum + goal.points,
    );
  }

  // === INITIALIZATION ===
  
  // Method untuk initialize provider
  Future<void> initialize() async {
    try {
      // Set loading
      _isLoading = true;
      notifyListeners(); // Beritahu UI bahwa state berubah

      // Initialize Hive
      await Hive.initFlutter();
      
      // Register adapters (TypeAdapter untuk custom objects)
      // Adapter ini di-generate oleh hive_generator
      Hive.registerAdapter(WaterIntakeAdapter());
      Hive.registerAdapter(HydrationGoalAdapter());

      // Open boxes
      _intakeBox = await Hive.openBox<WaterIntake>(
        AppConstants.intakeBoxName,
      );
      _goalsBox = await Hive.openBox<HydrationGoal>(
        AppConstants.goalsBoxName,
      );

      // Initialize SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      
      // Load settings
      await _loadSettings();
      
      // Load data
      await _loadTodayIntakes();
      await _loadGoals();
      
      // Initialize notifications
      try {
        await _notificationService.initialize();
        
        // Setup reminders if enabled
        if (_notificationsEnabled) {
          await _setupReminders();
        }
      } catch (e) {
        // Log error tapi jangan throw - notifikasi optional
        debugPrint('Error initializing notifications: $e');
        // Disable notifications jika gagal
        _notificationsEnabled = false;
      }

      // Done loading
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Error handling
      debugPrint('Error initializing WaterProvider: $e');
      _isLoading = false;
      notifyListeners();
      rethrow; // Lempar error ke atas agar bisa di-handle di UI
    }
  }

  // === PRIVATE HELPER METHODS ===
  
  // Load settings dari SharedPreferences
  Future<void> _loadSettings() async {
    _dailyGoalMl = _prefs.getInt(AppConstants.keyDailyGoal) ?? 
        AppConstants.defaultDailyGoalMl;
    _glassSize = _prefs.getInt(AppConstants.keyGlassSize) ?? 
        AppConstants.defaultGlassSize;
    _notificationsEnabled = _prefs.getBool(AppConstants.keyNotificationEnabled) ?? 
        true;
    _userName = _prefs.getString(AppConstants.keyUserName) ?? 'User';
  }

  // Load intake hari ini
  Future<void> _loadTodayIntakes() async {
    // Get tanggal hari ini (jam 00:00)
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Filter intakes berdasarkan tanggal
    _todayIntakes = _intakeBox.values.where((intake) {
      return intake.timestamp.isAfter(startOfDay) && 
             intake.timestamp.isBefore(endOfDay);
    }).toList();

    // Sort by timestamp (terbaru di atas)
    _todayIntakes.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Load goals
  Future<void> _loadGoals() async {
    _goals = _goalsBox.values.toList();
    
    // Jika goals masih kosong, create default goals
    if (_goals.isEmpty) {
      await _createDefaultGoals();
    }
  }

  // Create default goals dari constants
  Future<void> _createDefaultGoals() async {
    for (final goalData in AppConstants.availableGoals) {
      final goal = HydrationGoal.create(
        id: goalData['id'],
        title: goalData['title'],
        description: goalData['description'],
        icon: goalData['icon'],
        points: goalData['points'],
        target: goalData['target'],
      );
      
      await _goalsBox.put(goal.id, goal);
    }
    
    // Reload goals
    await _loadGoals();
  }

  // Setup reminder notifications
  Future<void> _setupReminders() async {
    await _notificationService.schedulePeriodicReminders(
      intervalMinutes: AppConstants.defaultReminderInterval,
      startHour: AppConstants.reminderStartHour,
      endHour: AppConstants.reminderEndHour,
    );
  }

  // === PUBLIC METHODS ===
  
  // Add water intake
  Future<void> addWaterIntake(int amountMl, {String? note}) async {
    try {
      // Create intake object
      final intake = WaterIntake.create(
        amountMl: amountMl,
        note: note,
      );

      // Save to Hive
      await _intakeBox.put(intake.id, intake);

      // Update local list
      _todayIntakes.insert(0, intake); // Insert di awal (terbaru)

      // Update goals progress
      await _updateGoalsProgress();

      // Notify listeners
      notifyListeners();

      // Show success notification (optional)
      if (_notificationsEnabled && isTodayGoalReached) {
        try {
          await _notificationService.showInstantNotification(
            title: 'Goal Reached! 🎉',
            body: 'You\'ve completed your daily hydration goal!',
          );
        } catch (e) {
          debugPrint('Error showing notification: $e');
        }
      }
    } catch (e) {
      debugPrint('Error adding water intake: $e');
      rethrow;
    }
  }

  // Delete water intake
  Future<void> deleteWaterIntake(String id) async {
    try {
      // Delete from Hive
      await _intakeBox.delete(id);

      // Update local list
      _todayIntakes.removeWhere((intake) => intake.id == id);

      // Update goals progress
      await _updateGoalsProgress();

      // Notify listeners
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting water intake: $e');
      rethrow;
    }
  }

  // Update settings
  Future<void> updateDailyGoal(int goalMl) async {
    _dailyGoalMl = goalMl;
    await _prefs.setInt(AppConstants.keyDailyGoal, goalMl);
    notifyListeners();
  }

  Future<void> updateGlassSize(int size) async {
    _glassSize = size;
    await _prefs.setInt(AppConstants.keyGlassSize, size);
    notifyListeners();
  }

  Future<void> updateNotificationEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await _prefs.setBool(AppConstants.keyNotificationEnabled, enabled);
    
    if (enabled) {
      await _setupReminders();
    } else {
      await _notificationService.cancelAllNotifications();
    }
    
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    _userName = name;
    await _prefs.setString(AppConstants.keyUserName, name);
    notifyListeners();
  }

  // Update goals progress berdasarkan intake
  Future<void> _updateGoalsProgress() async {
    // Cek apakah goal hari ini tercapai
    if (isTodayGoalReached) {
      // Update daily goal
      final dailyGoal = _goals.firstWhere(
        (g) => g.id == 'daily_goal',
        orElse: () => _goals.first,
      );
      
      if (!dailyGoal.isCompleted) {
        dailyGoal.incrementProgress();
      }
    }
    
    notifyListeners();
  }

  // Reset goal
  Future<void> resetGoal(String goalId) async {
    final goal = _goals.firstWhere((g) => g.id == goalId);
    goal.reset();
    notifyListeners();
  }

  // Get history untuk date range tertentu
  List<WaterIntake> getIntakesForDateRange(DateTime start, DateTime end) {
    return _intakeBox.values.where((intake) {
      return intake.timestamp.isAfter(start) && 
             intake.timestamp.isBefore(end);
    }).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get daily statistics untuk chart
  Map<DateTime, int> getDailyStatistics(int days) {
    final stats = <DateTime, int>{};
    final now = DateTime.now();
    
    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: i));
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final dayIntakes = _intakeBox.values.where((intake) {
        return intake.timestamp.isAfter(startOfDay) && 
               intake.timestamp.isBefore(endOfDay);
      });
      
      final total = dayIntakes.fold<int>(
        0,
        (sum, intake) => sum + intake.amountMl,
      );
      
      stats[startOfDay] = total;
    }
    
    return stats;
  }

  // Refresh data (untuk pull to refresh)
  Future<void> refresh() async {
    await _loadTodayIntakes();
    await _loadGoals();
    notifyListeners();
  }

  // Clean up
  @override
  void dispose() {
    // Close boxes saat provider di-dispose
    _intakeBox.close();
    _goalsBox.close();
    super.dispose();
  }
}