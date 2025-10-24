import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zentime/models/session_model.dart';
import 'package:zentime/services/hive_service.dart';
import 'package:zentime/services/notification_service.dart';
import 'package:zentime/services/audio_service.dart';
import 'package:zentime/utils/constants.dart';
import 'package:zentime/utils/time_formatter.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  SessionModel? _activeSession;
  int _elapsedSeconds = 0;
  int _lastAlarmMinute = 0;
  
  final NotificationService _notificationService = NotificationService();
  final AudioService _audioService = AudioService();
  
  bool _isInitialized = false;
  
  SessionModel? get activeSession => _activeSession;
  int get elapsedSeconds => _elapsedSeconds;
  bool get isRunning => _activeSession?.isRunning ?? false;
  
  TimerProvider() {
    _initialize();
  }
  
  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    try {
      await _notificationService.initialize();
      _initializeActiveSession();
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing timer provider: $e');
    }
  }
  
  void _initializeActiveSession() {
    try {
      final sessions = HiveService.getAllSessions();
      _activeSession = sessions.where((s) => s.isRunning).firstOrNull;
      
      if (_activeSession != null) {
        final now = DateTime.now();
        final elapsed = now.difference(_activeSession!.startTime).inSeconds;
        _elapsedSeconds = elapsed;
        _lastAlarmMinute = (elapsed ~/ 60) ~/ AppConstants.alarmIntervalMinutes;
        _startTimer();
      }
    } catch (e) {
      debugPrint('Error initializing active session: $e');
    }
  }
  
  Future<void> startTimer(String projectId, String projectName) async {
    try {
      if (_activeSession != null) {
        await stopTimer();
      }
      
      final session = SessionModel(
        id: const Uuid().v4(),
        projectId: projectId,
        startTime: DateTime.now(),
        durationSeconds: 0,
        isRunning: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await HiveService.addSession(session);
      _activeSession = session;
      _elapsedSeconds = 0;
      _lastAlarmMinute = 0;
      
      _startTimer();
      
      try {
        await _notificationService.showTimerNotification(
          projectName: projectName,
          duration: TimeFormatter.formatDuration(_elapsedSeconds),
        );
      } catch (e) {
        debugPrint('Notification error: $e');
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error starting timer: $e');
    }
  }
  
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      
      if (_activeSession != null) {
        try {
          final updatedSession = _activeSession!.copyWith(
            durationSeconds: _elapsedSeconds,
            updatedAt: DateTime.now(),
          );
          HiveService.updateSession(updatedSession);
          _activeSession = updatedSession;
        } catch (e) {
          debugPrint('Error updating session: $e');
        }
      }
      
      _checkAlarm();
      notifyListeners();
    });
  }
  
  void _checkAlarm() {
    final currentMinute = _elapsedSeconds ~/ 60;
    final alarmMinute = currentMinute ~/ AppConstants.alarmIntervalMinutes;
    
    if (alarmMinute > _lastAlarmMinute && currentMinute % AppConstants.alarmIntervalMinutes == 0) {
      _lastAlarmMinute = alarmMinute;
      _triggerAlarm(currentMinute);
    }
  }
  
  Future<void> _triggerAlarm(int minutes) async {
    try {
      await _audioService.playAlarmSound();
      
      if (_activeSession != null) {
        final project = HiveService.getProject(_activeSession!.projectId);
        if (project != null) {
          try {
            await _notificationService.showAlarmNotification(
              projectName: project.name,
              minutes: minutes,
            );
          } catch (e) {
            debugPrint('Alarm notification error: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error triggering alarm: $e');
    }
  }
  
  Future<void> stopTimer() async {
    if (_activeSession == null) return;
    
    try {
      _timer?.cancel();
      _timer = null;
      
      final updatedSession = _activeSession!.copyWith(
        endTime: DateTime.now(),
        durationSeconds: _elapsedSeconds,
        isRunning: false,
        updatedAt: DateTime.now(),
      );
      
      await HiveService.updateSession(updatedSession);
      
      try {
        if (_isInitialized) {
          await _notificationService.cancelTimerNotification();
        }
      } catch (e) {
        debugPrint('Error canceling notification: $e');
      }
      
      _activeSession = null;
      _elapsedSeconds = 0;
      _lastAlarmMinute = 0;
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping timer: $e');
    }
  }
  
  Future<void> pauseTimer() async {
    if (_activeSession == null || !_activeSession!.isRunning) return;
    
    try {
      _timer?.cancel();
      _timer = null;
      
      final updatedSession = _activeSession!.copyWith(
        isRunning: false,
        durationSeconds: _elapsedSeconds,
        updatedAt: DateTime.now(),
      );
      
      await HiveService.updateSession(updatedSession);
      
      try {
        if (_isInitialized) {
          await _notificationService.cancelTimerNotification();
        }
      } catch (e) {
        debugPrint('Error canceling notification: $e');
      }
      
      _activeSession = updatedSession;
      notifyListeners();
    } catch (e) {
      debugPrint('Error pausing timer: $e');
    }
  }
  
  Future<void> resumeTimer(String projectName) async {
    if (_activeSession == null || _activeSession!.isRunning) return;
    
    try {
      final updatedSession = _activeSession!.copyWith(
        isRunning: true,
        startTime: DateTime.now().subtract(Duration(seconds: _elapsedSeconds)),
        updatedAt: DateTime.now(),
      );
      
      await HiveService.updateSession(updatedSession);
      _activeSession = updatedSession;
      
      _startTimer();
      
      try {
        await _notificationService.showTimerNotification(
          projectName: projectName,
          duration: TimeFormatter.formatDuration(_elapsedSeconds),
        );
      } catch (e) {
        debugPrint('Notification error: $e');
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error resuming timer: $e');
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _audioService.dispose();
    super.dispose();
  }
}