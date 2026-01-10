class AppConstants {
  // Default Goals
  static const int defaultDailyStepGoal = 10000;
  static const double defaultCaloriesPerStep = 0.04; // Average calories per step
  static const double defaultStepLength = 0.78; // meters per step (average)
  
  // Storage Keys
  static const String keyTotalSteps = 'total_steps';
  static const String keyDailyGoal = 'daily_goal';
  static const String keyLastResetDate = 'last_reset_date';
  static const String keyStepHistory = 'step_history';
  
  // Simulation (for Web/Windows)
  static const int simulatedStepsPerSecond = 2;
  static const int simulatedStepsPerTap = 10;
  
  // UI
  static const double neumorphicBlur = 30.0;
  static const double neumorphicDistance = 10.0;
}