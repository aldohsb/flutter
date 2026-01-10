import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pedometer/pedometer.dart';
import '../utils/constants.dart';

class StepCounterService {
  StreamSubscription<StepCount>? _stepCountSubscription;
  Timer? _simulationTimer;
  
  int _simulatedSteps = 0;
  bool _isSimulating = false;
  
  // Check if running on mobile (real sensor available)
  bool get isMobilePlatform {
    return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  }
  
  // Start listening to step counter
  Stream<int> startListening() {
    if (isMobilePlatform) {
      return _startRealSensor();
    } else {
      return _startSimulation();
    }
  }
  
  // Start real sensor (Android/iOS)
  Stream<int> _startRealSensor() {
    final controller = StreamController<int>();
    
    _stepCountSubscription = Pedometer.stepCountStream.listen(
      (StepCount event) {
        controller.add(event.steps);
      },
      onError: (error) {
        controller.addError(error);
      },
    );
    
    return controller.stream;
  }
  
  // Start simulation for Web/Windows
  Stream<int> _startSimulation() {
    final controller = StreamController<int>();
    
    // Initial value
    controller.add(_simulatedSteps);
    
    return controller.stream;
  }
  
  // Start walking simulation (for Web/Windows)
  void startWalkingSimulation(Function(int) onStep) {
    if (_isSimulating) return;
    
    _isSimulating = true;
    _simulationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _simulatedSteps += AppConstants.simulatedStepsPerSecond;
        onStep(_simulatedSteps);
      },
    );
  }
  
  // Stop walking simulation
  void stopWalkingSimulation() {
    _isSimulating = false;
    _simulationTimer?.cancel();
    _simulationTimer = null;
  }
  
  // Add steps manually (for Web/Windows testing)
  void addManualSteps(Function(int) onStep) {
    _simulatedSteps += AppConstants.simulatedStepsPerTap;
    onStep(_simulatedSteps);
  }
  
  // Reset simulated steps
  void resetSimulatedSteps() {
    _simulatedSteps = 0;
    stopWalkingSimulation();
  }
  
  // Get current simulated steps
  int get simulatedSteps => _simulatedSteps;
  
  // Check if currently simulating
  bool get isSimulating => _isSimulating;
  
  // Stop listening
  void stopListening() {
    _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    stopWalkingSimulation();
  }
  
  // Dispose
  void dispose() {
    stopListening();
  }
}