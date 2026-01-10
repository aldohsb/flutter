class DailyGoal {
  final int targetSteps;
  final DateTime lastModified;
  
  DailyGoal({
    required this.targetSteps,
    required this.lastModified,
  });
  
  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'targetSteps': targetSteps,
      'lastModified': lastModified.toIso8601String(),
    };
  }
  
  // Create from JSON
  factory DailyGoal.fromJson(Map<String, dynamic> json) {
    return DailyGoal(
      targetSteps: json['targetSteps'] as int,
      lastModified: DateTime.parse(json['lastModified'] as String),
    );
  }
  
  // Copy with modifications
  DailyGoal copyWith({
    int? targetSteps,
    DateTime? lastModified,
  }) {
    return DailyGoal(
      targetSteps: targetSteps ?? this.targetSteps,
      lastModified: lastModified ?? this.lastModified,
    );
  }
}