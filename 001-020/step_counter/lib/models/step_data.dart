class StepData {
  final int steps;
  final DateTime date;
  final double calories;
  final double distance;
  
  StepData({
    required this.steps,
    required this.date,
    required this.calories,
    required this.distance,
  });
  
  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'date': date.toIso8601String(),
      'calories': calories,
      'distance': distance,
    };
  }
  
  // Create from JSON
  factory StepData.fromJson(Map<String, dynamic> json) {
    return StepData(
      steps: json['steps'] as int,
      date: DateTime.parse(json['date'] as String),
      calories: json['calories'] as double,
      distance: json['distance'] as double,
    );
  }
  
  // Check if date is today
  bool isToday() {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
  
  // Copy with modifications
  StepData copyWith({
    int? steps,
    DateTime? date,
    double? calories,
    double? distance,
  }) {
    return StepData(
      steps: steps ?? this.steps,
      date: date ?? this.date,
      calories: calories ?? this.calories,
      distance: distance ?? this.distance,
    );
  }
}