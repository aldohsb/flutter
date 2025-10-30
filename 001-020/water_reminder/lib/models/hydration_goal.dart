// Model untuk menyimpan data goal/target hidrasi
// Goal adalah achievement yang bisa dicapai user

import 'package:hive/hive.dart';

// Generated code akan dibuat di file .g.dart
part 'hydration_goal.g.dart';

// typeId: 1 karena WaterIntake sudah pakai 0
@HiveType(typeId: 1)
class HydrationGoal extends HiveObject {
  // === PROPERTIES ===
  
  // ID unik goal (misal: 'daily_goal', 'limit_caffeine')
  @HiveField(0)
  String id;
  
  // Judul goal yang ditampilkan ke user
  @HiveField(1)
  String title;
  
  // Deskripsi detail tentang goal
  @HiveField(2)
  String description;
  
  // Icon emoji untuk visual
  @HiveField(3)
  String icon;
  
  // Poin yang didapat kalau goal tercapai
  @HiveField(4)
  int points;
  
  // Target yang harus dicapai (dalam hari)
  // Misal: 7 artinya harus konsisten 7 hari
  @HiveField(5)
  int target;
  
  // Progress saat ini (berapa hari sudah tercapai)
  @HiveField(6)
  int currentProgress;
  
  // Status apakah goal sudah selesai
  @HiveField(7)
  bool isCompleted;
  
  // Tanggal mulai goal
  @HiveField(8)
  DateTime startDate;
  
  // Tanggal selesai goal (null jika belum selesai)
  @HiveField(9)
  DateTime? completedDate;

  // === CONSTRUCTOR ===
  HydrationGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.points,
    required this.target,
    this.currentProgress = 0, // default 0
    this.isCompleted = false, // default false
    required this.startDate,
    this.completedDate,
  });

  // === FACTORY CONSTRUCTORS ===
  
  // Factory untuk membuat goal baru dari template
  factory HydrationGoal.create({
    required String id,
    required String title,
    required String description,
    required String icon,
    required int points,
    required int target,
  }) {
    return HydrationGoal(
      id: id,
      title: title,
      description: description,
      icon: icon,
      points: points,
      target: target,
      currentProgress: 0,
      isCompleted: false,
      startDate: DateTime.now(),
    );
  }

  // Factory untuk membuat goal dari Map (untuk JSON/database)
  factory HydrationGoal.fromMap(Map<String, dynamic> map) {
    return HydrationGoal(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      points: map['points'] as int,
      target: map['target'] as int,
      currentProgress: map['currentProgress'] as int? ?? 0,
      isCompleted: map['isCompleted'] as bool? ?? false,
      startDate: DateTime.parse(map['startDate'] as String),
      completedDate: map['completedDate'] != null
          ? DateTime.parse(map['completedDate'] as String)
          : null,
    );
  }

  // === COMPUTED PROPERTIES ===
  
  // Getter untuk menghitung persentase progress
  // get artinya ini adalah computed property (dihitung saat diakses)
  // toDouble() mengubah int jadi double untuk perhitungan desimal
  double get progressPercentage {
    if (target == 0) return 0; // hindari division by zero
    return (currentProgress / target) * 100;
  }

  // Getter untuk cek apakah goal hampir selesai (>80%)
  bool get isNearlyComplete {
    return progressPercentage >= 80 && !isCompleted;
  }

  // Getter untuk menghitung sisa hari
  int get remainingDays {
    return target - currentProgress;
  }

  // === METHODS ===
  
  // Method untuk update progress
  void updateProgress(int days) {
    currentProgress = days;
    
    // Auto complete jika sudah mencapai target
    if (currentProgress >= target) {
      isCompleted = true;
      completedDate = DateTime.now();
    }
    
    // save() adalah method dari HiveObject
    // Otomatis update data di Hive database
    save();
  }

  // Method untuk increment progress (tambah 1 hari)
  void incrementProgress() {
    currentProgress++;
    
    if (currentProgress >= target) {
      isCompleted = true;
      completedDate = DateTime.now();
    }
    
    save();
  }

  // Method untuk reset goal (mulai dari awal)
  void reset() {
    currentProgress = 0;
    isCompleted = false;
    completedDate = null;
    startDate = DateTime.now();
    save();
  }

  // Method untuk complete goal secara manual
  void complete() {
    currentProgress = target;
    isCompleted = true;
    completedDate = DateTime.now();
    save();
  }

  // Convert ke Map untuk export/JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'points': points,
      'target': target,
      'currentProgress': currentProgress,
      'isCompleted': isCompleted,
      'startDate': startDate.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
    };
  }

  // Copy with method untuk immutability
  HydrationGoal copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    int? points,
    int? target,
    int? currentProgress,
    bool? isCompleted,
    DateTime? startDate,
    DateTime? completedDate,
  }) {
    return HydrationGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      points: points ?? this.points,
      target: target ?? this.target,
      currentProgress: currentProgress ?? this.currentProgress,
      isCompleted: isCompleted ?? this.isCompleted,
      startDate: startDate ?? this.startDate,
      completedDate: completedDate ?? this.completedDate,
    );
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'HydrationGoal(id: $id, title: $title, progress: $currentProgress/$target, completed: $isCompleted)';
  }

  // Override operator ==
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HydrationGoal &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.icon == icon &&
        other.points == points &&
        other.target == target &&
        other.currentProgress == currentProgress &&
        other.isCompleted == isCompleted &&
        other.startDate == startDate &&
        other.completedDate == completedDate;
  }

  // Override hashCode
  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        points.hashCode ^
        target.hashCode ^
        currentProgress.hashCode ^
        isCompleted.hashCode ^
        startDate.hashCode ^
        completedDate.hashCode;
  }
}