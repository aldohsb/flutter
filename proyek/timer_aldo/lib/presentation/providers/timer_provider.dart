import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/timer_session.dart';
import '../../data/repositories/timer_repository.dart';
import '../../core/utils/idle_detector.dart';
import '../../core/utils/shortcut_handler.dart';
import 'category_provider.dart';
import 'statistics_provider.dart';
import 'settings_provider.dart';

enum TimerState { stopped, running, paused, idlePaused }

class TimerProvider extends ChangeNotifier {
  final TimerRepository _repository;
  final CategoryProvider _categoryProvider;
  final StatisticsProvider _statisticsProvider;
  final SettingsProvider _settingsProvider;
  
  Timer? _timer;
  IdleDetector? _idleDetector;
  final ShortcutHandler _shortcutHandler = ShortcutHandler();
  
  TimerState _state = TimerState.stopped;
  int _elapsedSeconds = 0;
  int _pausedSeconds = 0;
  TimerSession? _currentSession;
  List<PauseRecord> _pauseRecords = [];
  DateTime? _pauseStartTime;
  
  TimerProvider(
    this._repository,
    this._categoryProvider,
    this._statisticsProvider,
    this._settingsProvider,
  ) {
    _initializeIdleDetector();
    _registerShortcuts();
  }
  
  // Getters
  TimerState get state => _state;
  int get elapsedSeconds => _elapsedSeconds;
  int get activeSeconds => _elapsedSeconds - _pausedSeconds;
  bool get isRunning => _state == TimerState.running;
  bool get isPaused => _state == TimerState.paused || _state == TimerState.idlePaused;
  bool get isStopped => _state == TimerState.stopped;
  
  String get formattedTime {
    final hours = _elapsedSeconds ~/ 3600;
    final minutes = (_elapsedSeconds % 3600) ~/ 60;
    final seconds = _elapsedSeconds % 60;
    
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  // Initialize idle detector
  void _initializeIdleDetector() {
    _idleDetector = IdleDetector(
      idleThresholdSeconds: _settingsProvider.idleThresholdSeconds,
      onIdleStateChanged: _handleIdleStateChange,
    );
  }
  
  // Register keyboard shortcuts
  Future<void> _registerShortcuts() async {
    await _shortcutHandler.registerPauseShortcut(
      shortcut: _settingsProvider.pauseHotkey,
      onPause: togglePause,
    );
    
    await _shortcutHandler.registerResetShortcut(
      shortcut: _settingsProvider.resetHotkey,
      onReset: reset,
    );
  }
  
  // Handle idle state changes
  void _handleIdleStateChange(bool isIdle) {
    if (isIdle && _state == TimerState.running) {
      _pauseFromIdle();
    } else if (!isIdle && _state == TimerState.idlePaused) {
      _resumeFromIdle();
    }
  }
  
  // Start timer
  void start() {
    if (_state != TimerState.stopped) return;
    
    final selectedCategory = _categoryProvider.selectedCategory;
    if (selectedCategory == null) return;
    
    _currentSession = TimerSession(
      categoryId: selectedCategory.id,
    );
    
    _state = TimerState.running;
    _elapsedSeconds = 0;
    _pausedSeconds = 0;
    _pauseRecords = [];
    
    _startTimer();
    _idleDetector?.start();
    
    notifyListeners();
  }
  
  // Start internal timer
  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _elapsedSeconds++;
        notifyListeners();
      },
    );
  }
  
  // Toggle pause/resume
  void togglePause() {
    if (_state == TimerState.running) {
      pause();
    } else if (_state == TimerState.paused) {
      resume();
    }
  }
  
  // Pause timer manually
  void pause() {
    if (_state != TimerState.running) return;
    
    _state = TimerState.paused;
    _timer?.cancel();
    _pauseStartTime = DateTime.now();
    
    notifyListeners();
  }
  
  // Resume timer manually
  void resume() {
    if (_state != TimerState.paused) return;
    
    _state = TimerState.running;
    
    if (_pauseStartTime != null) {
      final pauseDuration = DateTime.now().difference(_pauseStartTime!);
      _pausedSeconds += pauseDuration.inSeconds;
      
      _pauseRecords.add(PauseRecord(
        startTime: _pauseStartTime!,
        endTime: DateTime.now(),
        reason: 'manual',
      ));
      
      _pauseStartTime = null;
    }
    
    _startTimer();
    notifyListeners();
  }
  
  // Pause from idle detection
  void _pauseFromIdle() {
    if (_state != TimerState.running) return;
    
    _state = TimerState.idlePaused;
    _timer?.cancel();
    _pauseStartTime = DateTime.now();
    
    notifyListeners();
  }
  
  // Resume from idle detection
  void _resumeFromIdle() {
    if (_state != TimerState.idlePaused) return;
    
    _state = TimerState.running;
    
    if (_pauseStartTime != null) {
      final pauseDuration = DateTime.now().difference(_pauseStartTime!);
      _pausedSeconds += pauseDuration.inSeconds;
      
      _pauseRecords.add(PauseRecord(
        startTime: _pauseStartTime!,
        endTime: DateTime.now(),
        reason: 'idle',
      ));
      
      _pauseStartTime = null;
    }
    
    _startTimer();
    notifyListeners();
  }
  
  // Stop and save session
  Future<void> stop() async {
    if (_state == TimerState.stopped) return;
    
    _timer?.cancel();
    _idleDetector?.stop();
    
    if (_currentSession != null) {
      final completedSession = _currentSession!.copyWith(
        endTime: DateTime.now(),
        durationSeconds: _elapsedSeconds,
        pausedSeconds: _pausedSeconds,
        isCompleted: true,
        pauseRecords: _pauseRecords,
      );
      
      await _repository.saveSession(completedSession);
      await _repository.updateStatisticsFromSession(completedSession);
      await _statisticsProvider.refresh();
    }
    
    _state = TimerState.stopped;
    _elapsedSeconds = 0;
    _pausedSeconds = 0;
    _pauseRecords = [];
    _currentSession = null;
    _pauseStartTime = null;
    
    notifyListeners();
  }
  
  // Reset timer without saving
  void reset() {
    _timer?.cancel();
    _idleDetector?.stop();
    
    _state = TimerState.stopped;
    _elapsedSeconds = 0;
    _pausedSeconds = 0;
    _pauseRecords = [];
    _currentSession = null;
    _pauseStartTime = null;
    
    notifyListeners();
  }
  
  // Update idle threshold
  void updateIdleThreshold(int seconds) {
    _idleDetector?.updateThreshold(seconds);
  }
  
  // Update shortcuts
  Future<void> updateShortcuts() async {
    await _registerShortcuts();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _idleDetector?.dispose();
    _shortcutHandler.dispose();
    super.dispose();
  }
}
