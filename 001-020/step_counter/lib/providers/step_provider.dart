import 'package:flutter/material.dart';
import '../models/step_data.dart';
import '../models/daily_goal.dart';
import '../services/step_counter_service.dart';
import '../services/storage_service.dart';
import '../services/permission_service.dart';
import '../utils/calculations.dart';
import '../utils/constants.dart';

class StepProvider with ChangeNotifier {
  final StepCounterService _stepService = StepCounterService();
  
  int _todaySteps = 0;
  DailyGoal _dailyGoal = DailyGoal(
    targetSteps: AppConstants.defaultDailyStepGoal,
    lastModified: DateTime.now(),
  );
  
  bool _isListening = false;
  bool _hasPermission = false;
  String? _errorMessage;
  
  // Getters
  int get todaySteps => _todaySteps;
  DailyGoal get dailyGoal => _dailyGoal;
  bool get isListening => _isListening;
  bool get hasPermission => _hasPermission;
  String? get errorMessage => _errorMessage;
  bool get isMobilePlatform => _stepService.isMobilePlatform;
  bool get isSimulating => _stepService.isSimulating;
  
  // Calculated values
  double get calories => StepCalculations.calculateCalories(_todaySteps);
  double get distance => StepCalculations.calculateDistance(_todaySteps);
  double get progress => StepCalculations.calculateProgress(_todaySteps, _dailyGoal.targetSteps);
  
  // Initialize provider
  Future<void> initialize() async {
    // Load saved data
    _todaySteps = StorageService.getTodaySteps();
    _dailyGoal = StorageService.getDailyGoal();
    
    // Check if need to reset (new day)
    if (StorageService.needsReset()) {
      await resetDailyData();
    }
    
    // Check permission
    _hasPermission = await PermissionService.isPermissionGranted();
    
    notifyListeners();
    
    // Auto-start if permission granted and on mobile
    if (_hasPermission && _stepService.isMobilePlatform) {
      await startListening();
    }
  }
  
  // Start listening to step counter
  Future<void> startListening() async {
    if (_isListening) return;
    
    // Request permission if needed
    if (PermissionService.needsPermission() && !_hasPermission) {
      _hasPermission = await PermissionService.requestActivityPermission();
      if (!_hasPermission) {
        _errorMessage = 'Permission denied. Please enable activity recognition in settings.';
        notifyListeners();
        return;
      }
    }
    
    _errorMessage = null;
    _isListening = true;
    notifyListeners();
    
    try {
      _stepService.startListening().listen(
        (steps) {
          _updateSteps(steps);
        },
        onError: (error) {
          _errorMessage = error.toString();
          _isListening = false;
          notifyListeners();
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
      _isListening = false;
      notifyListeners();
    }
  }
  
  // Stop listening
  void stopListening() {
    _stepService.stopListening();
    _isListening = false;
    notifyListeners();
  }
  
  // Update steps
  void _updateSteps(int steps) {
    _todaySteps = steps;
    StorageService.saveTodaySteps(steps);
    notifyListeners();
  }
  
  // Start walking simulation (Web/Windows)
  void startWalkingSimulation() {
    _stepService.startWalkingSimulation((steps) {
      _updateSteps(steps);
    });
    notifyListeners();
  }
  
  // Stop walking simulation
  void stopWalkingSimulation() {
    _stepService.stopWalkingSimulation();
    notifyListeners();
  }
  
  // Add manual steps (Web/Windows)
  void addManualSteps() {
    _stepService.addManualSteps((steps) {
      _updateSteps(steps);
    });
  }
  
  // Update daily goal
  Future<void> updateDailyGoal(int newGoal) async {
    _dailyGoal = _dailyGoal.copyWith(
      targetSteps: newGoal,
      lastModified: DateTime.now(),
    );
    await StorageService.saveDailyGoal(_dailyGoal);
    notifyListeners();
  }
  
  // Reset daily data
  Future<void> resetDailyData() async {
    _todaySteps = 0;
    _stepService.resetSimulatedSteps();
    await StorageService.resetDailySteps();
    notifyListeners();
  }
  
  // Open settings
  Future<void> openSettings() async {
    await PermissionService.openSettings();
  }
  
  @override
  void dispose() {
    _stepService.dispose();
    super.dispose();
  }
}