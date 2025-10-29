class NotificationSettingModel {
  final int? id;
  final int userId;
  final String time; // Format: HH:mm (24 hour)
  final bool isEnabled;
  final DateTime? createdAt;

  NotificationSettingModel({
    this.id,
    required this.userId,
    required this.time,
    this.isEnabled = true,
    this.createdAt,
  });

  // Get hour from time string
  int get hour {
    final parts = time.split(':');
    return int.parse(parts[0]);
  }

  // Get minute from time string
  int get minute {
    final parts = time.split(':');
    return int.parse(parts[1]);
  }

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'time': time,
      'is_enabled': isEnabled ? 1 : 0,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  // Create from Map
  factory NotificationSettingModel.fromMap(Map<String, dynamic> map) {
    return NotificationSettingModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      time: map['time'] as String,
      isEnabled: (map['is_enabled'] as int) == 1,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
    );
  }

  // Copy with
  NotificationSettingModel copyWith({
    int? id,
    int? userId,
    String? time,
    bool? isEnabled,
    DateTime? createdAt,
  }) {
    return NotificationSettingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}