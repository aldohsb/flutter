import 'package:flutter/foundation.dart';
import '../models/notification_setting_model.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../utils/constants.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationSettingModel> _settings = [];
  bool _isLoading = false;
  String? _error;
  bool _notificationsEnabled = false;

  List<NotificationSettingModel> get settings => _settings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> initialize(int userId) async {
    await NotificationService.instance.initialize();
    await loadSettings(userId);
    await _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    _notificationsEnabled = await NotificationService.instance.requestPermissions();
    notifyListeners();
  }

  Future<void> loadSettings(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _settings = await DatabaseService.instance.getNotificationSettings(userId);
      
      // If no settings exist, create default ones
      if (_settings.isEmpty) {
        await _createDefaultSettings(userId);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _createDefaultSettings(int userId) async {
    for (final time in AppConstants.defaultNotificationTimes) {
      final setting = NotificationSettingModel(
        userId: userId,
        time: time,
        isEnabled: true,
      );
      
      final id = await DatabaseService.instance.insertNotificationSetting(setting);
      _settings.add(setting.copyWith(id: id));
    }
    
    await _scheduleNotifications();
  }

  Future<bool> addSetting(NotificationSettingModel setting) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final id = await DatabaseService.instance.insertNotificationSetting(setting);
      _settings.add(setting.copyWith(id: id));
      await _scheduleNotifications();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSetting(NotificationSettingModel setting) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await DatabaseService.instance.updateNotificationSetting(setting);
      final index = _settings.indexWhere((s) => s.id == setting.id);
      if (index != -1) {
        _settings[index] = setting;
      }
      await _scheduleNotifications();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleSetting(int id) async {
    final setting = _settings.firstWhere((s) => s.id == id);
    final updated = setting.copyWith(isEnabled: !setting.isEnabled);
    return await updateSetting(updated);
  }

  Future<bool> deleteSetting(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await DatabaseService.instance.deleteNotificationSetting(id);
      _settings.removeWhere((s) => s.id == id);
      await _scheduleNotifications();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _scheduleNotifications() async {
    await NotificationService.instance.scheduleNotifications(_settings);
  }

  Future<void> testNotification() async {
    await NotificationService.instance.showInstantNotification(
      AppConstants.appName,
      'Ini adalah notifikasi test. Semangat diet keto! 💪',
    );
  }

  Future<int> getPendingNotificationsCount() async {
    final pending = await NotificationService.instance.getPendingNotifications();
    return pending.length;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}